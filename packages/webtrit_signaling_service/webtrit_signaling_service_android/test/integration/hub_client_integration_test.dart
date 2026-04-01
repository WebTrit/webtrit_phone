/// Integration tests for [SignalingHub] <-> [SignalingHubClient] IPC.
///
/// These tests run entirely within a single Dart isolate -- they exercise the
/// real [ReceivePort]/[SendPort] path and [IsolateNameServer] registration
/// without spawning a background isolate or touching the Android service.
///
/// All tests are sequential; each tearDown disposes the hub and removes the
/// port name mapping so the next test starts clean.
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

class _SignalingModule implements SignalingModuleInterface {
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
// Shared fake signaling client
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
  Future<void> disconnect([int? code, String? reason]) async => disconnected = true;

  @override
  Future<void> execute(Request request, [Duration? timeout]) async => executed.add(request);

  void injectHandshake(StateHandshake h) => _onStateHandshake?.call(h);
  void injectEvent(Event e) => _onEvent?.call(e);
  void injectDisconnect(int? code, String? reason) => _onDisconnect?.call(code, reason);
}

// ---------------------------------------------------------------------------
// Shared handshake fixture
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

_SignalingModule _buildModule(_FakeSignalingClient client) => _SignalingModule(
  coreUrl: 'https://example.com',
  tenantId: 'tenant',
  token: 'token',
  trustedCertificates: TrustedCertificates.empty,
  signalingClientFactory: _fakeFactory(client),
);

/// Waits for a specific event type to appear on [stream] with a 2-second timeout.
Future<T> _waitFor<T extends SignalingModuleEvent>(Stream<SignalingModuleEvent> stream) =>
    stream.whereType<T>().first.timeout(const Duration(seconds: 2));

/// Creates a [SignalingHubClient], awaits the sub-ack, and returns it ready
/// for use.
Future<SignalingHubClient> _subscribeClient(String consumerId) async {
  final client = SignalingHubClient.tryConnect(consumerId);
  expect(client, isNotNull, reason: 'Hub must be registered before subscribing');
  final ackFuture = client!.awaitAck(timeout: const Duration(seconds: 2));
  client.start();
  final acked = await ackFuture;
  expect(acked, isTrue, reason: 'Sub-ack must arrive from hub within timeout');
  return client;
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // Hub registration
  // -------------------------------------------------------------------------

  group('Hub registration', () {
    test('tryConnect returns null before hub.start()', () {
      expect(SignalingHubClient.tryConnect('consumer-0'), isNull);
    });

    test('tryConnect returns non-null after hub.start()', () async {
      final fakeClient = _FakeSignalingClient();
      final module = _buildModule(fakeClient);
      final hub = SignalingHub(module);
      hub.start();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final client = SignalingHubClient.tryConnect('consumer-1');
      addTearDown(() => client?.dispose());
      expect(client, isNotNull);
    });

    test('tryConnect returns null after hub.dispose()', () async {
      final fakeClient = _FakeSignalingClient();
      final module = _buildModule(fakeClient);
      final hub = SignalingHub(module);
      hub.start();

      await hub.dispose();
      await module.dispose();

      expect(SignalingHubClient.tryConnect('consumer-2'), isNull);
    });

    test('hub.start() is idempotent -- double start does not duplicate registration', () async {
      final fakeClient = _FakeSignalingClient();
      final module = _buildModule(fakeClient);
      final hub = SignalingHub(module);
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      hub.start();
      hub.start(); // second call must be no-op

      // Still exactly one port registered -- client can find it.
      expect(SignalingHubClient.tryConnect('consumer-3'), isNotNull);
    });
  });

  // -------------------------------------------------------------------------
  // Subscribe and sub-ack protocol
  // -------------------------------------------------------------------------

  group('Subscribe and sub-ack', () {
    late _FakeSignalingClient fakeClient;
    late _SignalingModule module;
    late SignalingHub hub;

    setUp(() {
      fakeClient = _FakeSignalingClient();
      module = _buildModule(fakeClient);
      hub = SignalingHub(module);
      hub.start();
    });

    tearDown(() async {
      await hub.dispose();
      await module.dispose();
    });

    test('awaitAck() returns true when hub is alive', () async {
      final client = SignalingHubClient.tryConnect('ack-test-1')!;
      addTearDown(client.dispose);

      final ackFuture = client.awaitAck(timeout: const Duration(seconds: 2));
      client.start();

      expect(await ackFuture, isTrue);
    });

    test('awaitAck() returns false when hub port is stale (no hub running)', () async {
      // Dispose hub so port is gone but we already have the SendPort reference
      // indirectly via a dummy port. We simulate timeout by using an
      // unreachable consumer id on a non-started client.
      final client = SignalingHubClient.tryConnect('ack-test-2')!;
      addTearDown(client.dispose);

      // Do NOT call start() -- ack will never arrive -> timeout returns false.
      final acked = await client.awaitAck(timeout: const Duration(milliseconds: 50));
      expect(acked, isFalse);
    });

    test('multiple subscribers each receive their own ack', () async {
      final c1 = await _subscribeClient('multi-ack-1');
      final c2 = await _subscribeClient('multi-ack-2');
      addTearDown(c1.dispose);
      addTearDown(c2.dispose);

      // Both clients subscribed successfully -- no exception thrown.
      expect(c1.consumerId, 'multi-ack-1');
      expect(c2.consumerId, 'multi-ack-2');
    });
  });

  // -------------------------------------------------------------------------
  // Event broadcasting: hub -> subscribed clients
  // -------------------------------------------------------------------------

  group('Event broadcasting', () {
    late _FakeSignalingClient fakeClient;
    late _SignalingModule module;
    late SignalingHub hub;

    setUp(() async {
      fakeClient = _FakeSignalingClient();
      module = _buildModule(fakeClient);
      hub = SignalingHub(module);
      hub.start();
      module.connect();
      await Future<void>.delayed(Duration.zero); // let _connectAsync complete
    });

    tearDown(() async {
      await hub.dispose();
      await module.dispose();
    });

    test('subscribed client receives SignalingConnecting and SignalingConnected', () async {
      // Module connects before client subscribes; session buffer replays to client.
      final client = await _subscribeClient('broadcast-1');
      addTearDown(client.dispose);

      final events = <SignalingModuleEvent>[];
      client.events.listen(events.add);
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingConnecting>(), hasLength(1));
      expect(events.whereType<SignalingConnected>(), hasLength(1));
    });

    test('client receives SignalingHandshakeReceived after hub broadcasts it', () async {
      final client = await _subscribeClient('broadcast-2');
      addTearDown(client.dispose);

      final received = _waitFor<SignalingHandshakeReceived>(client.events);
      fakeClient.injectHandshake(_kHandshake);

      final event = await received;
      expect(event.handshake.keepaliveInterval, _kHandshake.keepaliveInterval);
      expect(event.handshake.timestamp, _kHandshake.timestamp);
    });

    test('client receives SignalingProtocolEvent after hub broadcasts it', () async {
      final client = await _subscribeClient('broadcast-3');
      addTearDown(client.dispose);

      final received = _waitFor<SignalingProtocolEvent>(client.events);
      fakeClient.injectEvent(UnregisteredEvent());

      final event = await received;
      expect(event.event, isA<UnregisteredEvent>());
    });

    test('client receives SignalingDisconnected when server disconnects', () async {
      final client = await _subscribeClient('broadcast-4');
      addTearDown(client.dispose);

      final received = _waitFor<SignalingDisconnected>(client.events);
      fakeClient.injectDisconnect(1000, 'normal');

      final disc = await received;
      expect(disc.code, 1000);
      expect(disc.knownCode, SignalingDisconnectCode.normalClosure);
    });

    test('all subscribed clients receive the same broadcast event', () async {
      final c1 = await _subscribeClient('fan-out-1');
      final c2 = await _subscribeClient('fan-out-2');
      final c3 = await _subscribeClient('fan-out-3');
      addTearDown(c1.dispose);
      addTearDown(c2.dispose);
      addTearDown(c3.dispose);

      final f1 = _waitFor<SignalingHandshakeReceived>(c1.events);
      final f2 = _waitFor<SignalingHandshakeReceived>(c2.events);
      final f3 = _waitFor<SignalingHandshakeReceived>(c3.events);

      fakeClient.injectHandshake(_kHandshake);

      final results = await Future.wait([f1, f2, f3]);
      for (final r in results) {
        expect(r.handshake.timestamp, _kHandshake.timestamp);
      }
    });
  });

  // -------------------------------------------------------------------------
  // Session buffer replay for late subscribers
  // -------------------------------------------------------------------------

  group('Session buffer replay', () {
    late _FakeSignalingClient fakeClient;
    late _SignalingModule module;
    late SignalingHub hub;

    setUp(() async {
      fakeClient = _FakeSignalingClient();
      module = _buildModule(fakeClient);
      hub = SignalingHub(module);
      hub.start();
      module.connect();
      await Future<void>.delayed(Duration.zero);
    });

    tearDown(() async {
      await hub.dispose();
      await module.dispose();
    });

    test('late subscriber receives full session buffer on connect', () async {
      // Inject handshake before any client subscribes.
      fakeClient.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      // Late client subscribes after all events have been buffered.
      final client = await _subscribeClient('late-1');
      addTearDown(client.dispose);

      final events = <SignalingModuleEvent>[];
      client.events.listen(events.add);
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingConnecting>(), hasLength(1));
      expect(events.whereType<SignalingConnected>(), hasLength(1));
      expect(events.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });

    test('new session clears buffer -- late subscriber sees only new session', () async {
      // Session 1: connect, handshake, then disconnect.
      fakeClient.injectHandshake(_kHandshake);
      fakeClient.injectDisconnect(1000, 'done');
      await Future<void>.delayed(Duration.zero);

      // Session 2: reconnect (module.connect clears buffer internally).
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // Late subscriber joins after session 2 started.
      final client = await _subscribeClient('late-2');
      addTearDown(client.dispose);

      final events = <SignalingModuleEvent>[];
      client.events.listen(events.add);
      await Future<void>.delayed(Duration.zero);

      // Must NOT receive handshake from session 1.
      expect(events.whereType<SignalingHandshakeReceived>(), isEmpty);
      // Must see session 2's SignalingConnecting.
      expect(events.whereType<SignalingConnecting>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // Execute routing through hub
  // -------------------------------------------------------------------------

  group('Execute routing', () {
    late _FakeSignalingClient fakeClient;
    late _SignalingModule module;
    late SignalingHub hub;

    setUp(() async {
      fakeClient = _FakeSignalingClient();
      module = _buildModule(fakeClient);
      hub = SignalingHub(module);
      hub.start();
      module.connect();
      await Future<void>.delayed(Duration.zero); // module now connected
    });

    tearDown(() async {
      await hub.dispose();
      await module.dispose();
    });

    test('execute completes successfully and reaches fake signaling client', () async {
      final client = await _subscribeClient('exec-1');
      addTearDown(client.dispose);

      final request = HangupRequest(transaction: 'tx-exec-1', line: 1, callId: 'call-a');
      await client.execute(request).timeout(const Duration(seconds: 2));

      expect(fakeClient.executed, hasLength(1));
    });

    test('execute result carries no error on success', () async {
      final client = await _subscribeClient('exec-2');
      addTearDown(client.dispose);

      // Should not throw.
      await expectLater(
        client
            .execute(HangupRequest(transaction: 'tx-exec-2', line: 1, callId: 'call-b'))
            .timeout(const Duration(seconds: 2)),
        completes,
      );
    });

    test('execute fails with error when module is not connected', () async {
      // Disconnect the module so signalingClient is null.
      await module.disconnect();

      final client = await _subscribeClient('exec-3');
      addTearDown(client.dispose);

      await expectLater(
        client
            .execute(HangupRequest(transaction: 'tx-exec-3', line: 1, callId: 'call-c'))
            .timeout(const Duration(seconds: 2)),
        throwsA(anything),
      );
    });

    test('pending execute completes with error on client dispose', () async {
      final client = await _subscribeClient('exec-4');

      final executeFuture = client.execute(HangupRequest(transaction: 'tx-exec-4', line: 1, callId: 'call-d'));
      // Attach the expectation synchronously before dispose() so the Future
      // error is handled rather than becoming an unhandled zone error.
      final expectFuture = expectLater(executeFuture, throwsA(anything));
      await client.dispose();
      await expectFuture;
    });
  });

  // -------------------------------------------------------------------------
  // SignalingHubModule as thin wrapper
  // -------------------------------------------------------------------------

  group('SignalingHubModule via hub', () {
    late _FakeSignalingClient fakeClient;
    late _SignalingModule module;
    late SignalingHub hub;

    setUp(() async {
      fakeClient = _FakeSignalingClient();
      module = _buildModule(fakeClient);
      hub = SignalingHub(module);
      hub.start();
      module.connect();
      await Future<void>.delayed(Duration.zero);
    });

    tearDown(() async {
      await hub.dispose();
      await module.dispose();
    });

    test('SignalingHubModule.events delivers hub events', () async {
      final client = await _subscribeClient('hm-1');
      final hubModule = SignalingHubModule(client);
      addTearDown(hubModule.dispose);

      final connected = _waitFor<SignalingConnected>(hubModule.events);
      // Session buffer is replayed on subscribe -- connected is already buffered.
      await connected.timeout(const Duration(seconds: 2));

      expect(hubModule.isConnected, isTrue);
    });

    test('SignalingHubModule.execute routes through hub to signalingClient', () async {
      final client = await _subscribeClient('hm-2');
      final hubModule = SignalingHubModule(client);
      addTearDown(hubModule.dispose);

      // Wait until connected.
      await _waitFor<SignalingConnected>(hubModule.events);

      await hubModule
          .execute(HangupRequest(transaction: 'tx-hm', line: 1, callId: 'call-hm'))!
          .timeout(const Duration(seconds: 2));

      expect(fakeClient.executed, hasLength(1));
    });

    test('SignalingHubModule.isConnected reflects hub module state', () async {
      final client = await _subscribeClient('hm-3');
      final hubModule = SignalingHubModule(client);
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);
      expect(hubModule.isConnected, isTrue);

      fakeClient.injectDisconnect(1000, 'done');
      await _waitFor<SignalingDisconnected>(hubModule.events);
      expect(hubModule.isConnected, isFalse);
    });
  });
}
