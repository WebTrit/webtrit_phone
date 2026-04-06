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

/// Re-negotiate WebRTC media for an already-accepted call after app restart.
///
/// Emitted when the latest call log entry is [AcceptedEvent], the Callkeep connection
/// is absent, and the call is not already in the BLoC state.
/// - [incomingCallEvent] is non-null for incoming calls (provides offer SDP and caller).
/// - [incomingCallEvent] is null for outgoing calls (callee is taken from [acceptedEvent]).
final class RestoreCallAction extends HandshakeAction {
  const RestoreCallAction({
    required this.line,
    required this.callId,
    required this.acceptedEvent,
    required this.acceptedTime,
    this.incomingCallEvent,
  });

  final int line;
  final String callId;
  final AcceptedEvent acceptedEvent;
  final DateTime acceptedTime;
  final IncomingCallEvent? incomingCallEvent;
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
/// - If the latest event is [AcceptedEvent] with no local connection -> [RestoreCallAction]
///   (covers both incoming and outgoing calls).
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
      final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

      CallkeepConnection? connection;
      if (callEvent != null) {
        connection = await callkeepConnections.getConnection(callEvent.callId);

        if (connection?.state == CallkeepConnectionState.stateDisconnected) {
          if (callEvent is IncomingCallEvent) {
            return [DeclineSignalingAction(line: callEvent.line, callId: callEvent.callId)];
          } else if (callEvent is! HangupEvent && callEvent is! MissedCallEvent) {
            return [HangupSignalingAction(line: callEvent.line, callId: callEvent.callId)];
          }
        }
      }

      // callLogs is newest-first: firstOrNull = latest, lastOrNull = earliest.
      final callEventLogEntries = activeLine.callLogs.whereType<CallEventLog>().toList();
      final latestCallEvent = callEventLogEntries.firstOrNull?.callEvent;
      final earliestCallEvent = callEventLogEntries.lastOrNull?.callEvent;

      // AcceptedEvent may not be the latest entry after a re-INVITE or transfer -
      // search the full log list rather than checking only the newest entry.
      final acceptedLogEntry = callEventLogEntries.where((log) => log.callEvent is AcceptedEvent).firstOrNull;

      // A call is server-terminated when the latest event is a final hangup or missed.
      final isTerminated = latestCallEvent is HangupEvent || latestCallEvent is MissedCallEvent;

      if (!isTerminated &&
          acceptedLogEntry != null &&
          (acceptedLogEntry.callEvent as AcceptedEvent).line != null &&
          !activeCallIds.contains(activeLine.callId)) {
        final acceptedEvent = acceptedLogEntry.callEvent as AcceptedEvent;
        actions.add(
          RestoreCallAction(
            line: acceptedEvent.line!,
            callId: activeLine.callId,
            acceptedEvent: acceptedEvent,
            acceptedTime: DateTime.fromMillisecondsSinceEpoch(acceptedLogEntry.timestamp),
            incomingCallEvent: earliestCallEvent is IncomingCallEvent ? earliestCallEvent : null,
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

    final lineCallIds = allLines.map((l) => l.callId).toSet();
    for (final connection in localConnections) {
      if (!lineCallIds.contains(connection.callId)) {
        actions.add(EndLocalCallAction(callId: connection.callId));
      }
    }

    return actions;
  }
}
