import 'package:fake_async/fake_async.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/utils/utils.dart';

import 'helpers/call_bloc_test_helpers.dart';
import 'helpers/fake_signaling_client.dart';

// ---------------------------------------------------------------------------
// Fallback values required by mocktail
// ---------------------------------------------------------------------------

class _FakeLinesState extends Fake implements LinesState {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(_FakeLinesState());
    registerFallbackValue(CallkeepSignalingStatus.disconnect);
  });

  // -------------------------------------------------------------------------
  // Reconnection guard clauses
  // -------------------------------------------------------------------------

  group('_reconnectInitiated guard clauses', () {
    test('does not connect when app is backgrounded and force=false', () {
      fakeAsync((async) {
        final bloc = buildTestBloc();

        // Default state has currentAppLifecycleState=null → appActive=false.
        // Trigger _reconnectInitiated via lifecycle paused→resumed transition
        // but KEEP the state backgrounded to verify the guard.
        bloc.didChangeAppLifecycleState(AppLifecycleState.paused);
        async.flushMicrotasks();

        // Advance past any reconnect delay.
        async.elapse(kSignalingClientReconnectDelay * 2);
        async.flushMicrotasks();

        // No connect event should have been processed: status stays at initial
        // `connecting` (the default from CallServiceState constructor).
        expect(bloc.state.callServiceState.signalingClientStatus, isNot(SignalingClientStatus.connect));

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('does not reconnect when _signalingClient is already connected and force=false', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(signalingClientFactory: factory.call);

        // Bring the bloc online: lifecycle resumed → timer fires → factory called.
        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        // Verify connect state.
        expect(bloc.state.callServiceState.signalingClientStatus, SignalingClientStatus.connect);

        final firstClient = factory.client;

        // Trigger reconnect again while still connected.
        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        // Guard `signalingRemains == true && force == false` prevents a new connect.
        // The client reference should not have changed.
        expect(factory.client, same(firstClient));

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('reconnects when lifecycle transitions to resumed', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(signalingClientFactory: factory.call);

        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(bloc.state.callServiceState.signalingClientStatus, SignalingClientStatus.connect);
        expect(factory.client, isNotNull);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // Connect/disconnect state machine
  // -------------------------------------------------------------------------

  group('connect state machine', () {
    test('transitions: initial → connecting → connect on successful factory call', () {
      fakeAsync((async) {
        final states = <SignalingClientStatus>[];
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(signalingClientFactory: factory.call);
        bloc.stream.listen((s) => states.add(s.callServiceState.signalingClientStatus));

        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(states, containsAllInOrder([SignalingClientStatus.connecting, SignalingClientStatus.connect]));

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('transitions: connecting → failure when factory throws', () {
      fakeAsync((async) {
        final states = <SignalingClientStatus>[];
        final bloc = buildTestBloc(
          signalingClientFactory:
              ({
                required url,
                required tenantId,
                required token,
                required connectionTimeout,
                required certs,
                required force,
              }) async {
                throw Exception('connection refused');
              },
        );
        bloc.stream.listen((s) => states.add(s.callServiceState.signalingClientStatus));

        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(states, containsAllInOrder([SignalingClientStatus.connecting, SignalingClientStatus.failure]));
        expect(bloc.state.callServiceState.lastSignalingClientConnectError, isNotNull);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('schedules slow reconnect after connection failure', () {
      fakeAsync((async) {
        int factoryCallCount = 0;
        final bloc = buildTestBloc(
          signalingClientFactory:
              ({
                required url,
                required tenantId,
                required token,
                required connectionTimeout,
                required certs,
                required force,
              }) async {
                factoryCallCount++;
                throw Exception('refused');
              },
        );

        // First connect attempt.
        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(factoryCallCount, 1);

        // After failure, _reconnectInitiated(delay: kSignalingClientReconnectDelay) is scheduled.
        // Advance past the slow reconnect delay.
        async.elapse(kSignalingClientReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(factoryCallCount, 2);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('transitions: connect → disconnecting → disconnect on graceful disconnect', () {
      fakeAsync((async) {
        final states = <SignalingClientStatus>[];
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(signalingClientFactory: factory.call);
        bloc.stream.listen((s) => states.add(s.callServiceState.signalingClientStatus));

        // Bring online.
        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        // Transition to background with no active calls → _disconnectInitiated.
        bloc.didChangeAppLifecycleState(AppLifecycleState.paused);
        async.flushMicrotasks();

        expect(
          states,
          containsAllInOrder([
            SignalingClientStatus.connecting,
            SignalingClientStatus.connect,
            SignalingClientStatus.disconnecting,
            SignalingClientStatus.disconnect,
          ]),
        );

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });

  // -------------------------------------------------------------------------
  // Disconnect code handling
  // -------------------------------------------------------------------------

  group('disconnect code handling', () {
    late FakeSignalingClientFactory factory;
    late TestCallBloc bloc;

    setUp(() {
      factory = FakeSignalingClientFactory();
    });

    void bringOnline(FakeAsync async) {
      bloc = buildTestBloc(signalingClientFactory: factory.call);
      bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
      async.flushMicrotasks();
      async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
      async.flushMicrotasks();
      expect(bloc.state.callServiceState.signalingClientStatus, SignalingClientStatus.connect);
    }

    test('controllerForceAttachClose reconnects with fast delay without showing connectIssue', () {
      fakeAsync((async) {
        bringOnline(async);

        factory.client!.simulateDisconnect(SignalingDisconnectCode.controllerForceAttachClose.code, 'force close');
        async.flushMicrotasks();

        // lastSignalingDisconnectCode must be null to prevent connectIssue status.
        expect(bloc.state.callServiceState.lastSignalingDisconnectCode, isNull);
        expect(bloc.state.callServiceState.status, isNot(CallStatus.connectIssue));

        // Verify fast reconnect fires (not slow).
        final factoryCallsBefore = 1; // already connected once
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(bloc.state.callServiceState.signalingClientStatus, SignalingClientStatus.connect);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('sessionMissedError calls onSessionInvalidated', () {
      fakeAsync((async) {
        bool sessionInvalidated = false;
        final sessionFactory = FakeSignalingClientFactory();

        // Build a bloc with a custom onSessionInvalidated callback.
        final mockLinesState = MockLinesStateRepository();
        when(() => mockLinesState.setState(any())).thenReturn(null);
        final mockCallkeep = MockCallkeep();
        when(() => mockCallkeep.setDelegate(any())).thenReturn(null);
        final mockConnections = MockCallkeepConnections();
        when(() => mockConnections.updateActivitySignalingStatus(any())).thenAnswer((_) async {});
        when(() => mockConnections.getConnections()).thenAnswer((_) async => []);
        final mockPresenceSettings = MockPresenceSettingsRepository();
        when(() => mockPresenceSettings.resetLastSettingsSync()).thenReturn(null);
        final mockSound = MockWebtritCallkeepSound();
        when(() => mockSound.stopRingbackSound()).thenAnswer((_) async {});
        when(() => mockSound.playRingbackSound()).thenAnswer((_) async {});

        bloc = TestCallBloc(
          coreUrl: 'https://example.com',
          tenantId: 'test-tenant',
          token: 'test-token',
          trustedCertificates: TrustedCertificates.empty,
          callLogsRepository: MockCallLogsRepository(),
          callPullRepository: MockCallPullRepository(),
          linesStateRepository: mockLinesState,
          presenceInfoRepository: MockPresenceInfoRepository(),
          presenceSettingsRepository: mockPresenceSettings,
          onSessionInvalidated: () => sessionInvalidated = true,
          userRepository: MockUserRepository(),
          submitNotification: (_) {},
          callkeep: mockCallkeep,
          callkeepConnections: mockConnections,
          userMediaBuilder: MockUserMediaBuilder(),
          contactNameResolver: MockContactNameResolver(),
          callErrorReporter: MockCallErrorReporter(),
          sipPresenceEnabled: false,
          onDiagnosticReportRequested: (_, __) {},
          peerConnectionManager: () {
            final m = MockPeerConnectionManager();
            when(() => m.dispose()).thenAnswer((_) async {});
            when(() => m.disposePeerConnection(any())).thenAnswer((_) async {});
            when(() => m.add(any())).thenReturn(null);
            return m;
          }(),
          signalingClientFactory: sessionFactory.call,
          callkeepSound: mockSound,
        );

        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        sessionFactory.client!.simulateDisconnect(SignalingDisconnectCode.sessionMissedError.code, 'session missing');
        async.flushMicrotasks();

        expect(sessionInvalidated, isTrue);

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('normal disconnect code triggers slow reconnect', () {
      fakeAsync((async) {
        int factoryCallCount = 0;
        final trackingFactory = FakeSignalingClientFactory();
        bloc = buildTestBloc(
          signalingClientFactory:
              ({
                required url,
                required tenantId,
                required token,
                required connectionTimeout,
                required certs,
                required force,
              }) async {
                factoryCallCount++;
                return trackingFactory.call(
                  url: url,
                  tenantId: tenantId,
                  token: token,
                  connectionTimeout: connectionTimeout,
                  certs: certs,
                  force: force,
                );
              },
        );

        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(factoryCallCount, 1);

        // Simulate a normal server-side disconnect (goingAway).
        trackingFactory.client!.simulateDisconnect(SignalingDisconnectCode.goingAway.code, 'server going away');
        async.flushMicrotasks();

        expect(bloc.state.callServiceState.signalingClientStatus, SignalingClientStatus.disconnect);

        // Fast delay should NOT trigger a reconnect — only slow delay should.
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();
        expect(factoryCallCount, 1); // still only 1

        async.elapse(kSignalingClientReconnectDelay);
        async.flushMicrotasks();
        expect(factoryCallCount, 2); // reconnected after slow delay

        bloc.close();
        async.flushMicrotasks();
      });
    });

    test('handshake updates linesCount and registration in state', () {
      fakeAsync((async) {
        final factory = FakeSignalingClientFactory();
        final bloc = buildTestBloc(signalingClientFactory: factory.call);

        bloc.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        factory.client!.simulateHandshake(
          minimalStateHandshake(registrationStatus: RegistrationStatus.registered, linesCount: 2),
        );
        async.flushMicrotasks();

        expect(bloc.state.linesCount, 2);
        expect(bloc.state.callServiceState.registration?.status, RegistrationStatus.registered);

        bloc.close();
        async.flushMicrotasks();
      });
    });
  });
}
