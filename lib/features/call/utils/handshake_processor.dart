import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

/// Actions returned by [HandshakeProcessor.process] describing what the BLoC
/// should do after processing the signaling [StateHandshake].
sealed class HandshakeAction {
  const HandshakeAction();
}

/// Send a [HangupRequest] to the signaling server and stop processing.
///
/// Emitted in two cases:
/// 1. The Callkeep connection is [CallkeepConnectionState.stateDisconnected] and
///    the latest call event is neither [HangupEvent] nor [MissedCallEvent]
///    (i.e. the call was live when the connection dropped).
/// 2. The Callkeep connection is null (removed or iOS), the call is not tracked
///    in BLoC state, has no [AcceptedEvent] in its log, and the latest event is
///    not a terminal or incoming event — i.e. an orphaned outgoing call whose
///    [HangupRequest] was lost while the device was offline.
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
/// Emitted when the call log contains an [AcceptedEvent] (anywhere in the list,
/// not necessarily the latest — re-INVITE puts [UpdatedEvent] on top), the call is
/// not server-terminated ([HangupEvent]/[MissedCallEvent] as the latest entry),
/// [AcceptedEvent.line] is non-null, and the call is not already tracked in BLoC state.
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
/// Emitted when the line has not been terminated, has no [AcceptedEvent], the
/// earliest call log entry is an [IncomingCallEvent], and the call is not yet
/// tracked in BLoC state.
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
///   the latest event is [IncomingCallEvent] -> [DeclineSignalingAction].
/// - If the Callkeep connection is [CallkeepConnectionState.stateDisconnected] and
///   the latest event is not [HangupEvent]/[MissedCallEvent] -> [HangupSignalingAction].
/// - If the log contains an [AcceptedEvent] (non-terminated call, not yet in BLoC) -> [RestoreCallAction]
///   (covers both incoming and outgoing calls; [AcceptedEvent] may not be the newest entry after re-INVITE).
/// - If the earliest log is an unanswered [IncomingCallEvent] (not terminated, not accepted, not in BLoC) -> [HandleIncomingCallAction].
///
/// **Loop C -orphaned local connections:**
/// - For each local Callkeep connection whose call ID is absent from the handshake
///   lines -> [EndLocalCallAction].
///
/// When queued terminations exist in the repository, they are emitted first as
/// regular [HangupSignalingAction]/[DeclineSignalingAction] entries, removed
/// from the repository immediately, and excluded from subsequent handshake-line
/// processing.
///
/// If a terminal disconnected-state action is produced during line traversal,
/// the processor exits early to match the original `return` semantics, while
/// preserving any already-collected queued actions.
class HandshakeProcessor {
  HandshakeProcessor({required this.callkeepConnections, required this.queuedTerminationRequestsRepository});

  final CallkeepConnections callkeepConnections;
  final QueuedTerminationRequestsRepository queuedTerminationRequestsRepository;

  Future<List<HandshakeAction>> process({
    required List<Line?> lines,
    required Line? guestLine,
    required Set<String> activeCallIds,
  }) async {
    final actions = <HandshakeAction>[];

    /// Prepare termination queue actions
    final queuedTerminationCallIds = <String>{};
    final queuedTerminationRequests = queuedTerminationRequestsRepository.getAll;

    for (final request in queuedTerminationRequests.values) {
      switch (request.type) {
        case QueuedTerminationRequestType.hangup:
          actions.add(HangupSignalingAction(line: request.line, callId: request.callId));
        case QueuedTerminationRequestType.decline:
          actions.add(DeclineSignalingAction(line: request.line, callId: request.callId));
      }
      queuedTerminationRequestsRepository.remove(request);
      queuedTerminationCallIds.add(request.callId);
    }

    /// Prepare callkeep connections actions
    final allLines = [
      ...lines,
      guestLine,
    ].whereType<Line>().where((line) => !queuedTerminationCallIds.contains(line.callId)).toList();
    final localConnections = await callkeepConnections.getConnections();

    for (final activeLine in allLines) {
      // callLogs is newest-first: firstOrNull = latest, lastOrNull = earliest.
      // Materialise once and reuse for both the connection guards below and the
      // restoration logic further down to avoid redundant traversals.
      final callEventLogEntries = activeLine.callLogs.whereType<CallEventLog>().toList();
      final callEvent = callEventLogEntries.firstOrNull?.callEvent; // latest event
      final earliestCallEvent = callEventLogEntries.lastOrNull?.callEvent;

      // AcceptedEvent may not be the latest entry after a re-INVITE or transfer -
      // search the full log list rather than checking only the newest entry.
      final acceptedLogEntry = callEventLogEntries.where((log) => log.callEvent is AcceptedEvent).firstOrNull;

      CallkeepConnection? connection;
      if (callEvent != null) {
        connection = await callkeepConnections.getConnection(callEvent.callId);

        if (connection?.state == CallkeepConnectionState.stateDisconnected) {
          if (callEvent is IncomingCallEvent) {
            return [...actions, DeclineSignalingAction(line: callEvent.line, callId: callEvent.callId)];
          } else if (callEvent is! HangupEvent && callEvent is! MissedCallEvent) {
            return [...actions, HangupSignalingAction(line: callEvent.line, callId: callEvent.callId)];
          }
        } else if (connection == null &&
            !activeCallIds.contains(activeLine.callId) &&
            earliestCallEvent is! IncomingCallEvent &&
            callEvent is! HangupEvent &&
            callEvent is! MissedCallEvent &&
            acceptedLogEntry == null) {
          // Orphaned outgoing call: the server still has the call but both
          // CallKeep and BLoC have no record of it. This happens when the user
          // hangs up while offline — performEndCall removed the local state but
          // the HangupRequest never reached the server.
          //
          // earliestCallEvent (not callEvent/latest) is used to identify the
          // call direction: after a ProceedingEvent or RingingEvent the latest
          // entry is no longer IncomingCallEvent, so using callEvent here would
          // incorrectly trigger HangupSignalingAction for unanswered incoming calls.
          //
          // acceptedLogEntry == null ensures we never hang up a call that should
          // be restored (app-restart case where connection is null but the call
          // was previously accepted).
          //
          // On iOS getConnection() always returns null, so activeCallIds is the
          // decisive guard: calls that are still active in BLoC are not affected.
          return [...actions, HangupSignalingAction(line: callEvent.line, callId: callEvent.callId)];
        }
      }

      // A call is server-terminated when the latest event is a final hangup or missed.
      final isTerminated = callEvent is HangupEvent || callEvent is MissedCallEvent;

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

      // Unanswered incoming call: deliver the IncomingCallEvent to the BLoC so
      // it can set up the call state and surface the ringing UI.
      //
      // earliestCallEvent (not callEvent/latest) identifies the call direction
      // because SIP UAs — notably iOS CallKit — append RingingEvent or
      // ProceedingEvent almost immediately after the call is placed. By the time
      // a WebSocket reconnect completes and a new StateHandshake arrives, the
      // server log already contains multiple entries (e.g. [RingingEvent,
      // IncomingCallEvent]). Using the latest entry would misidentify those calls.
      //
      // Guard rationale:
      // - !isTerminated           : skip calls the server already ended.
      // - acceptedLogEntry == null: accepted calls are handled by RestoreCallAction above.
      // - earliestCallEvent is IncomingCallEvent: confirms the call is incoming, not outgoing.
      // - !activeCallIds.contains : skip calls already tracked in BLoC state to avoid
      //   re-triggering the incoming-call flow for an already-ringing call.
      if (!isTerminated &&
          acceptedLogEntry == null &&
          earliestCallEvent is IncomingCallEvent &&
          !activeCallIds.contains(activeLine.callId)) {
        actions.add(HandleIncomingCallAction(event: earliestCallEvent));
      }
    }

    final lineCallIds = allLines.map((l) => l.callId).toSet();
    for (final connection in localConnections) {
      if (!lineCallIds.contains(connection.callId) && !activeCallIds.contains(connection.callId)) {
        actions.add(EndLocalCallAction(callId: connection.callId));
      }
    }

    return actions;
  }
}
