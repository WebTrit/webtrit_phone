import 'package:fake_async/fake_async.dart';
import 'package:flutter/widgets.dart' hide Notification;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/features/call/models/models.dart';
import 'package:webtrit_phone/models/models.dart';

import 'helpers/call_bloc_test_helpers.dart';
import 'helpers/fake_signaling_client.dart';

// ---------------------------------------------------------------------------
// Fallback values required by mocktail
// ---------------------------------------------------------------------------

class _FakeLinesState extends Fake implements LinesState {}

class _FakeCallkeepHandle extends Fake implements CallkeepHandle {}

// NewCall is a record typedef — register a concrete instance as a fallback.
final _fakeNewCall = (
  direction: CallDirection.incoming,
  number: '0',
  video: false,
  username: null,
  createdTime: DateTime.utc(2024),
  acceptedTime: null,
  hungUpTime: null,
);

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------

void _bringOnline(FakeAsync async, TestCallBloc bloc, FakeSignalingClientFactory factory) {
  bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
  async.flushMicrotasks();
  async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
  async.flushMicrotasks();
  expect(bloc.state.callServiceState.signalingClientStatus, SignalingClientStatus.connect);
}

void _bringOnlineWithHandshake(
  FakeAsync async,
  TestCallBloc bloc,
  FakeSignalingClientFactory factory, {
  RegistrationStatus registrationStatus = RegistrationStatus.registered,
  int linesCount = 1,
}) {
  _bringOnline(async, bloc, factory);
  factory.client!.simulateHandshake(
    minimalStateHandshake(registrationStatus: registrationStatus, linesCount: linesCount),
  );
  async.flushMicrotasks();
  expect(bloc.state.callServiceState.registration?.status, registrationStatus);
}

/// Simulates an [IncomingCallEvent] and drains the pending 0-duration timer
/// that [__onCallSignalingEventIncoming] defers at its end.
///
/// Without this drain, the BLoC's sequential event queue stays blocked while
/// the incoming-call handler awaits [Future.delayed(Duration.zero)], causing
/// any subsequent events to pile up unprocessed.
void _simulateIncoming(
  FakeAsync async,
  FakeSignalingClientFactory factory, {
  int line = 0,
  String callId = 'call-1',
  String callee = 'bob',
  String caller = '123',
}) {
  factory.client!.simulateEvent(IncomingCallEvent(line: line, callId: callId, callee: callee, caller: caller));
  async.flushMicrotasks();
  async.elapse(Duration.zero); // drain the Future.delayed(Duration.zero) timer
  async.flushMicrotasks();
}

MockCallkeep _incomingCallkeepMock() {
  final mock = MockCallkeep();
  when(() => mock.setDelegate(any())).thenReturn(null);
  when(
    () => mock.reportNewIncomingCall(
      any(),
      any(),
      displayName: any(named: 'displayName'),
      hasVideo: any(named: 'hasVideo'),
    ),
  ).thenAnswer((_) async => null);
  when(() => mock.reportEndCall(any(), any(), any())).thenAnswer((_) async {});
  return mock;
}

MockCallkeep _outgoingCallkeepMock() {
  final mock = MockCallkeep();
  when(() => mock.setDelegate(any())).thenReturn(null);
  when(
    () => mock.startCall(
      any(),
      any(),
      displayNameOrContactIdentifier: any(named: 'displayNameOrContactIdentifier'),
      hasVideo: any(named: 'hasVideo'),
      proximityEnabled: any(named: 'proximityEnabled'),
    ),
  ).thenAnswer((_) async => null);
  when(() => mock.reportConnectedOutgoingCall(any())).thenAnswer((_) async {});
  return mock;
}

// ---------------------------------------------------------------------------

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(_FakeLinesState());
    registerFallbackValue(CallkeepSignalingStatus.disconnect);
    registerFallbackValue(_FakeCallkeepHandle());
    registerFallbackValue(CallkeepEndCallReason.remoteEnded);
    registerFallbackValue(_fakeNewCall);
  });

  // -------------------------------------------------------------------------
  // Incoming call flow
  // -------------------------------------------------------------------------

  group('incoming call flow', () {
    test('IncomingCallEvent creates ActiveCall with incomingFromOffer status', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(callkeep: _incomingCallkeepMock(), signalingClientFactory: factory.call);

        _bringOnlineWithHandshake(async, bloc, factory);

        _simulateIncoming(async, factory);

        expect(bloc.state.activeCalls, hasLength(1));
        final call = bloc.state.activeCalls.first;
        expect(call.callId, 'call-1');
        expect(call.direction, CallDirection.incoming);
        expect(call.processingStatus, CallProcessingStatus.incomingFromOffer);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('HangupEvent removes the call and invokes reportEndCall', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _incomingCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        _bringOnlineWithHandshake(async, bloc, factory);

        _simulateIncoming(async, factory);
        expect(bloc.state.activeCalls, hasLength(1));

        factory.client!.simulateEvent(const HangupEvent(line: 0, callId: 'call-1', code: 0, reason: 'normal'));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, isEmpty);
        verify(() => mockCallkeep.reportEndCall('call-1', any(), any())).called(1);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('HangupEvent with code 403 submits CallWhileUnregisteredNotification', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final notifications = <Notification>[];
        final bloc = buildTestBloc(
          callkeep: _incomingCallkeepMock(),
          signalingClientFactory: factory.call,
          capturedNotifications: notifications,
        );

        _bringOnlineWithHandshake(async, bloc, factory);

        _simulateIncoming(async, factory);

        factory.client!.simulateEvent(const HangupEvent(line: 0, callId: 'call-1', code: 403, reason: 'unauthorized'));
        async.flushMicrotasks();

        expect(notifications, contains(isA<CallWhileUnregisteredNotification>()));
        expect(bloc.state.activeCalls, isEmpty);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('AcceptedEvent transitions incoming call to connected', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(callkeep: _incomingCallkeepMock(), signalingClientFactory: factory.call);

        _bringOnlineWithHandshake(async, bloc, factory);

        _simulateIncoming(async, factory);
        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.incomingFromOffer);

        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        final call = bloc.state.activeCalls.first;
        expect(call.processingStatus, CallProcessingStatus.connected);
        expect(call.acceptedTime, isNotNull);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // Outgoing call flow
  // -------------------------------------------------------------------------

  group('outgoing call flow', () {
    test('CallControlEvent.started when registered creates outgoing ActiveCall', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(callkeep: _outgoingCallkeepMock(), signalingClientFactory: factory.call);

        _bringOnlineWithHandshake(async, bloc, factory);

        bloc.add(const CallControlEvent.started(number: '456', video: false));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, hasLength(1));
        final call = bloc.state.activeCalls.first;
        expect(call.direction, CallDirection.outgoing);
        expect(call.processingStatus, CallProcessingStatus.outgoingCreated);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('CallControlEvent.started when unregistered submits CallWhileUnregisteredNotification', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final notifications = <Notification>[];
        final bloc = buildTestBloc(
          callkeep: _outgoingCallkeepMock(),
          signalingClientFactory: factory.call,
          capturedNotifications: notifications,
        );

        _bringOnlineWithHandshake(async, bloc, factory, registrationStatus: RegistrationStatus.unregistered);

        bloc.add(const CallControlEvent.started(number: '456', video: false));
        async.flushMicrotasks();

        expect(notifications, contains(isA<CallWhileUnregisteredNotification>()));
        expect(bloc.state.activeCalls, isEmpty);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('CallControlEvent.started with no idle lines submits CallUndefinedLineNotification', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final notifications = <Notification>[];
        final bloc = buildTestBloc(
          callkeep: _outgoingCallkeepMock(),
          signalingClientFactory: factory.call,
          capturedNotifications: notifications,
        );

        _bringOnlineWithHandshake(async, bloc, factory, linesCount: 0);

        bloc.add(const CallControlEvent.started(number: '456', video: false));
        async.flushMicrotasks();

        expect(notifications, contains(isA<CallUndefinedLineNotification>()));
        expect(bloc.state.activeCalls, isEmpty);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('RingingEvent transitions outgoing call to outgoingRinging', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(callkeep: _outgoingCallkeepMock(), signalingClientFactory: factory.call);

        _bringOnlineWithHandshake(async, bloc, factory);

        bloc.add(const CallControlEvent.started(number: '456', video: false));
        async.flushMicrotasks();
        expect(bloc.state.activeCalls, hasLength(1));

        final callId = bloc.state.activeCalls.first.callId;
        factory.client!.simulateEvent(RingingEvent(line: 0, callId: callId));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.outgoingRinging);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('AcceptedEvent transitions outgoing call to connected and calls reportConnectedOutgoingCall', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _outgoingCallkeepMock();
        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        _bringOnlineWithHandshake(async, bloc, factory);

        bloc.add(const CallControlEvent.started(number: '456', video: false));
        async.flushMicrotasks();
        final callId = bloc.state.activeCalls.first.callId;

        factory.client!.simulateEvent(AcceptedEvent(line: 0, callId: callId));
        async.flushMicrotasks();

        final call = bloc.state.retrieveActiveCall(callId);
        expect(call?.processingStatus, CallProcessingStatus.connected);
        expect(call?.acceptedTime, isNotNull);
        verify(() => mockCallkeep.reportConnectedOutgoingCall(callId)).called(1);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });
}
