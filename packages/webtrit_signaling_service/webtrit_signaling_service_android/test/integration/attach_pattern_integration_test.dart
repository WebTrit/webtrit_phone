/// Integration tests for the attach() pattern and two-mode (persistent /
/// pushBound) lifecycle.
///
/// These tests model the real push-initiated call flow without spawning a
/// native Android service.  The "background service" side is represented by
/// [SignalingForegroundIsolateManager]; the "main Activity" side is a
/// [SignalingHubClient] + [SignalingHubModule] pair that connects to the
/// already-running hub -- exactly what [WebtritSignalingServiceAndroid.attach]
/// does in production.
///
/// All tests run in-process using [ReceivePort]/[SendPort] and
/// [IsolateNameServer] -- no network I/O, no Android foreground service.
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
  void cancelRequestsByCallId(String callId) {}

  @override
  void clearTerminatingMark(String callId) {}

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
  });

  final String coreUrl;
  final String tenantId;
  final String token;
  final _SignalingClientFactory signalingClientFactory;

  _SignalingModule? _module;
  SignalingHub? _hub;
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
    _module!.connect();
  }

  Future<void> _stop() async {
    if (!_started) return;
    _started = false;
    await _hub?.dispose();
    await _module?.dispose();
    _hub = null;
    _module = null;
  }
}

// ---------------------------------------------------------------------------
// Stream whereType extension
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
// Fixtures
// ---------------------------------------------------------------------------

final _kHandshake = StateHandshake(
  keepaliveInterval: const Duration(seconds: 30),
  timestamp: 1705322000000,
  registration: const Registration(status: RegistrationStatus.registered),
  lines: const [],
  presenceInfos: const [],
  dialogInfos: const [],
  guestLine: null,
);

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

/// Builds and starts the "background service side":
/// [_TestIsolateManager] with a fake signaling client, connects,
/// and waits for the factory to resolve.
Future<({_TestIsolateManager manager, _FakeSignalingClient fakeClient})> _startServiceSide() async {
  final fakeClient = _FakeSignalingClient();
  final manager = _TestIsolateManager(
    coreUrl: 'https://example.com',
    tenantId: 'tenant',
    token: 'token',
    signalingClientFactory: _fakeFactory(fakeClient),
  );
  await manager.handleStatus(enabled: true);
  await Future<void>.delayed(Duration.zero); // let connect() resolve
  return (manager: manager, fakeClient: fakeClient);
}

/// Simulates [WebtritSignalingServiceAndroid.attach]: connects to an existing
/// hub as a late subscriber and wraps it in [SignalingHubModule].
Future<({SignalingHubClient hubClient, SignalingHubModule hubModule})> _attachMainSide(String consumerId) async {
  final hubClient = SignalingHubClient.tryConnect(consumerId);
  expect(hubClient, isNotNull, reason: 'Hub must be registered before attach()');
  final ackFuture = hubClient!.awaitAck(timeout: const Duration(seconds: 2));
  hubClient.start();
  final acked = await ackFuture;
  expect(acked, isTrue);
  final hubModule = SignalingHubModule(hubClient);
  return (hubClient: hubClient, hubModule: hubModule);
}

Future<T> _waitFor<T extends SignalingModuleEvent>(Stream<SignalingModuleEvent> stream) =>
    stream.whereType<T>().first.timeout(const Duration(seconds: 3));

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // attach() -- session buffer replay
  // -------------------------------------------------------------------------

  group('attach() -- session buffer replay', () {
    test('main side receives SignalingConnected from session buffer after attach', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      // Hub is connected before main side attaches -- session buffer must replay.
      final (:hubClient, :hubModule) = await _attachMainSide('attach-buffer-1');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);
      expect(hubModule.isConnected, isTrue);
    });

    test('main side receives handshake from session buffer when injected before attach', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      // Inject handshake before main side attaches.
      fakeClient.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      final (:hubClient, :hubModule) = await _attachMainSide('attach-buffer-2');
      addTearDown(hubModule.dispose);

      final events = <SignalingModuleEvent>[];
      hubModule.events.listen(events.add);
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingConnecting>(), hasLength(1));
      expect(events.whereType<SignalingConnected>(), hasLength(1));
      expect(events.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });

    test('main side receives only current session in buffer after hub reconnect', () async {
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
            }) async => fakeClient,
      );
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      addTearDown(() => manager.handleStatus(enabled: false));

      // Inject handshake in session 1, then disconnect.
      fakeClient.injectHandshake(_kHandshake);
      fakeClient.injectDisconnect(1000, 'test disconnect');
      await Future<void>.delayed(Duration.zero);

      // Peek at the hub directly to reconnect (module.connect is internal).
      // In this test we verify that after hub teardown+restart the session
      // buffer starts fresh -- attach must not see stale handshake.
      // Restart manager to simulate pushBound stop/start.
      await manager.handleStatus(enabled: false);
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      final (:hubClient, :hubModule) = await _attachMainSide('attach-buffer-3');
      addTearDown(hubModule.dispose);

      final events = <SignalingModuleEvent>[];
      hubModule.events.listen(events.add);
      await Future<void>.delayed(Duration.zero);

      // Must NOT replay handshake from the first session.
      expect(events.whereType<SignalingHandshakeReceived>(), isEmpty);
      expect(events.whereType<SignalingConnecting>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // attach() -- live event delivery
  // -------------------------------------------------------------------------

  group('attach() -- live event delivery', () {
    test('main side receives live handshake broadcast after attach', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      final (:hubClient, :hubModule) = await _attachMainSide('attach-live-1');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final received = _waitFor<SignalingHandshakeReceived>(hubModule.events);
      fakeClient.injectHandshake(_kHandshake);

      final event = await received;
      expect(event.handshake.timestamp, _kHandshake.timestamp);
    });

    test('main side receives live protocol events after attach', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      final (:hubClient, :hubModule) = await _attachMainSide('attach-live-2');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final events = <SignalingProtocolEvent>[];
      hubModule.events.whereType<SignalingProtocolEvent>().listen(events.add);

      fakeClient.injectEvent(UnregisteredEvent());
      fakeClient.injectEvent(RegisteredEvent());
      await Future<void>.delayed(const Duration(milliseconds: 30));

      expect(events, hasLength(2));
      expect(events[0].event, isA<UnregisteredEvent>());
      expect(events[1].event, isA<RegisteredEvent>());
    });

    test('main side receives SignalingDisconnected when server disconnects after attach', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      final (:hubClient, :hubModule) = await _attachMainSide('attach-live-3');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final received = _waitFor<SignalingDisconnected>(hubModule.events);
      fakeClient.injectDisconnect(SignalingDisconnectCode.normalClosure.code, 'logout');

      final disc = await received;
      expect(disc.knownCode, SignalingDisconnectCode.normalClosure);
      expect(hubModule.isConnected, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  // attach() -- execute routing
  // -------------------------------------------------------------------------

  group('attach() -- execute routing', () {
    test('main side can execute a request through the hub after attach', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      final (:hubClient, :hubModule) = await _attachMainSide('attach-exec-1');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      final request = HangupRequest(transaction: 'tx-attach-1', line: 1, callId: 'call-attach');
      await hubModule.execute(request)!.timeout(const Duration(seconds: 2));

      expect(fakeClient.executed, hasLength(1));
      final executed = fakeClient.executed[0] as HangupRequest;
      expect(executed.transaction, request.transaction);
      expect(executed.callId, request.callId);
    });

    test('execute returns null when main side attach sees not-yet-connected module', () async {
      final fakeClient = _FakeSignalingClient();
      // Build module/hub manually without connecting.
      final module = _SignalingModule(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'token',
        trustedCertificates: TrustedCertificates.empty,
        signalingClientFactory: _fakeFactory(fakeClient),
      );
      final hub = SignalingHub(module);
      hub.start();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      // Attach before module.connect() is called.
      final (:hubClient, :hubModule) = await _attachMainSide('attach-exec-2');
      addTearDown(hubModule.dispose);

      // hubModule.isConnected is false -- execute returns null per SignalingModule contract.
      final result = hubModule.execute(HangupRequest(transaction: 'tx-2', line: 1, callId: 'call-2'));
      expect(result, isNull);
    });
  });

  // -------------------------------------------------------------------------
  // push consumer + main consumer coexistence
  // -------------------------------------------------------------------------

  group('Push consumer + main consumer coexistence', () {
    test('both push and main consumers receive the same broadcast event', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      // Push consumer (simulates push isolate subscriber).
      final pushSide = await _attachMainSide('coexist-push-1');
      addTearDown(pushSide.hubModule.dispose);

      // Main consumer (simulates Activity calling attach()).
      final mainSide = await _attachMainSide('coexist-main-1');
      addTearDown(mainSide.hubModule.dispose);

      await Future.wait([
        _waitFor<SignalingConnected>(pushSide.hubModule.events),
        _waitFor<SignalingConnected>(mainSide.hubModule.events),
      ]);

      final pushHandshake = _waitFor<SignalingHandshakeReceived>(pushSide.hubModule.events);
      final mainHandshake = _waitFor<SignalingHandshakeReceived>(mainSide.hubModule.events);

      fakeClient.injectHandshake(_kHandshake);

      final results = await Future.wait([pushHandshake, mainHandshake]);
      for (final r in results) {
        expect(r.handshake.timestamp, _kHandshake.timestamp);
      }
    });

    test('push consumer unsubscribes -- main consumer still receives events', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      final pushSide = await _attachMainSide('coexist-push-2');
      final mainSide = await _attachMainSide('coexist-main-2');
      addTearDown(mainSide.hubModule.dispose);

      await Future.wait([
        _waitFor<SignalingConnected>(pushSide.hubModule.events),
        _waitFor<SignalingConnected>(mainSide.hubModule.events),
      ]);

      // Push consumer unsubscribes (push isolate work done).
      await pushSide.hubModule.dispose();

      // Main consumer should still receive new events.
      final received = _waitFor<SignalingHandshakeReceived>(mainSide.hubModule.events);
      fakeClient.injectHandshake(_kHandshake);

      await received;
    });

    test('main consumer executes request while push consumer is still subscribed', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      final pushSide = await _attachMainSide('coexist-push-3');
      addTearDown(pushSide.hubModule.dispose);

      final mainSide = await _attachMainSide('coexist-main-3');
      addTearDown(mainSide.hubModule.dispose);

      await Future.wait([
        _waitFor<SignalingConnected>(pushSide.hubModule.events),
        _waitFor<SignalingConnected>(mainSide.hubModule.events),
      ]);

      final request = HangupRequest(transaction: 'tx-coexist', line: 1, callId: 'call-co');
      await mainSide.hubModule.execute(request)!.timeout(const Duration(seconds: 2));

      expect(fakeClient.executed, hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // attach() -- hub not yet ready (tryConnect returns null)
  // -------------------------------------------------------------------------

  group('attach() -- hub availability timing', () {
    test('tryConnect returns null before service starts', () {
      expect(SignalingHubClient.tryConnect('attach-timing-pre'), isNull);
    });

    test('tryConnect returns non-null immediately after service starts', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      final client = SignalingHubClient.tryConnect('attach-timing-post');
      addTearDown(() => client?.dispose());
      expect(client, isNotNull);
    });

    test('tryConnect returns null after service stops', () async {
      final (:manager, :fakeClient) = await _startServiceSide();

      await manager.handleStatus(enabled: false);

      expect(SignalingHubClient.tryConnect('attach-timing-after-stop'), isNull);
    });
  });

  // -------------------------------------------------------------------------
  // pushBound lifecycle pattern: stop clears hub
  // -------------------------------------------------------------------------

  group('pushBound lifecycle pattern', () {
    test('hub is unavailable after manager stop (simulates pushBound service killed)', () async {
      final (:manager, :fakeClient) = await _startServiceSide();

      final (:hubClient, :hubModule) = await _attachMainSide('pb-lifecycle-1');
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);
      expect(hubModule.isConnected, isTrue);

      // Service stops (onTaskRemoved fires in pushBound mode).
      await manager.handleStatus(enabled: false);

      // Hub is gone -- new attach attempt returns null.
      expect(SignalingHubClient.tryConnect('pb-lifecycle-check'), isNull);
    });

    test('re-attach succeeds after manager restart (service restarted for new push)', () async {
      final fakeClient1 = _FakeSignalingClient();
      final fakeClient2 = _FakeSignalingClient();
      var cycle = 0;

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
            }) async => cycle == 0 ? fakeClient1 : fakeClient2,
      );

      // First push cycle.
      cycle = 0;
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      final side1 = await _attachMainSide('pb-restart-1');
      await _waitFor<SignalingConnected>(side1.hubModule.events);
      await side1.hubModule.dispose();

      await manager.handleStatus(enabled: false);

      // Second push cycle (new push arrives).
      cycle = 1;
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      addTearDown(() => manager.handleStatus(enabled: false));

      final side2 = await _attachMainSide('pb-restart-2');
      addTearDown(side2.hubModule.dispose);

      await _waitFor<SignalingConnected>(side2.hubModule.events);
      expect(side2.hubModule.isConnected, isTrue);
    });

    test('multiple start/stop cycles leave no stale hub port', () async {
      for (var i = 0; i < 3; i++) {
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
      }

      expect(SignalingHubClient.tryConnect('pb-stale-check'), isNull);
    });
  });

  // -------------------------------------------------------------------------
  // persistent lifecycle pattern: hub stays alive across re-attach
  // -------------------------------------------------------------------------

  group('persistent lifecycle pattern', () {
    test('hub remains registered across multiple client attach/detach cycles', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      // First attach.
      final side1 = await _attachMainSide('persistent-cycle-1a');
      await _waitFor<SignalingConnected>(side1.hubModule.events);
      await side1.hubModule.dispose();

      // Hub is still alive -- second attach succeeds.
      final side2 = await _attachMainSide('persistent-cycle-1b');
      addTearDown(side2.hubModule.dispose);

      await _waitFor<SignalingConnected>(side2.hubModule.events);
      expect(side2.hubModule.isConnected, isTrue);
    });

    test('hub continues broadcasting after one consumer disposes', () async {
      final (:manager, :fakeClient) = await _startServiceSide();
      addTearDown(() => manager.handleStatus(enabled: false));

      final side1 = await _attachMainSide('persistent-fanout-1a');
      final side2 = await _attachMainSide('persistent-fanout-1b');
      addTearDown(side2.hubModule.dispose);

      await Future.wait([
        _waitFor<SignalingConnected>(side1.hubModule.events),
        _waitFor<SignalingConnected>(side2.hubModule.events),
      ]);

      // side1 disposes (e.g. Activity closed, app backgrounded).
      await side1.hubModule.dispose();

      // Hub and side2 should still be live.
      final received = _waitFor<SignalingHandshakeReceived>(side2.hubModule.events);
      fakeClient.injectHandshake(_kHandshake);
      await received;
    });
  });
}
