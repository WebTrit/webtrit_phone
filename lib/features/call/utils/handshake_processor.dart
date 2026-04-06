import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

/// Actions returned by [HandshakeProcessor.process] describing what the BLoC
/// should do after processing the signaling [StateHandshake].
sealed class HandshakeAction {
  const HandshakeAction();
}

/// Send a [HangupRequest] to the signaling server and stop processing.
///
/// Emitted when the Callkeep connection for the line is [CallkeepConnectionState.stateDisconnected]
/// and the latest call event is [AcceptedEvent] or [ProceedingEvent].
final class HangupSignalingAction extends HandshakeAction {
  const HangupSignalingAction({required this.line, required this.callId});

  final int? line;
  final String callId;
}

/// Send a [DeclineRequest] to the signaling server and stop processing.
///
/// Emitted when the Callkeep connection for the line is [CallkeepConnectionState.stateDisconnected]
/// and the latest call event is [IncomingCallEvent].
final class DeclineSignalingAction extends HandshakeAction {
  const DeclineSignalingAction({required this.line, required this.callId});

  final int? line;
  final String callId;
}

/// Re-negotiate WebRTC media for an already-accepted incoming call.
///
/// Emitted when the handshake contains both [IncomingCallEvent] (oldest) and [AcceptedEvent]
/// (newest) for a line, the Callkeep connection is absent, and the call is not already in
/// the BLoC state. This covers the case of Android Activity recreation during an active call.
final class RestoreCallAction extends HandshakeAction {
  const RestoreCallAction({
    required this.line,
    required this.callId,
    required this.incomingCallEvent,
    required this.acceptedTime,
  });

  final int line;
  final String callId;
  final IncomingCallEvent incomingCallEvent;
  final DateTime acceptedTime;
}

/// Deliver an unanswered [IncomingCallEvent] to the BLoC signaling handler.
///
/// Emitted when the line's [callLogs] contains a single [CallEventLog] carrying
/// an [IncomingCallEvent] -the call has not been answered yet.
final class HandleIncomingCallAction extends HandshakeAction {
  const HandleIncomingCallAction({required this.event});

  final IncomingCallEvent event;
}

/// Call [Callkeep.endCall] for a local connection that is no longer present in
/// the signaling state.
final class EndLocalCallAction extends HandshakeAction {
  const EndLocalCallAction({required this.callId});

  final String callId;
}

/// Processes a [StateHandshake] and returns the list of [HandshakeAction]s the
/// BLoC should execute.
///
/// Separating the decision logic from execution (signaling calls, callkeep calls,
/// BLoC event dispatch) keeps this class free of side effects and makes it
/// straightforward to unit-test with only a mocked [CallkeepConnections].
///
/// The processor handles two loops from the original [CallBloc._handleHandshakeReceived]:
///
/// **Loop B -per-line decisions:**
/// - If the Callkeep connection is [CallkeepConnectionState.stateDisconnected] and
///   the latest event is [AcceptedEvent]/[ProceedingEvent] -> [HangupSignalingAction].
/// - If the Callkeep connection is [CallkeepConnectionState.stateDisconnected] and
///   the latest event is [IncomingCallEvent] -> [DeclineSignalingAction].
/// - If the call was accepted ([AcceptedEvent] newest, [IncomingCallEvent] oldest)
///   with no local connection -> [RestoreCallAction].
/// - If only a single unanswered [IncomingCallEvent] is present -> [HandleIncomingCallAction].
///
/// **Loop C -orphaned local connections:**
/// - For each local Callkeep connection whose call ID is absent from the handshake
///   lines -> [EndLocalCallAction].
///
/// [HangupSignalingAction] and [DeclineSignalingAction] are always returned as the
/// sole action -the processor exits early to match the original `return` semantics.
class HandshakeProcessor {
  HandshakeProcessor({required this.callkeepConnections});

  final CallkeepConnections callkeepConnections;

  Future<List<HandshakeAction>> process({
    required List<Line?> lines,
    required Line? guestLine,
    required Set<String> activeCallIds,
  }) async {
    final actions = <HandshakeAction>[];
    final allLines = [...lines, guestLine].whereType<Line>().toList();
    final localConnections = await callkeepConnections.getConnections();

    for (final activeLine in allLines) {
      // Get the newest call event from the call logs, if any.
      final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

      CallkeepConnection? connection;
      if (callEvent != null) {
        connection = await callkeepConnections.getConnection(callEvent.callId);

        if (connection?.state == CallkeepConnectionState.stateDisconnected) {
          if (callEvent is AcceptedEvent || callEvent is ProceedingEvent) {
            // Early exit: only this action, consistent with the original `return` in the BLoC.
            return [HangupSignalingAction(line: callEvent.line, callId: callEvent.callId)];
          } else if (callEvent is IncomingCallEvent) {
            // Early exit: only this action.
            return [DeclineSignalingAction(line: callEvent.line, callId: callEvent.callId)];
          }
        }
      }

      // Restore an accepted incoming call after Activity recreation.
      //
      // callLogs is newest-first:
      //   firstOrNull -> AcceptedEvent  (latest)
      //   lastOrNull  -> IncomingCallEvent (earliest / original offer)
      final callEventLogEntries = activeLine.callLogs.whereType<CallEventLog>().toList();
      final latestCallLog = callEventLogEntries.firstOrNull;
      final earliestCallLog = callEventLogEntries.lastOrNull;
      final latestCallEvent = latestCallLog?.callEvent;
      final earliestCallEvent = earliestCallLog?.callEvent;

      if (earliestCallEvent is IncomingCallEvent &&
          earliestCallEvent.line != null &&
          latestCallEvent is AcceptedEvent &&
          connection == null &&
          !activeCallIds.contains(activeLine.callId)) {
        actions.add(
          RestoreCallAction(
            line: earliestCallEvent.line!,
            callId: activeLine.callId,
            incomingCallEvent: earliestCallEvent,
            acceptedTime: DateTime.fromMillisecondsSinceEpoch(latestCallLog!.timestamp),
          ),
        );
        continue;
      }

      if (activeLine.callLogs.length == 1) {
        final singleCallLog = activeLine.callLogs.first;
        if (singleCallLog is CallEventLog && singleCallLog.callEvent is IncomingCallEvent) {
          actions.add(HandleIncomingCallAction(event: singleCallLog.callEvent as IncomingCallEvent));
        }
      }
    }

    // Synchronize local connections: end any that are absent from the signaling state.
    final lineCallIds = allLines.map((l) => l.callId).toSet();
    for (final connection in localConnections) {
      if (!lineCallIds.contains(connection.callId)) {
        actions.add(EndLocalCallAction(callId: connection.callId));
      }
    }

    return actions;
  }
}
