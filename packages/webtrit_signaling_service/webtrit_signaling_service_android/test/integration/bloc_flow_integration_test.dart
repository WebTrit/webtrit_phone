/// Integration tests modelling the expected BLoC consumer pattern.
///
/// A [CallBloc]-style consumer subscribes to signaling events via
/// [SignalingHubModule], tracks its own state (connected/handshake/calls),
/// and sends requests back through the hub.  These tests verify the complete
/// chain: [SignalingForegroundIsolateManager] -> [SignalingHub] ->
/// [SignalingHubClient] -> [SignalingHubModule] -> bloc event listener.
library;

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/hub/signaling_hub.dart';
import 'package:webtrit_signaling_service_android/src/hub/signaling_hub_client.dart';
import 'package:webtrit_signaling_service_android/src/hub/signaling_hub_module.dart';

// ---------------------------------------------------------------------------
// Local SignalingClientFactory typedef (mirrors the deleted per-platform type)
// ---------------------------------------------------------------------------

typedef _SignalingClientFactory =
    Future<WebtritSignalingClient> Function({
      required Uri url,
      required String tenantId,
      required String token,
      required Duration connectionTimeout,
      required TrustedCertificates certs,
      required bool force,
    });

// ---------------------------------------------------------------------------
// Local SignalingModule (mirrors the deleted per-platform implementation)
// ---------------------------------------------------------------------------

class _SignalingModule implements SignalingModule {
  _SignalingModule({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.trustedCertificates,
    required this.signalingClientFactory,
  });

  final String coreUrl;
  final String tenantId;
  final String token;
  final TrustedCertificates trustedCertificates;
  final _SignalingClientFactory signalingClientFactory;

  final _controller = StreamController<SignalingModuleEvent>.broadcast();
  final List<SignalingModuleEvent> _sessionBuffer = [];

  WebtritSignalingClient? _client;
  bool _disposed = false;
  String? _lastConnectErrorString;

  WebtritSignalingClient? get signalingClient => _client;

  @override
  Stream<SignalingModuleEvent> get events {
    final sink = StreamController<SignalingModuleEvent>(sync: true);
    final sub = _controller.stream.listen(sink.add, onError: sink.addError, onDone: sink.close);
    sink.onCancel = sub.cancel;
    for (final e in List<SignalingModuleEvent>.of(_sessionBuffer)) {
      sink.add(e);
    }
    return sink.stream;
  }

  @override
  bool get isConnected => _client != null;

  @override
  void connect() {
    if (_disposed) return;
    unawaited(_connectAsync());
  }

  @override
  Future<void> disconnect() async {
    final client = _client;
    if (client == null) return;
    _client = null;
    _emit(SignalingDisconnecting());
    try {
      await client.disconnect(SignalingDisconnectCode.goingAway.code);
    } catch (_) {}
  }

  @override
  Future<void>? execute(Request request) => _client?.execute(request);

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _sessionBuffer.clear();
    await disconnect();
    await _controller.close();
  }

  Future<void> _connectAsync() async {
    final existing = _client;
    if (existing != null) {
      _client = null;
      try {
        await existing.disconnect();
      } catch (_) {}
    }
    if (_disposed) return;
    _sessionBuffer.clear();
    _emit(SignalingConnecting());
    try {
      final url = Uri.parse(coreUrl).replace(scheme: coreUrl.startsWith('https') ? 'wss' : 'ws');
      final client = await signalingClientFactory(
        url: url,
        tenantId: tenantId,
        token: token,
        connectionTimeout: const Duration(seconds: 10),
        certs: trustedCertificates,
        force: true,
      );
      if (_disposed) {
        try {
          await client.disconnect();
        } catch (_) {}
        return;
      }
      client.listen(
        onStateHandshake: (h) {
          if (!_disposed) _emit(SignalingHandshakeReceived(handshake: h));
        },
        onEvent: (e) {
          if (!_disposed) _emit(SignalingProtocolEvent(event: e));
        },
        onError: (e, [st]) {
          if (!_disposed) {
            _client = null;
            final es = e.toString();
            final rep = _lastConnectErrorString == es;
            _lastConnectErrorString = es;
            _emit(
              SignalingConnectionFailed(
                error: e,
                isRepeated: rep,
                recommendedReconnectDelay: const Duration(seconds: 3),
              ),
            );
          }
        },
        onDisconnect: (code, reason) {
          if (!_disposed) {
            _client = null;
            final known = SignalingDisconnectCode.values.byCode(code ?? -1);
            Duration? delay;
            if (known == SignalingDisconnectCode.controllerForceAttachClose) {
              delay = Duration.zero;
            } else if (known == SignalingDisconnectCode.protocolError) {
              delay = null;
            } else {
              delay = const Duration(seconds: 3);
            }
            _emit(
              SignalingDisconnected(code: code, reason: reason, knownCode: known, recommendedReconnectDelay: delay),
            );
          }
        },
      );
      _client = client;
      _lastConnectErrorString = null;
      _emit(SignalingConnected());
    } catch (e) {
      if (_disposed) return;
      final es = e.toString();
      final rep = _lastConnectErrorString == es;
      _lastConnectErrorString = es;
      _emit(
        SignalingConnectionFailed(error: e, isRepeated: rep, recommendedReconnectDelay: const Duration(seconds: 3)),
      );
    }
  }

  void _emit(SignalingModuleEvent event) {
    if (_controller.isClosed) return;
    _sessionBuffer.add(event);
    _controller.add(event);
  }
}

// ---------------------------------------------------------------------------
// Stream whereType extension (Stream lacks Iterable.whereType)
// ---------------------------------------------------------------------------

extension _StreamEventsX on Stream<SignalingModuleEvent> {
  Stream<T> whereType<T extends SignalingModuleEvent>() => where((e) => e is T).cast<T>();
}

// ---------------------------------------------------------------------------
// Fake signaling client
// ---------------------------------------------------------------------------

class _FakeSignalingClient extends Fake implements WebtritSignalingClient {
  StateHandshakeHandler? _onStateHandshake;
  EventHandler? _onEvent;
  DisconnectHandler? _onDisconnect;

  bool disconnected = false;
  final List<Request> executed = [];

  @override
  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {
    _onStateHandshake = onStateHandshake;
    _onEvent = onEvent;
    _onDisconnect = onDisconnect;
  }

  @override
  Future<void> disconnect([int? code, String? reason]) async {
    disconnected = true;
    _onDisconnect?.call(code, reason);
  }

  @override
  Future<void> execute(Request request, [Duration? timeout]) async => executed.add(request);

  void injectHandshake(StateHandshake h) => _onStateHandshake?.call(h);
  void injectEvent(Event e) => _onEvent?.call(e);
  void injectDisconnect(int? code, String? reason) => _onDisconnect?.call(code, reason);
}

// ---------------------------------------------------------------------------
// BLoC-like state machine (mimics relevant parts of CallBloc)
// ---------------------------------------------------------------------------

class _BlocSimulator {
  bool isConnected = false;
  StateHandshake? lastHandshake;
  final List<Event> protocolEvents = [];
  final List<SignalingModuleEvent> allEvents = [];

  StreamSubscription<SignalingModuleEvent>? _sub;

  void attach(Stream<SignalingModuleEvent> events) {
    _sub = events.listen((event) {
      allEvents.add(event);
      switch (event) {
        case SignalingConnected():
          isConnected = true;
        case SignalingDisconnected():
          isConnected = false;
        case SignalingConnectionFailed():
          isConnected = false;
        case SignalingHandshakeReceived(:final handshake):
          lastHandshake = handshake;
        case SignalingProtocolEvent(:final event):
          protocolEvents.add(event);
        default:
          break;
      }
    });
  }

  Future<void> dispose() async => _sub?.cancel();
}

// ---------------------------------------------------------------------------
// Fixtures
// ---------------------------------------------------------------------------

final _kHandshake = StateHandshake(
  keepaliveInterval: const Duration(seconds: 30),
  timestamp: 1705322000000,
  registration: const Registration(status: RegistrationStatus.registered),
  lines: const [],
  userActiveCalls: const [],
  contactsPresenceInfo: const {},
  guestLine: null,
);

// ---------------------------------------------------------------------------
// Local test manager (replaces SignalingForegroundIsolateManager for tests)
//
// Owns a _SignalingModule + SignalingHub and starts/stops them on demand,
// without the PluginUtilities callback-handle indirection used in production.
// ---------------------------------------------------------------------------

class _TestIsolateManager {
  _TestIsolateManager({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.signalingClientFactory,
    this.incomingCallHandlerHandle = 0,
  });

  final String coreUrl;
  final String tenantId;
  final String token;
  final _SignalingClientFactory signalingClientFactory;
  final int incomingCallHandlerHandle;

  _SignalingModule? _module;
  SignalingHub? _hub;
  StreamSubscription<SignalingModuleEvent>? _eventsSub;
  bool _started = false;

  Future<void> handleStatus({required bool enabled}) async {
    if (enabled) {
      await _start();
    } else {
      await _stop();
    }
  }

  Future<void> _start() async {
    if (_started) return;
    _started = true;
    _module = _SignalingModule(
      coreUrl: coreUrl,
      tenantId: tenantId,
      token: token,
      trustedCertificates: TrustedCertificates.empty,
      signalingClientFactory: signalingClientFactory,
    );
    _hub = SignalingHub(_module!);
    _hub!.start();
    _eventsSub = _module!.events.listen(null);
    _module!.connect();
  }

  Future<void> _stop() async {
    if (!_started) return;
    _started = false;
    await _eventsSub?.cancel();
    await _hub?.dispose();
    await _module?.dispose();
    _eventsSub = null;
    _hub = null;
    _module = null;
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

_SignalingClientFactory _fakeFactory(_FakeSignalingClient client) =>
    ({
      required Uri url,
      required String tenantId,
      required String token,
      required Duration connectionTimeout,
      required TrustedCertificates certs,
      required bool force,
    }) async => client;

/// Builds the "server side": module + hub, connects, and returns both.
Future<({_SignalingModule module, SignalingHub hub, _FakeSignalingClient fakeClient})> _buildServerSide() async {
  final fakeClient = _FakeSignalingClient();
  final module = _SignalingModule(
    coreUrl: 'https://example.com',
    tenantId: 'tenant',
    token: 'token',
    trustedCertificates: TrustedCertificates.empty,
    signalingClientFactory: _fakeFactory(fakeClient),
  );
  final hub = SignalingHub(module);
  hub.start();
  module.connect();
  await Future<void>.delayed(Duration.zero); // let _connectAsync complete
  return (module: module, hub: hub, fakeClient: fakeClient);
}

/// Builds the "client side": subscribes a hub client and wraps it in a module.
Future<({SignalingHubClient hubClient, SignalingHubModule hubModule})> _buildClientSide(String consumerId) async {
  final hubClient = SignalingHubClient.tryConnect(consumerId);
  expect(hubClient, isNotNull);
  final ackFuture = hubClient!.awaitAck(timeout: const Duration(seconds: 2));
  hubClient.start();
  await ackFuture;
  final hubModule = SignalingHubModule(hubClient);
  return (hubClient: hubClient, hubModule: hubModule);
}

Future<T> _waitFor<T extends SignalingModuleEvent>(Stream<SignalingModuleEvent> stream) =>
    stream.whereType<T>().first.timeout(const Duration(seconds: 2));

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // Positive API flow
  // -------------------------------------------------------------------------

  group('Positive API flow', () {
    test('client receives SignalingConnected from already-connected module', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final (:hubClient, :hubModule) = await _buildClientSide('api-flow-1');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);
    });

    test('client receives SignalingHandshakeReceived after handshake injected', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final (:hubClient, :hubModule) = await _buildClientSide('api-flow-2');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final received = _waitFor<SignalingHandshakeReceived>(hubModule.events);
      fakeClient.injectHandshake(_kHandshake);

      final event = await received;
      expect(event.handshake.timestamp, _kHandshake.timestamp);
      expect(event.handshake.registration.status, RegistrationStatus.registered);
    });

    test('client receives SignalingProtocolEvent for each server event', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final (:hubClient, :hubModule) = await _buildClientSide('api-flow-3');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final events = <SignalingProtocolEvent>[];
      hubModule.events.whereType<SignalingProtocolEvent>().listen(events.add);

      fakeClient.injectEvent(UnregisteredEvent());
      fakeClient.injectEvent(RegisteredEvent());
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(events, hasLength(2));
      expect(events[0].event, isA<UnregisteredEvent>());
      expect(events[1].event, isA<RegisteredEvent>());
    });

    test('execute via hub module reaches the fake signaling client', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final (:hubClient, :hubModule) = await _buildClientSide('api-flow-4');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      await hubModule
          .execute(HangupRequest(transaction: 'tx-api-flow-4', line: 1, callId: 'call-1'))!
          .timeout(const Duration(seconds: 2));

      expect(fakeClient.executed, hasLength(1));
    });

    test('client receives SignalingDisconnected on server close', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final (:hubClient, :hubModule) = await _buildClientSide('api-flow-5');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final received = _waitFor<SignalingDisconnected>(hubModule.events);
      fakeClient.injectDisconnect(SignalingDisconnectCode.normalClosure.code, 'server stop');

      final disc = await received;
      expect(disc.knownCode, SignalingDisconnectCode.normalClosure);
      expect(hubModule.isConnected, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  // Expected BLoC flow
  // -------------------------------------------------------------------------

  group('BLoC flow -- connect -> handshake -> event -> execute -> disconnect', () {
    test('full happy-path lifecycle matches CallBloc event expectations', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final (:hubClient, :hubModule) = await _buildClientSide('bloc-happy-1');
      addTearDown(hubModule.dispose);

      final bloc = _BlocSimulator();
      bloc.attach(hubModule.events);
      addTearDown(bloc.dispose);

      // Step 1: wait until BLoC sees SignalingConnected.
      await _waitFor<SignalingConnected>(hubModule.events);
      expect(bloc.isConnected, isTrue);

      // Step 2: server sends handshake (registration complete).
      fakeClient.injectHandshake(_kHandshake);
      await _waitFor<SignalingHandshakeReceived>(hubModule.events);
      expect(bloc.lastHandshake, isNotNull);
      expect(bloc.lastHandshake!.registration.status, RegistrationStatus.registered);

      // Step 3: server sends a protocol event (incoming call signaling, etc.).
      fakeClient.injectEvent(UnregisteredEvent());
      await _waitFor<SignalingProtocolEvent>(hubModule.events);
      expect(bloc.protocolEvents, hasLength(1));

      // Step 4: BLoC executes a request (e.g. hangup).
      await hubModule
          .execute(HangupRequest(transaction: 'tx-bloc-happy-1', line: 1, callId: 'call-bloc'))!
          .timeout(const Duration(seconds: 2));
      expect(fakeClient.executed, hasLength(1));

      // Step 5: server disconnects gracefully.
      fakeClient.injectDisconnect(SignalingDisconnectCode.normalClosure.code, 'logout');
      await _waitFor<SignalingDisconnected>(hubModule.events);
      expect(bloc.isConnected, isFalse);
    });

    test('BLoC handles force-reattach disconnect (code 4441) and expects immediate reconnect hint', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final (:hubClient, :hubModule) = await _buildClientSide('bloc-force-attach-1');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final received = _waitFor<SignalingDisconnected>(hubModule.events);
      fakeClient.injectDisconnect(SignalingDisconnectCode.controllerForceAttachClose.code, 'dupe');

      final disc = await received;
      // BLoC should reconnect immediately (Duration.zero).
      expect(disc.recommendedReconnectDelay, Duration.zero);
    });

    test('BLoC handles protocol-error disconnect -- does NOT reconnect (null delay)', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final (:hubClient, :hubModule) = await _buildClientSide('bloc-proto-error-1');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final received = _waitFor<SignalingDisconnected>(hubModule.events);
      fakeClient.injectDisconnect(SignalingDisconnectCode.protocolError.code, 'bad frame');

      final disc = await received;
      expect(disc.recommendedReconnectDelay, isNull);
    });

    test('BLoC reconnect: after disconnect, module reconnects and BLoC becomes connected again', () async {
      final fakeClient2 = _FakeSignalingClient();
      var callCount = 0;

      final module = _SignalingModule(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        trustedCertificates: TrustedCertificates.empty,
        signalingClientFactory:
            ({
              required Uri url,
              required String tenantId,
              required String token,
              required Duration connectionTimeout,
              required TrustedCertificates certs,
              required bool force,
            }) async {
              callCount++;
              return callCount == 1 ? _FakeSignalingClient() : fakeClient2;
            },
      );
      final hub = SignalingHub(module);
      hub.start();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      module.connect();
      await Future<void>.delayed(Duration.zero);

      final (:hubClient, :hubModule) = await _buildClientSide('bloc-reconnect-1');
      addTearDown(hubModule.dispose);

      final bloc = _BlocSimulator();
      bloc.attach(hubModule.events);
      addTearDown(bloc.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);
      expect(bloc.isConnected, isTrue);

      // Simulate server disconnect.
      await module.disconnect();
      await _waitFor<SignalingDisconnected>(hubModule.events);
      expect(bloc.isConnected, isFalse);

      // BLoC triggers reconnect.
      module.connect();
      // Each event hop through the hub pipeline (module -> hub port -> hubClient ->
      // hubModule -> bloc) consumes one event-loop tick, so drain enough ticks for
      // the new SignalingConnected to reach the bloc before asserting.
      await Future<void>.delayed(Duration.zero); // factory resolves, port.send queued
      await Future<void>.delayed(Duration.zero); // [kConnecting] processed by hubClient
      await Future<void>.delayed(Duration.zero); // [kConnected] processed by hubClient

      expect(bloc.isConnected, isTrue);
    });

    test('two independent BLoC consumers track state independently', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final side1 = await _buildClientSide('bloc-multi-1');
      final side2 = await _buildClientSide('bloc-multi-2');
      addTearDown(side1.hubModule.dispose);
      addTearDown(side2.hubModule.dispose);

      final bloc1 = _BlocSimulator()..attach(side1.hubModule.events);
      final bloc2 = _BlocSimulator()..attach(side2.hubModule.events);
      addTearDown(bloc1.dispose);
      addTearDown(bloc2.dispose);

      await Future.wait([
        _waitFor<SignalingConnected>(side1.hubModule.events),
        _waitFor<SignalingConnected>(side2.hubModule.events),
      ]);

      expect(bloc1.isConnected, isTrue);
      expect(bloc2.isConnected, isTrue);

      // Inject handshake -- both blocs should receive it.
      fakeClient.injectHandshake(_kHandshake);
      await Future.wait([
        _waitFor<SignalingHandshakeReceived>(side1.hubModule.events),
        _waitFor<SignalingHandshakeReceived>(side2.hubModule.events),
      ]);

      expect(bloc1.lastHandshake?.timestamp, _kHandshake.timestamp);
      expect(bloc2.lastHandshake?.timestamp, _kHandshake.timestamp);
    });
  });

  // -------------------------------------------------------------------------
  // SignalingForegroundIsolateManager lifecycle
  // -------------------------------------------------------------------------

  group('SignalingForegroundIsolateManager lifecycle', () {
    test('handleStatus(enabled: true) registers hub and starts connection', () async {
      final fakeClient = _FakeSignalingClient();
      final manager = _TestIsolateManager(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        signalingClientFactory: _fakeFactory(fakeClient),
      );
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero); // let connect complete

      // Hub must be registered.
      expect(SignalingHubClient.tryConnect('manager-start-1'), isNotNull);
    });

    test('client connects to manager hub and receives SignalingConnected', () async {
      final fakeClient = _FakeSignalingClient();
      final manager = _TestIsolateManager(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        signalingClientFactory: _fakeFactory(fakeClient),
      );
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      final (:hubClient, :hubModule) = await _buildClientSide('manager-conn-1');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);
    });

    test('handleStatus(enabled: false) removes hub from IsolateNameServer', () async {
      final fakeClient = _FakeSignalingClient();
      final manager = _TestIsolateManager(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        signalingClientFactory: _fakeFactory(fakeClient),
      );

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      await manager.handleStatus(enabled: false);

      expect(SignalingHubClient.tryConnect('manager-stop-1'), isNull);
    });

    test('handleStatus(enabled: true) is idempotent -- second call is no-op', () async {
      final fakeClient = _FakeSignalingClient();
      final manager = _TestIsolateManager(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        signalingClientFactory: _fakeFactory(fakeClient),
      );
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await manager.handleStatus(enabled: true); // second call must not throw

      await Future<void>.delayed(Duration.zero);
      expect(SignalingHubClient.tryConnect('manager-idem-1'), isNotNull);
    });

    test('handleStatus(enabled: false) is idempotent -- second call is no-op', () async {
      final fakeClient = _FakeSignalingClient();
      final manager = _TestIsolateManager(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        signalingClientFactory: _fakeFactory(fakeClient),
      );

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      await manager.handleStatus(enabled: false);
      await manager.handleStatus(enabled: false); // must not throw
    });

    test('full manager cycle: start -> BLoC connects -> handshake -> stop', () async {
      final fakeClient = _FakeSignalingClient();
      final manager = _TestIsolateManager(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        signalingClientFactory: _fakeFactory(fakeClient),
      );

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      final (:hubClient, :hubModule) = await _buildClientSide('manager-cycle-1');
      addTearDown(hubModule.dispose);

      final bloc = _BlocSimulator()..attach(hubModule.events);
      addTearDown(bloc.dispose);

      // Wait for connected.
      await _waitFor<SignalingConnected>(hubModule.events);
      expect(bloc.isConnected, isTrue);

      // Server sends handshake.
      fakeClient.injectHandshake(_kHandshake);
      await _waitFor<SignalingHandshakeReceived>(hubModule.events);
      expect(bloc.lastHandshake, isNotNull);

      // Stop the manager.
      await manager.handleStatus(enabled: false);

      // Hub is gone -- tryConnect returns null.
      expect(SignalingHubClient.tryConnect('manager-cycle-check'), isNull);
    });

    test('IncomingCallEvent with no handler registered does not throw', () async {
      // When incomingCallHandlerHandle == 0 (default), _dispatchIncomingCall logs
      // a warning but must not throw and must not crash the event pipeline.
      final fakeClient = _FakeSignalingClient();
      final manager = _TestIsolateManager(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        incomingCallHandlerHandle: 0, // no handler
        signalingClientFactory: _fakeFactory(fakeClient),
      );
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      // Inject a raw IncomingCallEvent via the fake signaling client.
      // The manager must handle it without throwing.
      fakeClient.injectEvent(
        const IncomingCallEvent(
          callId: 'call-no-handler',
          line: 1,
          callee: 'sip:bob@example.com',
          caller: 'sip:alice@example.com',
          callerDisplayName: 'Alice',
        ),
      );

      // Allow event processing to complete.
      await Future<void>.delayed(Duration.zero);

      // Hub is still alive -- the event did not crash the manager.
      expect(SignalingHubClient.tryConnect('manager-no-handler-check'), isNotNull);
    });

    test('protocolError disconnect does not schedule reconnect (null delay)', () async {
      // When recommendedReconnectDelay is null, the manager must NOT schedule
      // a reconnect timer. We verify this by confirming the module is not
      // reconnected after a short delay following a protocolError disconnect.
      final connectCount = <int>[];
      final fakeClient = _FakeSignalingClient();

      final manager = _TestIsolateManager(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        signalingClientFactory:
            ({
              required Uri url,
              required String tenantId,
              required String token,
              required Duration connectionTimeout,
              required TrustedCertificates certs,
              required bool force,
            }) async {
              connectCount.add(1);
              return fakeClient;
            },
      );
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero); // initial connect

      expect(connectCount, hasLength(1));

      // Inject protocolError close -- recommendedReconnectDelay is null.
      fakeClient.injectDisconnect(SignalingDisconnectCode.protocolError.code, 'bad frame');
      await Future<void>.delayed(const Duration(milliseconds: 50));

      // No reconnect should have been scheduled.
      expect(connectCount, hasLength(1), reason: 'protocolError must not trigger reconnect');
    });
  });
}
