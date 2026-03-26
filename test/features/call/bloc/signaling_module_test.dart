import 'package:fake_async/fake_async.dart';
import 'package:flutter/widgets.dart' hide Notification;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/call/bloc/call_bloc.dart';
import 'package:webtrit_phone/features/call/models/notification.dart';
import 'package:webtrit_phone/models/models.dart';

import 'helpers/call_bloc_test_helpers.dart';
import 'helpers/fake_signaling_client.dart';

// ---------------------------------------------------------------------------
// FakeSignalingModuleDelegate — drives SignalingModule in isolation
// ---------------------------------------------------------------------------

/// A minimal [SignalingModuleDelegate] implementation for unit tests.
///
/// Captures every delegate call so tests can assert on what the module did
/// without constructing a [CallBloc].
class FakeSignalingModuleDelegate implements SignalingModuleDelegate {
  FakeSignalingModuleDelegate({CallState? initialState}) : _state = initialState ?? const CallState();

  CallState _state;
  bool _closed = false;

  // Captured calls
  int connectRequests = 0;
  int disconnectRequests = 0;
  final List<(int?, String?)> disconnectedNotifications = [];
  final List<StateHandshake> handshakes = [];
  final List<Event> signalingEvents = [];
  final List<({RegistrationStatus status, int? code, String? reason})> registrationChanges = [];
  final List<String> completedCalls = [];
  final List<Notification> notifications = [];

  @override
  CallState get currentState => _state;

  @override
  bool get isModuleClosed => _closed;

  void close() => _closed = true;
  void updateState(CallState s) => _state = s;

  @override
  void requestConnect() => connectRequests++;

  @override
  void requestDisconnect() => disconnectRequests++;

  @override
  void notifyDisconnected(int? code, String? reason) => disconnectedNotifications.add((code, reason));

  @override
  void onStateHandshake(StateHandshake stateHandshake) => handshakes.add(stateHandshake);

  @override
  void onSignalingEvent(Event event) => signalingEvents.add(event);

  @override
  void dispatchRegistrationChange(RegistrationStatus status, {int? code, String? reason}) =>
      registrationChanges.add((status: status, code: code, reason: reason));

  @override
  void dispatchCompleteCall(String callId) => completedCalls.add(callId);

  @override
  void showNotification(Notification notification) => notifications.add(notification);
}

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
          signalingModule: SignalingModule(
            coreUrl: 'https://example.com',
            tenantId: 'test-tenant',
            token: 'test-token',
            trustedCertificates: TrustedCertificates.empty,
            signalingClientFactory: sessionFactory.call,
          ),
          callLogsRepository: MockCallLogsRepository(),
          callPullRepository: MockCallPullRepository(),
          linesStateRepository: mockLinesState,
          presenceInfoRepository: MockPresenceInfoRepository(),
          presenceSettingsRepository: mockPresenceSettings,
          onSessionInvalidated: () => sessionInvalidated = true,
          userRepository: () {
            final m = MockUserRepository();
            when(() => m.getRemoteInfo()).thenAnswer((_) async => null);
            return m;
          }(),
          submitNotification: (_) {},
          callkeep: mockCallkeep,
          callkeepConnections: mockConnections,
          userMediaBuilder: MockUserMediaBuilder(),
          contactNameResolver: MockContactNameResolver(),
          callErrorReporter: MockCallErrorReporter(),
          sipPresenceEnabled: false,
          onDiagnosticReportRequested: (_, _) {},
          peerConnectionManager: () {
            final m = MockPeerConnectionManager();
            when(() => m.dispose()).thenAnswer((_) async {});
            when(() => m.disposePeerConnection(any())).thenAnswer((_) async {});
            when(() => m.add(any())).thenReturn(null);
            return m;
          }(),
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

  // -------------------------------------------------------------------------
  // SignalingModule isolated tests (no CallBloc)
  // -------------------------------------------------------------------------

  group('SignalingModule isolated', () {
    late FakeSignalingModuleDelegate delegate;
    late FakeSignalingClientFactory factory;
    late SignalingModule module;

    setUp(() {
      delegate = FakeSignalingModuleDelegate();
      factory = FakeSignalingClientFactory();
      module = SignalingModule(
        coreUrl: 'https://example.com',
        tenantId: 'test-tenant',
        token: 'test-token',
        trustedCertificates: TrustedCertificates.empty,
        signalingClientFactory: factory.call,
        delegate: delegate,
      );
    });

    tearDown(() => module.dispose());

    // reconnect() guard clauses

    test('reconnect() skips when app is backgrounded and force=false', () {
      fakeAsync((async) {
        // Default state: currentAppLifecycleState=null → appActive=false.
        module.reconnect(delay: Duration.zero);
        async.flushMicrotasks();

        expect(delegate.connectRequests, 0);
      });
    });

    test('reconnect() skips when no connectivity and force=false', () {
      fakeAsync((async) {
        delegate.updateState(
          const CallState().copyWith(
            currentAppLifecycleState: AppLifecycleState.resumed,
            callServiceState: const CallServiceState().copyWith(networkStatus: NetworkStatus.none),
          ),
        );

        module.reconnect(delay: Duration.zero);
        async.flushMicrotasks();

        expect(delegate.connectRequests, 0);
      });
    });

    test('reconnect() skips when client already connected and force=false', () {
      fakeAsync((async) {
        delegate.updateState(const CallState().copyWith(currentAppLifecycleState: AppLifecycleState.resumed));

        // First connect to populate _client.
        module.reconnect(delay: Duration.zero);
        async.elapse(Duration.zero);
        async.flushMicrotasks();
        expect(delegate.connectRequests, 1);

        // Simulate module receiving the connect by calling performConnect.
        final emitted = <CallState>[];
        module.performConnect((s) {
          emitted.add(s);
          delegate.updateState(s);
        }, () => false);
        async.flushMicrotasks();

        // Now _client is set — second reconnect without force should be skipped.
        module.reconnect(delay: Duration.zero);
        async.elapse(Duration.zero);
        async.flushMicrotasks();

        expect(delegate.connectRequests, 1);
      });
    });

    test('reconnect(force: true) bypasses guards', () {
      fakeAsync((async) {
        // App backgrounded and no connectivity — normally both guards would block.
        delegate.updateState(
          const CallState().copyWith(
            callServiceState: const CallServiceState().copyWith(networkStatus: NetworkStatus.none),
          ),
        );

        module.reconnect(delay: Duration.zero, force: true);
        async.elapse(Duration.zero);
        async.flushMicrotasks();

        expect(delegate.connectRequests, 1);
      });
    });

    test('reconnect() skips when module is closed', () {
      fakeAsync((async) {
        delegate.updateState(const CallState().copyWith(currentAppLifecycleState: AppLifecycleState.resumed));
        delegate.close();

        module.reconnect(delay: Duration.zero);
        async.flushMicrotasks();

        expect(delegate.connectRequests, 0);
      });
    });

    test('disconnect() cancels pending timer and requests disconnect', () {
      fakeAsync((async) {
        delegate.updateState(const CallState().copyWith(currentAppLifecycleState: AppLifecycleState.resumed));

        // Schedule a delayed reconnect.
        module.reconnect(delay: const Duration(seconds: 5));

        // Disconnect should cancel it and emit a disconnectRequest.
        module.disconnect();
        async.flushMicrotasks();

        // Advance past the original timer — no connect request should fire.
        async.elapse(const Duration(seconds: 6));
        async.flushMicrotasks();

        expect(delegate.connectRequests, 0);
        expect(delegate.disconnectRequests, 1);
      });
    });

    // performConnect

    test('performConnect emits connecting → connect and stores client', () async {
      final emitted = <CallState>[];
      await module.performConnect((s) {
        emitted.add(s);
        delegate.updateState(s);
      }, () => false);

      expect(
        emitted.map((s) => s.callServiceState.signalingClientStatus),
        containsAllInOrder([SignalingClientStatus.connecting, SignalingClientStatus.connect]),
      );
      expect(module.signalingClient, isNotNull);
    });

    test('performConnect emits failure and schedules slow reconnect when factory throws', () {
      fakeAsync((async) {
        final failingModule = SignalingModule(
          coreUrl: 'https://example.com',
          tenantId: 'test-tenant',
          token: 'test-token',
          trustedCertificates: TrustedCertificates.empty,
          signalingClientFactory:
              ({
                required url,
                required tenantId,
                required token,
                required connectionTimeout,
                required certs,
                required force,
              }) async {
                throw Exception('refused');
              },
          delegate: delegate,
        );

        delegate.updateState(const CallState().copyWith(currentAppLifecycleState: AppLifecycleState.resumed));

        final emitted = <SignalingClientStatus>[];
        failingModule.performConnect((s) {
          emitted.add(s.callServiceState.signalingClientStatus);
          delegate.updateState(s);
        }, () => false);
        async.flushMicrotasks();

        expect(emitted, containsAllInOrder([SignalingClientStatus.connecting, SignalingClientStatus.failure]));

        // Slow reconnect should fire after kSignalingClientReconnectDelay.
        async.elapse(kSignalingClientReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();
        expect(delegate.connectRequests, 1);

        failingModule.dispose();
      });
    });

    test('performConnect does not emit a duplicate failure notification on repeated error', () async {
      final failingModule = SignalingModule(
        coreUrl: 'https://example.com',
        tenantId: 'test-tenant',
        token: 'test-token',
        trustedCertificates: TrustedCertificates.empty,
        signalingClientFactory:
            ({
              required url,
              required tenantId,
              required token,
              required connectionTimeout,
              required certs,
              required force,
            }) async {
              throw Exception('same error');
            },
        delegate: delegate,
      );

      // First attempt — notification should be emitted.
      await failingModule.performConnect((s) => delegate.updateState(s), () => false);
      expect(delegate.notifications.whereType<SignalingConnectFailedNotification>().length, 1);

      // Second attempt with the same error — no duplicate notification.
      await failingModule.performConnect((s) => delegate.updateState(s), () => false);
      expect(delegate.notifications.whereType<SignalingConnectFailedNotification>().length, 1);

      await failingModule.dispose();
    });

    // performDisconnect

    test('performDisconnect emits disconnecting → disconnect and clears client', () async {
      // First connect.
      await module.performConnect((s) => delegate.updateState(s), () => false);
      expect(module.signalingClient, isNotNull);

      final emitted = <SignalingClientStatus>[];
      await module.performDisconnect((s) {
        emitted.add(s.callServiceState.signalingClientStatus);
        delegate.updateState(s);
      }, () => false);

      expect(emitted, containsAllInOrder([SignalingClientStatus.disconnecting, SignalingClientStatus.disconnect]));
      expect(module.signalingClient, isNull);
    });

    // handleDisconnected — delegate callbacks

    test('handleDisconnected for appUnregisteredError dispatches registration change', () async {
      await module.handleDisconnected(
        SignalingDisconnectCode.appUnregisteredError.code,
        'unregistered',
        (s) => delegate.updateState(s),
        () => false,
      );

      expect(delegate.registrationChanges, hasLength(1));
      expect(delegate.registrationChanges.first.status, RegistrationStatus.unregistered);
    });

    test('handleDisconnected for controllerForceAttachClose keeps lastSignalingDisconnectCode null', () async {
      final emitted = <CallState>[];
      await module.handleDisconnected(SignalingDisconnectCode.controllerForceAttachClose.code, 'force close', (s) {
        emitted.add(s);
        delegate.updateState(s);
      }, () => false);

      expect(emitted.last.callServiceState.lastSignalingDisconnectCode, isNull);
    });

    test('handleDisconnected for sessionMissedError shows notification', () async {
      await module.handleDisconnected(
        SignalingDisconnectCode.sessionMissedError.code,
        'session missing',
        (s) => delegate.updateState(s),
        () => false,
      );

      expect(delegate.notifications, contains(isA<SignalingSessionMissedNotification>()));
    });

    test('handleDisconnected repeated code suppresses duplicate notification', () async {
      delegate.updateState(
        const CallState().copyWith(
          callServiceState: const CallServiceState().copyWith(
            lastSignalingDisconnectCode: SignalingDisconnectCode.goingAway.code,
          ),
        ),
      );

      await module.handleDisconnected(
        SignalingDisconnectCode.goingAway.code,
        'going away',
        (s) => delegate.updateState(s),
        () => false,
      );

      expect(delegate.notifications, isEmpty);
    });

    test('handleDisconnected forwards disconnect to delegate.notifyDisconnected', () {
      fakeAsync((async) {
        module.performConnect((s) => delegate.updateState(s), () => false);
        async.flushMicrotasks();

        factory.client!.simulateDisconnect(SignalingDisconnectCode.goingAway.code, 'bye');
        async.flushMicrotasks();

        expect(delegate.disconnectedNotifications, contains((SignalingDisconnectCode.goingAway.code, 'bye')));
      });
    });

    // Signaling callbacks forwarded to delegate

    test('client handshake is forwarded to delegate.onStateHandshake', () {
      fakeAsync((async) {
        module.performConnect((s) => delegate.updateState(s), () => false);
        async.flushMicrotasks();

        final handshake = minimalStateHandshake(linesCount: 3);
        factory.client!.simulateHandshake(handshake);
        async.flushMicrotasks();

        expect(delegate.handshakes, contains(handshake));
      });
    });

    test('client event is forwarded to delegate.onSignalingEvent', () {
      fakeAsync((async) {
        module.performConnect((s) => delegate.updateState(s), () => false);
        async.flushMicrotasks();

        final event = RegisteredEvent();
        factory.client!.simulateEvent(event);
        async.flushMicrotasks();

        expect(delegate.signalingEvents, contains(event));
      });
    });

    test('client error triggers reconnect(force: true)', () {
      fakeAsync((async) {
        delegate.updateState(const CallState().copyWith(currentAppLifecycleState: AppLifecycleState.resumed));

        module.performConnect((s) => delegate.updateState(s), () => false);
        async.flushMicrotasks();

        factory.client!.simulateError(Exception('keepalive timeout'));
        async.flushMicrotasks();

        // reconnect(force: true) uses kSignalingClientFastReconnectDelay — advance past it.
        async.elapse(kSignalingClientFastReconnectDelay + const Duration(milliseconds: 1));
        async.flushMicrotasks();

        expect(delegate.connectRequests, 1);
      });
    });
  });
}
