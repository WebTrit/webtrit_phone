import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/features/call/utils/handshake_processor.dart';

// ---------------------------------------------------------------------------
// Mocks
// ---------------------------------------------------------------------------

class MockCallkeepConnections extends Mock implements CallkeepConnections {}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

const _kCallId = 'call-abc';
const _kLine = 0;

IncomingCallEvent _makeIncomingEvent({int line = _kLine, String callId = _kCallId}) {
  return IncomingCallEvent(line: line, callId: callId, callee: 'callee', caller: '1234');
}

AcceptedEvent _makeAcceptedEvent({int? line = _kLine, String callId = _kCallId}) {
  return AcceptedEvent(line: line, callId: callId);
}

ProceedingEvent _makeProceedingEvent({int? line = _kLine, String callId = _kCallId}) {
  return ProceedingEvent(line: line, callId: callId, code: 180);
}

Line _makeLine({String callId = _kCallId, required List<CallLog> callLogs}) {
  return Line(callId: callId, callLogs: callLogs);
}

CallkeepConnection _makeConnection({
  String callId = _kCallId,
  CallkeepConnectionState state = CallkeepConnectionState.stateActive,
}) {
  return CallkeepConnection(callId: callId, state: state, disconnectCause: null);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late MockCallkeepConnections mockConnections;
  late HandshakeProcessor processor;

  setUp(() {
    mockConnections = MockCallkeepConnections();
    processor = HandshakeProcessor(callkeepConnections: mockConnections);

    // Default: no local connections, no connection for any callId.
    when(() => mockConnections.getConnections()).thenAnswer((_) async => []);
    when(() => mockConnections.getConnection(any())).thenAnswer((_) async => null);
  });

  // -------------------------------------------------------------------------
  // Empty handshake
  // -------------------------------------------------------------------------

  group('empty handshake', () {
    test('returns empty list when lines is empty', () async {
      final actions = await processor.process(lines: [], guestLine: null, activeCallIds: {});
      expect(actions, isEmpty);
    });

    test('returns empty list when all lines are null', () async {
      final actions = await processor.process(lines: [null, null], guestLine: null, activeCallIds: {});
      expect(actions, isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // Unanswered incoming call (single CallEventLog)
  // -------------------------------------------------------------------------

  group('single unanswered IncomingCallEvent', () {
    test('returns HandleIncomingCallAction', () async {
      final line = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<HandleIncomingCallAction>());
      final a = actions.first as HandleIncomingCallAction;
      expect(a.event.callId, _kCallId);
    });
  });

  // -------------------------------------------------------------------------
  // Restoration: AcceptedEvent (newest) + IncomingCallEvent (oldest)
  // -------------------------------------------------------------------------

  group('restoration candidate', () {
    Line makeRestorationLine() => _makeLine(
      callLogs: [
        CallEventLog(timestamp: 2000, callEvent: _makeAcceptedEvent()),
        CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent()),
      ],
    );

    test('returns RestoreCallAction when connection is null and call not in state', () async {
      final line = makeRestorationLine();
      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<RestoreCallAction>());
      final a = actions.first as RestoreCallAction;
      expect(a.callId, _kCallId);
      expect(a.line, _kLine);
      expect(a.acceptedTime, DateTime.fromMillisecondsSinceEpoch(2000));
    });

    test('uses AcceptedEvent timestamp (newest) as acceptedTime', () async {
      final line = _makeLine(
        callLogs: [
          CallEventLog(timestamp: 9999, callEvent: _makeAcceptedEvent()),
          CallEventLog(timestamp: 1111, callEvent: _makeIncomingEvent()),
        ],
      );

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      final a = actions.first as RestoreCallAction;
      expect(a.acceptedTime, DateTime.fromMillisecondsSinceEpoch(9999));
    });

    test('skips restoration when callId already in activeCallIds', () async {
      final line = makeRestorationLine();
      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {_kCallId});

      expect(actions, isEmpty);
    });

    test(
      'returns RestoreCallAction when Callkeep connection survived (stateActive) but call not in BLoC state',
      () async {
        when(
          () => mockConnections.getConnection(_kCallId),
        ).thenAnswer((_) async => _makeConnection(state: CallkeepConnectionState.stateActive));

        final line = makeRestorationLine();
        final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

        expect(actions, hasLength(1));
        expect(actions.first, isA<RestoreCallAction>());
      },
    );

    test(
      'skips restoration when Callkeep connection is stateDisconnected (handled by HangupSignalingAction above)',
      () async {
        when(
          () => mockConnections.getConnection(_kCallId),
        ).thenAnswer((_) async => _makeConnection(state: CallkeepConnectionState.stateDisconnected));

        // stateDisconnected with AcceptedEvent -> early exit with HangupSignalingAction, not RestoreCallAction
        final line = makeRestorationLine();
        final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

        expect(actions.whereType<RestoreCallAction>(), isEmpty);
      },
    );

    test('skips restoration when AcceptedEvent.line is null (guest-line call)', () async {
      final line = _makeLine(
        callLogs: [
          CallEventLog(timestamp: 2000, callEvent: _makeAcceptedEvent(line: null)),
          CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent()),
        ],
      );

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions.whereType<RestoreCallAction>(), isEmpty);
    });

    test('returns RestoreCallAction after re-INVITE: UpdatedEvent newest, AcceptedEvent in logs', () async {
      // After a re-INVITE (transfer or SDP update) the server puts UpdatedEvent as the newest entry.
      // AcceptedEvent is no longer first but must still be found to trigger restoration.
      final line = _makeLine(
        callLogs: [
          CallEventLog(
            timestamp: 3000,
            callEvent: UpdatedEvent(line: _kLine, callId: _kCallId),
          ),
          CallEventLog(timestamp: 2000, callEvent: _makeAcceptedEvent()),
          CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent()),
        ],
      );

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<RestoreCallAction>());
      final a = actions.first as RestoreCallAction;
      expect(a.callId, _kCallId);
      expect(a.incomingCallEvent, isNotNull);
    });

    test('skips restoration when HangupEvent is the latest (call server-terminated)', () async {
      final line = _makeLine(
        callLogs: [
          CallEventLog(
            timestamp: 3000,
            callEvent: HangupEvent(line: _kLine, callId: _kCallId, code: 200, reason: 'OK'),
          ),
          CallEventLog(timestamp: 2000, callEvent: _makeAcceptedEvent()),
          CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent()),
        ],
      );

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions.whereType<RestoreCallAction>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // Restoration: outgoing call (single AcceptedEvent, no IncomingCallEvent)
  // -------------------------------------------------------------------------

  group('outgoing call restoration', () {
    test('returns RestoreCallAction with incomingCallEvent null', () async {
      final line = _makeLine(callLogs: [CallEventLog(timestamp: 5000, callEvent: _makeAcceptedEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<RestoreCallAction>());
      final a = actions.first as RestoreCallAction;
      expect(a.callId, _kCallId);
      expect(a.line, _kLine);
      expect(a.acceptedTime, DateTime.fromMillisecondsSinceEpoch(5000));
      expect(a.incomingCallEvent, isNull);
    });

    test('skips restoration when callId already in activeCallIds', () async {
      final line = _makeLine(callLogs: [CallEventLog(timestamp: 5000, callEvent: _makeAcceptedEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {_kCallId});

      expect(actions, isEmpty);
    });

    test('skips restoration when AcceptedEvent.line is null', () async {
      final line = _makeLine(callLogs: [CallEventLog(timestamp: 5000, callEvent: _makeAcceptedEvent(line: null))]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions.whereType<RestoreCallAction>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // stateDisconnected connection - HangupSignalingAction
  // -------------------------------------------------------------------------

  group('stateDisconnected with AcceptedEvent', () {
    test('returns only HangupSignalingAction (early exit)', () async {
      when(
        () => mockConnections.getConnection(_kCallId),
      ).thenAnswer((_) async => _makeConnection(state: CallkeepConnectionState.stateDisconnected));

      final line = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeAcceptedEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<HangupSignalingAction>());
      final a = actions.first as HangupSignalingAction;
      expect(a.callId, _kCallId);
      expect(a.line, _kLine);
    });

    test('returns only HangupSignalingAction for ProceedingEvent', () async {
      when(
        () => mockConnections.getConnection(_kCallId),
      ).thenAnswer((_) async => _makeConnection(state: CallkeepConnectionState.stateDisconnected));

      final line = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeProceedingEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<HangupSignalingAction>());
    });

    test('early exit: EndLocalCallAction is NOT generated even if orphaned connections exist', () async {
      when(
        () => mockConnections.getConnection(_kCallId),
      ).thenAnswer((_) async => _makeConnection(state: CallkeepConnectionState.stateDisconnected));
      when(() => mockConnections.getConnections()).thenAnswer((_) async => [_makeConnection(callId: 'orphan-id')]);

      final line = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeAcceptedEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.whereType<EndLocalCallAction>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // stateDisconnected connection - DeclineSignalingAction
  // -------------------------------------------------------------------------

  group('stateDisconnected with IncomingCallEvent', () {
    test('returns only DeclineSignalingAction (early exit)', () async {
      when(
        () => mockConnections.getConnection(_kCallId),
      ).thenAnswer((_) async => _makeConnection(state: CallkeepConnectionState.stateDisconnected));

      final line = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<DeclineSignalingAction>());
      final a = actions.first as DeclineSignalingAction;
      expect(a.callId, _kCallId);
    });
  });

  // -------------------------------------------------------------------------
  // Orphaned local connections - EndLocalCallAction
  // -------------------------------------------------------------------------

  group('local connection not in handshake', () {
    test('returns EndLocalCallAction for each orphaned local connection', () async {
      when(
        () => mockConnections.getConnections(),
      ).thenAnswer((_) async => [_makeConnection(callId: 'orphan-1'), _makeConnection(callId: 'orphan-2')]);

      final actions = await processor.process(lines: [], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(2));
      expect(actions.every((a) => a is EndLocalCallAction), isTrue);
      final ids = actions.cast<EndLocalCallAction>().map((a) => a.callId).toSet();
      expect(ids, {'orphan-1', 'orphan-2'});
    });

    test('does NOT return EndLocalCallAction when local connection callId is in handshake', () async {
      when(() => mockConnections.getConnections()).thenAnswer((_) async => [_makeConnection(callId: _kCallId)]);

      final line = _makeLine(callLogs: []);
      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions.whereType<EndLocalCallAction>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // Orphaned outgoing call (connection == null, not in BLoC, no AcceptedEvent)
  // -------------------------------------------------------------------------

  group('orphaned outgoing call — null connection, absent from BLoC', () {
    test('returns HangupSignalingAction for unanswered outgoing call (ProceedingEvent)', () async {
      // connection is null (CallKeep entry was removed by performEndCall)
      // call is not in activeCallIds (BLoC also removed it)
      // server still has it with ProceedingEvent → HangupRequest must be sent
      final line = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeProceedingEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<HangupSignalingAction>());
      final a = actions.first as HangupSignalingAction;
      expect(a.callId, _kCallId);
      expect(a.line, _kLine);
    });

    test('does NOT return HangupSignalingAction when call is still in BLoC activeCallIds (iOS guard)', () async {
      // On iOS getConnection() always returns null.
      // If the call IS in activeCalls the user is still in the call — must not hang up.
      final line = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeProceedingEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {_kCallId});

      expect(actions.whereType<HangupSignalingAction>(), isEmpty);
    });

    test('does NOT interfere with restoration: accepted call with null connection returns RestoreCallAction', () async {
      // App-restart case: connection is null but AcceptedEvent is in logs.
      // Must produce RestoreCallAction, not HangupSignalingAction.
      final line = _makeLine(
        callLogs: [
          CallEventLog(timestamp: 2000, callEvent: _makeAcceptedEvent()),
          CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent()),
        ],
      );

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions.whereType<HangupSignalingAction>(), isEmpty);
      expect(actions.whereType<RestoreCallAction>(), hasLength(1));
    });

    test('does NOT return HangupSignalingAction for IncomingCallEvent with null connection', () async {
      // Unanswered incoming call with no connection — HandleIncomingCallAction path, not hangup.
      final line = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent())]);

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions.whereType<HangupSignalingAction>(), isEmpty);
    });

    test('does NOT return HangupSignalingAction when server latest event is HangupEvent', () async {
      final line = _makeLine(
        callLogs: [
          CallEventLog(
            timestamp: 2000,
            callEvent: HangupEvent(line: _kLine, callId: _kCallId, code: 487, reason: 'Request Terminated'),
          ),
          CallEventLog(timestamp: 1000, callEvent: _makeProceedingEvent()),
        ],
      );

      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions.whereType<HangupSignalingAction>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // guestLine is treated like a regular line
  // -------------------------------------------------------------------------

  group('guestLine', () {
    test('processes guestLine the same as regular lines', () async {
      final guestLine = _makeLine(callLogs: [CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent())]);

      final actions = await processor.process(lines: [], guestLine: guestLine, activeCallIds: {});

      expect(actions, hasLength(1));
      expect(actions.first, isA<HandleIncomingCallAction>());
    });
  });
}
