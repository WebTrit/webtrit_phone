import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/features/call/bloc/handshake_action.dart';
import 'package:webtrit_phone/features/call/bloc/handshake_processor.dart';

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
    Line _makeRestorationLine() => _makeLine(
      callLogs: [
        CallEventLog(timestamp: 2000, callEvent: _makeAcceptedEvent()),
        CallEventLog(timestamp: 1000, callEvent: _makeIncomingEvent()),
      ],
    );

    test('returns RestoreCallAction when connection is null and call not in state', () async {
      final line = _makeRestorationLine();
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
      final line = _makeRestorationLine();
      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {_kCallId});

      expect(actions, isEmpty);
    });

    test('skips restoration when connection is not null', () async {
      when(() => mockConnections.getConnection(_kCallId)).thenAnswer((_) async => _makeConnection());

      final line = _makeRestorationLine();
      final actions = await processor.process(lines: [line], guestLine: null, activeCallIds: {});

      expect(actions, isEmpty);
    });

    test('skips restoration when IncomingCallEvent.line is null (guest-line call)', () async {
      // IncomingCallEvent with line == null — not restorable.
      final incomingWithNullLine = IncomingCallEvent(line: null, callId: _kCallId, callee: 'callee', caller: '1234');
      final lineWithNullLine = _makeLine(
        callLogs: [
          CallEventLog(timestamp: 2000, callEvent: _makeAcceptedEvent()),
          CallEventLog(timestamp: 1000, callEvent: incomingWithNullLine),
        ],
      );

      final actions = await processor.process(lines: [lineWithNullLine], guestLine: null, activeCallIds: {});

      expect(actions, isEmpty);
    });

    test('this specific order (newest=AcceptedEvent, oldest=IncomingCallEvent) is required', () async {
      // Swapped order: oldest=AcceptedEvent, newest=IncomingCallEvent — must NOT trigger restore.
      final lineSwapped = _makeLine(
        callLogs: [
          CallEventLog(timestamp: 2000, callEvent: _makeIncomingEvent()), // newest = IncomingCallEvent
          CallEventLog(timestamp: 1000, callEvent: _makeAcceptedEvent()), // oldest = AcceptedEvent
        ],
      );

      final actions = await processor.process(lines: [lineSwapped], guestLine: null, activeCallIds: {});

      // Should produce HandleIncomingCallAction only if single log, otherwise nothing.
      // With 2 logs none of the conditions match.
      expect(actions.whereType<RestoreCallAction>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // stateDisconnected connection — HangupSignalingAction
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
  // stateDisconnected connection — DeclineSignalingAction
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
  // Orphaned local connections — EndLocalCallAction
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
