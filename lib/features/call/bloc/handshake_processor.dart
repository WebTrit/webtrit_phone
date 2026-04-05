import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'handshake_action.dart';

/// Processes a [StateHandshake] and returns the list of [HandshakeAction]s the
/// BLoC should execute.
///
/// Separating the decision logic from execution (signaling calls, callkeep calls,
/// BLoC event dispatch) keeps this class free of side effects and makes it
/// straightforward to unit-test with only a mocked [CallkeepConnections].
///
/// The processor handles two loops from the original [CallBloc._handleHandshakeReceived]:
///
/// **Loop B — per-line decisions:**
/// - If the Callkeep connection is [CallkeepConnectionState.stateDisconnected] and
///   the latest event is [AcceptedEvent]/[ProceedingEvent] → [HangupSignalingAction].
/// - If the Callkeep connection is [CallkeepConnectionState.stateDisconnected] and
///   the latest event is [IncomingCallEvent] → [DeclineSignalingAction].
/// - If the call was accepted ([AcceptedEvent] newest, [IncomingCallEvent] oldest)
///   with no local connection → [RestoreCallAction].
/// - If only a single unanswered [IncomingCallEvent] is present → [HandleIncomingCallAction].
///
/// **Loop C — orphaned local connections:**
/// - For each local Callkeep connection whose call ID is absent from the handshake
///   lines → [EndLocalCallAction].
///
/// [HangupSignalingAction] and [DeclineSignalingAction] are always returned as the
/// sole action — the processor exits early to match the original `return` semantics.
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

      // WT-1167 Subtask 2: restore an accepted incoming call after Activity recreation.
      //
      // callLogs is newest-first:
      //   firstOrNull → AcceptedEvent  (latest)
      //   lastOrNull  → IncomingCallEvent (earliest / original offer)
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
