/// Integration stress tests.
///
/// Cover three dimensions:
///   1. High-throughput event bursts -- 200 events broadcast to multiple clients.
///   2. Concurrent client load -- 8 clients subscribing simultaneously.
///   3. Rapid lifecycle cycles -- connect/disconnect and manager start/stop.
///
/// All tests use fake [WebtritSignalingClient] instances so no real network
/// traffic is generated. Timing budgets are intentionally tight to keep the
/// suite fast while still exercising race conditions in the port/stream path.
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
  int executeCount = 0;

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
  Future<void> execute(Request request, [Duration? timeout]) async => executeCount++;

  void injectEvent(Event e) => _onEvent?.call(e);
  void injectDisconnect(int? code, String? reason) => _onDisconnect?.call(code, reason);
}

// ---------------------------------------------------------------------------
// Local test manager (replaces SignalingForegroundIsolateManager for tests)
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
  await Future<void>.delayed(Duration.zero);
  return (module: module, hub: hub, fakeClient: fakeClient);
}

Future<SignalingHubClient> _subscribeClient(String consumerId) async {
  final client = SignalingHubClient.tryConnect(consumerId)!;
  final ackFuture = client.awaitAck(timeout: const Duration(seconds: 3));
  client.start();
  await ackFuture;
  return client;
}

Future<T> _waitFor<T extends SignalingModuleEvent>(Stream<SignalingModuleEvent> stream) =>
    stream.whereType<T>().first.timeout(const Duration(seconds: 5));

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // 1. High-throughput event bursts
  // -------------------------------------------------------------------------

  group('Stress -- event throughput', () {
    test('200 rapid protocol events reach a single subscribed client', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final client = await _subscribeClient('stress-throughput-1');
      addTearDown(client.dispose);

      await _waitFor<SignalingConnected>(client.events);

      const count = 200;
      final events = <SignalingProtocolEvent>[];
      final done = Completer<void>();

      client.events.whereType<SignalingProtocolEvent>().listen((e) {
        events.add(e);
        if (events.length == count) done.complete();
      });

      for (var i = 0; i < count; i++) {
        fakeClient.injectEvent(UnregisteredEvent());
      }

      await done.future.timeout(const Duration(seconds: 5));
      expect(events, hasLength(count));
    });

    test('200 events broadcast to 5 clients -- each client receives all 200', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      const clientCount = 5;
      const eventCount = 200;

      final clients = await Future.wait([for (var i = 0; i < clientCount; i++) _subscribeClient('stress-fan-out-$i')]);
      addTearDown(() => Future.wait(clients.map((c) => c.dispose())));

      // Drain session-buffer events that were already delivered to each client's
      // broadcast stream before the protocol-event listeners are attached.
      await Future<void>.delayed(Duration.zero);

      final counters = List<int>.filled(clientCount, 0);
      final dones = List<Completer<void>>.generate(clientCount, (_) => Completer<void>());

      for (var i = 0; i < clientCount; i++) {
        final idx = i;
        clients[idx].events.whereType<SignalingProtocolEvent>().listen((_) {
          counters[idx]++;
          if (counters[idx] == eventCount && !dones[idx].isCompleted) {
            dones[idx].complete();
          }
        });
      }

      for (var e = 0; e < eventCount; e++) {
        fakeClient.injectEvent(UnregisteredEvent());
      }

      await Future.wait(dones.map((d) => d.future.timeout(const Duration(seconds: 10))));

      for (var i = 0; i < clientCount; i++) {
        expect(counters[i], eventCount, reason: 'Client $i must receive all $eventCount events');
      }
    });

    test('50 rapid handshake + event pairs arrive in order for a single client', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final client = await _subscribeClient('stress-order-1');
      addTearDown(client.dispose);

      await _waitFor<SignalingConnected>(client.events);

      const pairCount = 50;
      final events = <SignalingModuleEvent>[];
      final done = Completer<void>();

      // Expect 50 handshakes + 50 protocol events = 100 non-connect events.
      client.events.listen((e) {
        if (e is SignalingHandshakeReceived || e is SignalingProtocolEvent) {
          events.add(e);
          if (events.length == pairCount * 2 && !done.isCompleted) done.complete();
        }
      });

      final handshake = StateHandshake(
        keepaliveInterval: const Duration(seconds: 30),
        timestamp: 0,
        registration: const Registration(status: RegistrationStatus.registered),
        lines: const [],
        userActiveCalls: const [],
        contactsPresenceInfo: const {},
        guestLine: null,
      );

      for (var i = 0; i < pairCount; i++) {
        fakeClient._onStateHandshake?.call(handshake);
        fakeClient.injectEvent(UnregisteredEvent());
      }

      await done.future.timeout(const Duration(seconds: 5));
      expect(events, hasLength(pairCount * 2));

      // Events must arrive in alternating handshake/protocol order.
      for (var i = 0; i < events.length; i++) {
        if (i.isEven) {
          expect(events[i], isA<SignalingHandshakeReceived>(), reason: 'index $i must be handshake');
        } else {
          expect(events[i], isA<SignalingProtocolEvent>(), reason: 'index $i must be protocol');
        }
      }
    });
  });

  // -------------------------------------------------------------------------
  // 2. Concurrent client load
  // -------------------------------------------------------------------------

  group('Stress -- concurrent clients', () {
    test('8 clients subscribe simultaneously and all receive sub-ack', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      const n = 8;
      final clients = await Future.wait([for (var i = 0; i < n; i++) _subscribeClient('stress-concurrent-$i')]);
      addTearDown(() => Future.wait(clients.map((c) => c.dispose())));

      // All clients subscribed without error (no exception thrown).
      expect(clients, hasLength(n));
    });

    test('8 clients each receive the same broadcast event', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      const n = 8;
      final clients = await Future.wait([for (var i = 0; i < n; i++) _subscribeClient('stress-broadcast-$i')]);
      addTearDown(() => Future.wait(clients.map((c) => c.dispose())));

      // Drain session-buffer events already delivered to broadcast streams.
      await Future<void>.delayed(Duration.zero);

      final futures = clients.map((c) => _waitFor<SignalingProtocolEvent>(c.events)).toList();
      fakeClient.injectEvent(UnregisteredEvent());

      final results = await Future.wait(futures);
      for (final r in results) {
        expect(r.event, isA<UnregisteredEvent>());
      }
    });

    test('clients can subscribe and unsubscribe independently', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      // Subscribe 4 clients, dispose 2 of them, verify remaining 2 still get events.
      final all = await Future.wait([for (var i = 0; i < 4; i++) _subscribeClient('stress-unsub-$i')]);

      // Drain session-buffer events already delivered to broadcast streams.
      await Future<void>.delayed(Duration.zero);

      // Dispose the first two.
      await all[0].dispose();
      await all[1].dispose();

      final remaining = [all[2], all[3]];
      addTearDown(() => Future.wait(remaining.map((c) => c.dispose())));

      final futures = remaining.map((c) => _waitFor<SignalingProtocolEvent>(c.events)).toList();
      fakeClient.injectEvent(RegisteredEvent());

      final results = await Future.wait(futures);
      for (final r in results) {
        expect(r.event, isA<RegisteredEvent>());
      }
    });
  });

  // -------------------------------------------------------------------------
  // 3. Rapid lifecycle cycles
  // -------------------------------------------------------------------------

  group('Stress -- rapid SignalingModule connect/disconnect cycles', () {
    test('20 rapid connect/disconnect cycles leave module in clean state', () async {
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
            }) async => _FakeSignalingClient(),
      );
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      const cycles = 20;
      for (var i = 0; i < cycles; i++) {
        module.connect();
        await Future<void>.delayed(Duration.zero);
        await module.disconnect();
      }

      // Final state: not connected, no pending operations.
      expect(module.isConnected, isFalse);
      expect(module.signalingClient, isNull);
    });

    test('20 rapid connect calls (no disconnect) -- only the last client survives', () async {
      WebtritSignalingClient? lastCreated;

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
              final c = _FakeSignalingClient();
              lastCreated = c;
              return c;
            },
      );
      addTearDown(module.dispose);

      const calls = 20;
      for (var i = 0; i < calls; i++) {
        module.connect();
      }
      await Future<void>.delayed(Duration.zero);

      // Multiple connect() calls created multiple clients, but only the last
      // one should be the active signalingClient.
      expect(module.signalingClient, same(lastCreated));
      expect(module.isConnected, isTrue);
    });

    test('module handles rapid inject after rapid reconnect without exceptions', () async {
      final clients = <_FakeSignalingClient>[];

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
              final c = _FakeSignalingClient();
              clients.add(c);
              return c;
            },
      );
      addTearDown(module.dispose);

      final errors = <Object>[];
      module.events.listen(null, onError: errors.add);

      for (var i = 0; i < 10; i++) {
        module.connect();
        await Future<void>.delayed(Duration.zero);
        // Inject an event from whichever client was most recently created.
        clients.lastOrNull?.injectEvent(UnregisteredEvent());
      }

      await Future<void>.delayed(Duration.zero);
      expect(errors, isEmpty, reason: 'No unhandled errors expected during rapid reconnects');
    });
  });

  group('Stress -- rapid SignalingForegroundIsolateManager start/stop cycles', () {
    test('5 start/stop cycles leave no stale port in IsolateNameServer', () async {
      const cycles = 5;
      for (var i = 0; i < cycles; i++) {
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

      // After all cycles, no hub is registered.
      expect(SignalingHubClient.tryConnect('stress-manager-cycle-check'), isNull);
    });

    test('manager restart re-registers hub -- client can reconnect after stop/start', () async {
      final fakeClient1 = _FakeSignalingClient();
      final fakeClient2 = _FakeSignalingClient();

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
            }) async => _fakeClientToggle == 0 ? fakeClient1 : fakeClient2,
      );

      // First cycle.
      _fakeClientToggle = 0;
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      var hubClient = await _subscribeClient('stress-restart-1');
      await _waitFor<SignalingConnected>(hubClient.events);
      await hubClient.dispose();

      await manager.handleStatus(enabled: false);
      expect(SignalingHubClient.tryConnect('stress-restart-check'), isNull);

      // Second cycle -- hub re-registers under the same port name.
      _fakeClientToggle = 1;
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      hubClient = await _subscribeClient('stress-restart-2');
      addTearDown(hubClient.dispose);

      await _waitFor<SignalingConnected>(hubClient.events);
      // Passes if no exception thrown.

      await manager.handleStatus(enabled: false);
    });
  });

  // -------------------------------------------------------------------------
  // 4. Concurrent execute under load
  // -------------------------------------------------------------------------

  group('Stress -- concurrent execute', () {
    test('10 concurrent execute calls all complete successfully', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final client = await _subscribeClient('stress-exec-1');
      addTearDown(client.dispose);

      // Wait for connected state so execute is routed properly.
      await _waitFor<SignalingConnected>(client.events);

      const count = 10;
      final futures = [
        for (var i = 0; i < count; i++)
          client.execute(HangupRequest(transaction: 'tx-stress-$i', line: i % 4 + 1, callId: 'call-$i')),
      ];

      await Future.wait(futures).timeout(const Duration(seconds: 5));
      expect(fakeClient.executeCount, count);
    });

    test('10 concurrent executes via SignalingHubModule all complete', () async {
      final (:module, :hub, :fakeClient) = await _buildServerSide();
      addTearDown(() async {
        await hub.dispose();
        await module.dispose();
      });

      final hubClient = await _subscribeClient('stress-hm-exec-1');
      final hubModule = SignalingHubModule(hubClient);
      addTearDown(hubModule.dispose);

      await _waitFor<SignalingConnected>(hubModule.events);

      const count = 10;
      final futures = [
        for (var i = 0; i < count; i++)
          hubModule.execute(HangupRequest(transaction: 'tx-hm-$i', line: 1, callId: 'call-hm-$i')),
      ];

      await Future.wait(futures.whereType<Future<void>>()).timeout(const Duration(seconds: 5));
      expect(fakeClient.executeCount, count);
    });
  });
}

// ---------------------------------------------------------------------------
// Toggle helper for manager restart test
// ---------------------------------------------------------------------------

int _fakeClientToggle = 0;
