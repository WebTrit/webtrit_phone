import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter/widgets.dart' hide Notification;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/call/models/models.dart';
import 'package:webtrit_phone/models/models.dart';

import 'helpers/call_bloc_test_helpers.dart';
import 'helpers/fake_signaling_client.dart';

// ---------------------------------------------------------------------------
// Fallback values required by mocktail
// ---------------------------------------------------------------------------

class _FakeLinesState extends Fake implements LinesState {}

class _FakeCallkeepHandle extends Fake implements CallkeepHandle {}

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
// Shared helpers (copied from call_flow_test.dart — private to that file)
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
  async.elapse(Duration.zero);
  async.flushMicrotasks();
}

// ---------------------------------------------------------------------------
// Incoming callkeep mock
// ---------------------------------------------------------------------------

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

// ---------------------------------------------------------------------------
// A signaling factory that never resolves — the bloc stays in connecting state
// ---------------------------------------------------------------------------

Future<WebtritSignalingClient> _pendingSignalingFactory({
  required Uri url,
  required String tenantId,
  required String token,
  required Duration connectionTimeout,
  required TrustedCertificates certs,
  required bool force,
}) => Completer<WebtritSignalingClient>().future;

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
  // continueStartCallIntent timeout
  // -------------------------------------------------------------------------

  group('continueStartCallIntent timeout', () {
    test('submits SignalingConnectFailedNotification when signaling never becomes ready', () {
      fakeAsync((async) {
        final notifications = <Notification>[];
        final bloc = buildTestBloc(
          signalingClientFactory: _pendingSignalingFactory,
          capturedNotifications: notifications,
        );

        // Trigger the intent — the bloc is not yet online, so it waits for the stream.
        bloc.continueStartCallIntent(const CallkeepHandle.number('555'), null, false);
        async.flushMicrotasks();

        // No notification yet — the timeout has not elapsed.
        expect(notifications, isEmpty);

        // Elapse past kSignalingClientConnectionTimeout.
        async.elapse(kSignalingClientConnectionTimeout + const Duration(seconds: 1));
        async.flushMicrotasks();

        expect(notifications, contains(isA<SignalingConnectFailedNotification>()));

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // Push enrichment
  // -------------------------------------------------------------------------

  group('push enrichment', () {
    test('didPushIncomingCall creates placeholder with incomingFromPush status', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(callkeep: _incomingCallkeepMock(), signalingClientFactory: factory.call);

        // Fire push before signaling is online.
        bloc.didPushIncomingCall(const CallkeepHandle.number('123'), null, false, 'call-push', null);
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, hasLength(1));
        final placeholder = bloc.state.activeCalls.first;
        expect(placeholder.callId, 'call-push');
        expect(placeholder.processingStatus, CallProcessingStatus.incomingFromPush);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('IncomingCallEvent enriches existing push placeholder instead of creating a duplicate', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(callkeep: _incomingCallkeepMock(), signalingClientFactory: factory.call);

        // Push arrives first (before signaling is online).
        bloc.didPushIncomingCall(const CallkeepHandle.number('123'), null, false, 'call-push', null);
        async.flushMicrotasks();

        expect(bloc.state.activeCalls, hasLength(1));
        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.incomingFromPush);

        // Now bring signaling online and simulate the matching IncomingCallEvent.
        _bringOnlineWithHandshake(async, bloc, factory);
        _simulateIncoming(async, factory, callId: 'call-push', caller: '123');

        // The placeholder must be enriched — no duplicate call created.
        expect(bloc.state.activeCalls, hasLength(1));
        final enriched = bloc.state.activeCalls.first;
        expect(enriched.callId, 'call-push');
        expect(enriched.processingStatus, CallProcessingStatus.incomingFromOffer);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // _processHandshakeAsync cleanup
  // -------------------------------------------------------------------------

  group('_processHandshakeAsync cleanup', () {
    test('connected call not present in new handshake lines is removed from state', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final mockCallkeep = _incomingCallkeepMock();

        // Add endCall stub — needed when _processHandshakeAsync calls callkeep.endCall on orphaned connections.
        when(() => mockCallkeep.endCall(any())).thenAnswer((_) async => null);

        final bloc = buildTestBloc(callkeep: mockCallkeep, signalingClientFactory: factory.call);

        // Bring online and get a connected call.
        _bringOnlineWithHandshake(async, bloc, factory, linesCount: 1);
        _simulateIncoming(async, factory, callId: 'call-1');
        factory.client!.simulateEvent(const AcceptedEvent(line: 0, callId: 'call-1'));
        async.flushMicrotasks();

        expect(bloc.state.activeCalls.first.processingStatus, CallProcessingStatus.connected);

        // Simulate a server-initiated disconnect followed by a reconnect with an
        // empty handshake (no active lines for call-1).
        factory.client!.simulateDisconnect(SignalingDisconnectCode.goingAway.code, 'server restart');
        async.flushMicrotasks();

        // Reconnect with slow delay.
        async.elapse(kSignalingClientReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(bloc.state.callServiceState.signalingClientStatus, SignalingClientStatus.connect);

        // New handshake: lines list is empty — call-1 is no longer active on the server.
        factory.client!.simulateHandshake(
          minimalStateHandshake(registrationStatus: RegistrationStatus.registered, linesCount: 0),
        );
        async.flushMicrotasks();
        // Allow _processHandshakeAsync unawaited tasks to complete.
        async.elapse(Duration.zero);
        async.flushMicrotasks();

        // call-1 should have been cleaned up (removed or marked hung-up).
        final remaining = bloc.state.activeCalls.where((c) => c.callId == 'call-1' && !c.wasHungUp);
        expect(remaining, isEmpty);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });
}
