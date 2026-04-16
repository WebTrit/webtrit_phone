import 'dart:async';
import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import 'package:webtrit_phone/app/constants.dart';

// ---------------------------------------------------------------------------
// Fakes / Mocks
// ---------------------------------------------------------------------------

class _FakeSignalingClient extends Fake implements WebtritSignalingClient {
  StateHandshakeHandler? _onStateHandshake;
  EventHandler? _onEvent;
  ErrorHandler? _onError;
  DisconnectHandler? _onDisconnect;

  bool disconnected = false;
  int? lastDisconnectCode;
  int executeCallCount = 0;
  final Queue<Object?> _executeResponses = Queue<Object?>();

  @override
  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {
    _onStateHandshake = onStateHandshake;
    _onEvent = onEvent;
    _onError = onError;
    _onDisconnect = onDisconnect;
  }

  @override
  Future<void> disconnect([int? code, String? reason]) async {
    disconnected = true;
    lastDisconnectCode = code;
  }

  @override
  Future<void> execute(Request request, [Duration? timeout]) async {
    executeCallCount += 1;
    if (_executeResponses.isEmpty) return;
    final response = _executeResponses.removeFirst();
    if (response != null) throw response;
  }

  // Helpers to inject server-side messages in tests.
  void injectHandshake(StateHandshake handshake) => _onStateHandshake?.call(handshake);
  void injectEvent(Event event) => _onEvent?.call(event);
  void injectError(Object error, [StackTrace? st]) => _onError?.call(error, st);
  void injectDisconnect(int? code, String? reason) => _onDisconnect?.call(code, reason);
  void enqueueExecuteTimeout() => _executeResponses.add(WebtritSignalingTransactionTimeoutException(1, 'tx-timeout'));
  void enqueueExecuteError(Object error) => _executeResponses.add(error);
  void enqueueExecuteSuccess() => _executeResponses.add(null);
}

/// Variant of [_FakeSignalingClient] whose [disconnect] always throws.
/// Used to test that [SignalingModule.dispose] completes even when the
/// underlying WebSocket close fails.
class _ThrowingDisconnectClient extends Fake implements WebtritSignalingClient {
  @override
  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {}

  @override
  Future<void> disconnect([int? code, String? reason]) async {
    throw StateError('simulated disconnect failure');
  }

  @override
  Future<void> execute(Request request, [Duration? timeout]) async {}
}

// ---------------------------------------------------------------------------
// Factory helpers
// ---------------------------------------------------------------------------

/// Returns a factory that completes successfully with the given client.
SignalingClientFactory _successFactory(_FakeSignalingClient client) {
  return ({
    required Uri url,
    required String tenantId,
    required String token,
    required Duration connectionTimeout,
    required TrustedCertificates certs,
    required bool force,
  }) async => client;
}

/// Returns a factory that throws [error] on every call.
SignalingClientFactory _failingFactory(Object error) {
  return ({
    required Uri url,
    required String tenantId,
    required String token,
    required Duration connectionTimeout,
    required TrustedCertificates certs,
    required bool force,
  }) async => throw error;
}

/// A factory backed by a completer - the test controls when the connection resolves.
class _ControlledFactory {
  Completer<WebtritSignalingClient>? _completer;

  SignalingClientFactory get factory =>
      ({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) {
        _completer = Completer<WebtritSignalingClient>();
        return _completer!.future;
      };

  void complete(WebtritSignalingClient client) => _completer?.complete(client);
  void fail(Object error) => _completer?.completeError(error);
}

// ---------------------------------------------------------------------------
// Shared handshake fixture
// ---------------------------------------------------------------------------

final _kHandshake = StateHandshake(
  keepaliveInterval: const Duration(seconds: 30),
  timestamp: 1705322000000,
  registration: const Registration(status: RegistrationStatus.registered),
  lines: const [],
  dialogInfos: const [],
  presenceInfos: const [],
  guestLine: null,
);

// ---------------------------------------------------------------------------
// Module builder
// ---------------------------------------------------------------------------

SignalingModuleImpl _buildModule(SignalingClientFactory factory) => SignalingModuleImpl(
  coreUrl: 'https://example.com',
  tenantId: 'test-tenant',
  token: 'test-token',
  trustedCertificates: TrustedCertificates.empty,
  connectionTimeout: kSignalingClientConnectionTimeout,
  reconnectDelay: kSignalingClientReconnectDelay,
  clientFactory: factory,
);

Request _buildRequest() => HangupRequest(transaction: 'tx-1', line: 0, callId: 'call-1');

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // Unit tests - pure SignalingModule behaviour, no real WebSocket.
  // -------------------------------------------------------------------------

  group('SignalingModule - connect()', () {
    test('emits SignalingConnecting then SignalingConnected on success', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();

      expect(events, hasLength(2));
      expect(events[0], isA<SignalingConnecting>());
      expect(events[1], isA<SignalingConnected>());
    });

    test('signalingClient is set after SignalingConnected', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      expect(module.signalingClient, isNull);

      module.connect();
      await pumpEventQueue();

      expect(module.signalingClient, same(client));
    });

    test('emits SignalingConnecting then SignalingConnectionFailed on factory error', () async {
      final error = Exception('connection refused');
      final module = _buildModule(_failingFactory(error));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();

      expect(events, hasLength(2));
      expect(events[0], isA<SignalingConnecting>());
      final failed = events[1] as SignalingConnectionFailed;
      expect(failed.error, same(error));
      expect(failed.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('signalingClient remains null after connection failure', () async {
      final module = _buildModule(_failingFactory(Exception('refused')));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      expect(module.signalingClient, isNull);
    });

    test('does nothing when called after dispose()', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      // Subscribe before dispose so stream is drained after close.
      final events = <SignalingModuleEvent>[];
      final sub = module.events.listen(events.add);

      await module.dispose();

      module.connect(); // must not throw or emit after dispose
      await pumpEventQueue();

      await sub.cancel();
      // Only Disconnecting + Disconnected from dispose() may appear; no
      // Connecting or Connected from the post-dispose connect() call.
      expect(events.whereType<SignalingConnecting>(), isEmpty);
      expect(events.whereType<SignalingConnected>(), isEmpty);
    });

    test('reconnects (disconnects existing client) when already connected', () async {
      final firstClient = _FakeSignalingClient();
      final secondClient = _FakeSignalingClient();
      var callCount = 0;

      final module = _buildModule(({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) async {
        callCount++;
        return callCount == 1 ? firstClient : secondClient;
      });
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // First connect.
      module.connect();
      await pumpEventQueue();

      // Second connect while already connected.
      module.connect();
      await pumpEventQueue();

      expect(firstClient.disconnected, isTrue);
      expect(module.signalingClient, same(secondClient));
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule - disconnect()', () {
    test('emits SignalingDisconnecting and calls client.disconnect', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();

      events.clear(); // discard Connecting + Connected; focus on disconnect
      await module.disconnect();

      expect(events, hasLength(1));
      expect(events[0], isA<SignalingDisconnecting>());
      expect(client.disconnected, isTrue);
      expect(module.signalingClient, isNull);
    });

    test('is a no-op when there is no active client', () async {
      final module = _buildModule(_failingFactory(Exception('x')));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      await module.disconnect();

      expect(events, isEmpty);
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule - execute()', () {
    test('retries timeout up to 3 times and succeeds on the next attempt', () async {
      final client = _FakeSignalingClient()
        ..enqueueExecuteTimeout()
        ..enqueueExecuteTimeout()
        ..enqueueExecuteTimeout()
        ..enqueueExecuteSuccess();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      await expectLater(module.execute(_buildRequest()), completes);
      expect(client.executeCallCount, equals(4));
    });

    test('throws timeout error after retry limit is exhausted', () async {
      final client = _FakeSignalingClient()
        ..enqueueExecuteTimeout()
        ..enqueueExecuteTimeout()
        ..enqueueExecuteTimeout()
        ..enqueueExecuteTimeout();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      await expectLater(module.execute(_buildRequest()), throwsA(isA<WebtritSignalingTransactionTimeoutException>()));
      expect(client.executeCallCount, equals(4));
    });

    test('does not retry non-timeout execute errors', () async {
      final client = _FakeSignalingClient()..enqueueExecuteError(StateError('execute failed'));
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      await expectLater(module.execute(_buildRequest()), throwsA(isA<StateError>()));
      expect(client.executeCallCount, equals(1));
    });

    test('queued execute is flushed on connect and uses timeout retries', () async {
      final client = _FakeSignalingClient()
        ..enqueueExecuteTimeout()
        ..enqueueExecuteTimeout()
        ..enqueueExecuteSuccess();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final pending = module.execute(_buildRequest());
      expect(pending, isNotNull);

      module.connect();
      await pumpEventQueue();

      await expectLater(pending, completes);
      expect(client.executeCallCount, equals(3));
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule - dispose()', () {
    test('closes the event stream', () async {
      final module = _buildModule(_failingFactory(Exception('x')));

      final done = Completer<void>();
      module.events.listen(null, onDone: done.complete);

      await module.dispose();
      await done.future.timeout(const Duration(seconds: 1));
    });

    test('calls disconnect on the active client', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      module.connect();
      await pumpEventQueue();

      await module.dispose();

      expect(client.disconnected, isTrue);
    });

    test('second dispose() call is a no-op', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      module.connect();
      await pumpEventQueue();

      await module.dispose();
      await module.dispose(); // must not throw
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule - server-pushed events', () {
    test('_onHandshake emits SignalingHandshakeReceived', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      SignalingHandshakeReceived? received;
      module.events.listen((e) {
        if (e is SignalingHandshakeReceived) received = e;
      });

      client.injectHandshake(_kHandshake);
      await pumpEventQueue();

      expect(received?.handshake, same(_kHandshake));
    });

    test('_onEvent emits SignalingProtocolEvent', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      SignalingProtocolEvent? received;
      module.events.listen((e) {
        if (e is SignalingProtocolEvent) received = e;
      });

      final event = UnregisteredEvent();
      client.injectEvent(event);
      await pumpEventQueue();

      expect(received?.event, same(event));
    });

    test('_onError emits SignalingConnectionFailed and clears signalingClient', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      SignalingConnectionFailed? failed;
      module.events.listen((e) {
        if (e is SignalingConnectionFailed) failed = e;
      });

      final error = Exception('keepalive timeout');
      client.injectError(error);
      await pumpEventQueue();

      expect(failed, isNotNull);
      expect(failed!.error, same(error));
      expect(module.signalingClient, isNull);
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule - _reconnectDelay', () {
    Future<SignalingDisconnected> disconnectWith(int code) async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      SignalingDisconnected? disc;
      module.events.listen((e) {
        if (e is SignalingDisconnected) disc = e;
      });

      client.injectDisconnect(code, 'test');
      await pumpEventQueue();

      return disc!;
    }

    test('controllerForceAttachClose (4441) -> recommendedReconnectDelay is Duration.zero', () async {
      final disc = await disconnectWith(SignalingDisconnectCode.controllerForceAttachClose.code);

      expect(disc.knownCode, SignalingDisconnectCode.controllerForceAttachClose);
      expect(disc.recommendedReconnectDelay, Duration.zero);
    });

    test('protocolError (1002) -> recommendedReconnectDelay is null', () async {
      final disc = await disconnectWith(SignalingDisconnectCode.protocolError.code);

      expect(disc.knownCode, SignalingDisconnectCode.protocolError);
      expect(disc.recommendedReconnectDelay, isNull);
    });

    test('normalClosure (1000) -> recommendedReconnectDelay is kSignalingClientReconnectDelay', () async {
      final disc = await disconnectWith(SignalingDisconnectCode.normalClosure.code);

      expect(disc.knownCode, SignalingDisconnectCode.normalClosure);
      expect(disc.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('unknown code -> unmappedCode, recommendedReconnectDelay is kSignalingClientReconnectDelay', () async {
      const unknownCode = 9999;
      final disc = await disconnectWith(unknownCode);

      expect(disc.knownCode, SignalingDisconnectCode.unmappedCode);
      expect(disc.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('null code -> unmappedCode, recommendedReconnectDelay is kSignalingClientReconnectDelay', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      SignalingDisconnected? disc;
      module.events.listen((e) {
        if (e is SignalingDisconnected) disc = e;
      });

      client.injectDisconnect(null, null);
      await pumpEventQueue();

      expect(disc?.code, isNull);
      expect(disc?.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('signalingClient is null after disconnect event', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      client.injectDisconnect(1000, 'done');
      await pumpEventQueue();

      expect(module.signalingClient, isNull);
    });
  });

  // -------------------------------------------------------------------------
  // Integration tests - full lifecycle sequences.
  // -------------------------------------------------------------------------

  group('SignalingModule - integration: connect -> handshake -> event -> disconnect', () {
    test('full happy-path lifecycle emits events in correct order', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // 1. Connect.
      module.connect();
      await pumpEventQueue();

      // 2. Server sends handshake.
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();

      // 3. Server sends a protocol event.
      final protocolEvent = UnregisteredEvent();
      client.injectEvent(protocolEvent);
      await pumpEventQueue();

      // 4. Graceful disconnect.
      await module.disconnect();

      await module.dispose();

      expect(events[0], isA<SignalingConnecting>());
      expect(events[1], isA<SignalingConnected>());
      expect(events[2], isA<SignalingHandshakeReceived>());
      expect((events[2] as SignalingHandshakeReceived).handshake, _kHandshake);
      expect(events[3], isA<SignalingProtocolEvent>());
      expect((events[3] as SignalingProtocolEvent).event, same(protocolEvent));
      expect(events[4], isA<SignalingDisconnecting>());
    });
  });

  group('SignalingModule - integration: failure -> reconnect -> success', () {
    test('failed connect followed by successful reconnect emits correct sequence', () async {
      final goodClient = _FakeSignalingClient();
      final error = Exception('TLS handshake failed');
      var callCount = 0;

      final module = _buildModule(({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) async {
        callCount++;
        if (callCount == 1) throw error;
        return goodClient;
      });
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // First attempt - fails.
      module.connect();
      await pumpEventQueue();

      // Second attempt - succeeds.
      module.connect();
      await pumpEventQueue();

      expect(events[0], isA<SignalingConnecting>());
      expect(events[1], isA<SignalingConnectionFailed>());
      expect(events[2], isA<SignalingConnecting>());
      expect(events[3], isA<SignalingConnected>());
      expect(module.signalingClient, same(goodClient));
    });
  });

  group('SignalingModule - integration: server-forced reconnect (code 4441)', () {
    test('server close with 4441 emits SignalingDisconnected with Duration.zero delay', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      final discEvents = <SignalingDisconnected>[];
      module.events.listen((e) {
        if (e is SignalingDisconnected) discEvents.add(e);
      });

      // Server evicts the session (duplicate attach).
      client.injectDisconnect(SignalingDisconnectCode.controllerForceAttachClose.code, 'force attach');
      await pumpEventQueue();

      expect(discEvents, hasLength(1));
      expect(discEvents[0].recommendedReconnectDelay, Duration.zero);

      // Consumer would immediately reconnect here - simulate it.
      final nextClient = _FakeSignalingClient();
      final module2 = _buildModule(_successFactory(nextClient));
      addTearDown(module2.dispose);

      final connected = <SignalingConnected>[];
      module2.events.listen((e) {
        if (e is SignalingConnected) connected.add(e);
      });

      module2.connect();
      await pumpEventQueue();

      expect(connected, hasLength(1));
    });
  });

  group('SignalingModule - integration: dispose during pending connect', () {
    test('dispose while factory is in flight does not emit events after dispose', () async {
      final controlled = _ControlledFactory();
      final module = _buildModule(controlled.factory);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add, onDone: () {});

      module.connect(); // fires factory, hangs in _connectAsync
      // Dispose before factory completes.
      await module.dispose();

      // Now complete the factory with a fresh client.
      final lateClient = _FakeSignalingClient();
      controlled.complete(lateClient);
      await pumpEventQueue();

      // After dispose, the module should have disconnected the late client
      // and must not emit SignalingConnected.
      expect(events.whereType<SignalingConnected>(), isEmpty);
      expect(lateClient.disconnected, isTrue);
    });

    test('dispose while factory throws does not emit SignalingConnectionFailed after close', () async {
      final controlled = _ControlledFactory();
      final module = _buildModule(controlled.factory);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add, onDone: () {});

      module.connect();
      await module.dispose();

      controlled.fail(Exception('timeout'));
      await pumpEventQueue();

      expect(events.whereType<SignalingConnectionFailed>(), isEmpty);
    });
  });

  group('SignalingModule - integration: multiple listeners', () {
    test('broadcast stream delivers events to all active listeners', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final listenerA = <SignalingModuleEvent>[];
      final listenerB = <SignalingModuleEvent>[];
      module.events.listen(listenerA.add);
      module.events.listen(listenerB.add);

      module.connect();
      await pumpEventQueue();
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();

      expect(listenerA.whereType<SignalingConnected>(), hasLength(1));
      expect(listenerA.whereType<SignalingHandshakeReceived>(), hasLength(1));
      expect(listenerB.whereType<SignalingConnected>(), hasLength(1));
      expect(listenerB.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule - integration: late subscriber replay', () {
    test('late subscriber receives all buffered events from the current session', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      // Connect and receive handshake BEFORE any subscriber exists.
      module.connect();
      await pumpEventQueue();
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();

      // Late subscriber - attaches after connect + handshake have already happened.
      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await pumpEventQueue();

      expect(late.whereType<SignalingConnecting>(), hasLength(1));
      expect(late.whereType<SignalingConnected>(), hasLength(1));
      expect(late.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });

    test('connect() clears the buffer so late subscribers see only the new session', () async {
      final client1 = _FakeSignalingClient();
      var callCount = 0;
      final client2 = _FakeSignalingClient();

      final module = _buildModule(({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) async {
        callCount++;
        return callCount == 1 ? client1 : client2;
      });
      addTearDown(module.dispose);

      // First session - connect, handshake, then disconnect.
      module.connect();
      await pumpEventQueue();
      client1.injectHandshake(_kHandshake);
      await pumpEventQueue();
      client1.injectDisconnect(1000, 'done');
      await pumpEventQueue();

      // Second session - reconnect clears the buffer.
      module.connect();
      await pumpEventQueue();

      // Late subscriber joins after the second connect() but before handshake.
      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await pumpEventQueue();

      // Should see only the second session's SignalingConnecting, not the first session's events.
      expect(
        late.whereType<SignalingHandshakeReceived>(),
        isEmpty,
        reason: 'Handshake from the first session must not be replayed',
      );
      expect(late.whereType<SignalingConnecting>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // Concurrency - _connecting guard
  // -------------------------------------------------------------------------

  group('SignalingModule - concurrent connect()', () {
    test('second connect() while factory in-flight is dropped, not queued', () async {
      final controlled = _ControlledFactory();
      final module = _buildModule(controlled.factory);
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // First connect - factory is pending.
      module.connect();
      // Second connect() fires while first is still in-flight.
      module.connect();

      // Let the first factory call complete.
      final client = _FakeSignalingClient();
      controlled.complete(client);
      await pumpEventQueue();

      // Only one SignalingConnecting and one SignalingConnected - not doubled.
      expect(events.whereType<SignalingConnecting>(), hasLength(1));
      expect(events.whereType<SignalingConnected>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // Intentional disconnect - recommendedReconnectDelay == null
  // -------------------------------------------------------------------------

  group('SignalingModule - intentional disconnect()', () {
    test('SignalingDisconnected has null recommendedReconnectDelay after disconnect()', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();

      // Intentional disconnect.
      unawaited(module.disconnect());
      await pumpEventQueue();
      // Simulate WS close-ack arriving.
      client.injectDisconnect(1000, 'going away');
      await pumpEventQueue();

      final disconnected = events.whereType<SignalingDisconnected>().single;
      expect(disconnected.recommendedReconnectDelay, isNull);
    });

    test('disconnect() passes normalClosure code to the underlying client', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      unawaited(module.disconnect());
      await pumpEventQueue();

      expect(client.disconnected, isTrue);
      expect(client.lastDisconnectCode, equals(SignalingDisconnectCode.normalClosure.code));
    });
  });

  // -------------------------------------------------------------------------
  // _errorHandled - _onDisconnect suppressed after _onError
  // -------------------------------------------------------------------------

  group('SignalingModule - error suppresses disconnect event', () {
    test('_onDisconnect after _onError does NOT emit SignalingDisconnected', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();

      // Simulate socket error followed by the automatic close.
      client.injectError(Exception('socket error'));
      await pumpEventQueue();
      client.injectDisconnect(null, null);
      await pumpEventQueue();

      // Only SignalingConnectionFailed - no SignalingDisconnected.
      expect(events.whereType<SignalingConnectionFailed>(), hasLength(1));
      expect(events.whereType<SignalingDisconnected>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // Protocol events excluded from replay buffer
  // -------------------------------------------------------------------------

  group('SignalingModule - replay buffer excludes protocol events', () {
    test('SignalingProtocolEvent is not replayed to late subscribers', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();
      // Emit a protocol event - must NOT be buffered.
      client.injectEvent(HangupEvent(callId: 'call-1', line: 0, reason: 'bye', code: 0));
      await pumpEventQueue();

      // Late subscriber.
      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await pumpEventQueue();

      expect(
        late.whereType<SignalingProtocolEvent>(),
        isEmpty,
        reason: 'Protocol events must not be replayed to late subscribers',
      );
      // But lifecycle events are still there.
      expect(late.whereType<SignalingConnecting>(), hasLength(1));
      expect(late.whereType<SignalingConnected>(), hasLength(1));
      expect(late.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // liveController closed on subscription cancel
  // -------------------------------------------------------------------------

  group('SignalingModule - subscription cancel', () {
    test('cancelled subscription receives no further events', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      final events = <SignalingModuleEvent>[];
      final sub = module.events.listen(events.add);
      await pumpEventQueue();
      final countBeforeCancel = events.length;

      await sub.cancel();
      await pumpEventQueue();

      // Inject a server event after cancel - must not reach the cancelled subscriber.
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();

      expect(events.length, equals(countBeforeCancel));
    });
  });

  // -------------------------------------------------------------------------
  // dispose() awaits disconnect ack before closing the stream
  // -------------------------------------------------------------------------

  group('SignalingModule - dispose() waits for disconnect ack', () {
    test('stream close arrives after SignalingDisconnected (dispose waits for ack)', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      final events = <SignalingModuleEvent>[];
      bool streamDone = false;
      module.events.listen(events.add, onDone: () => streamDone = true);

      module.connect();
      await pumpEventQueue();

      // Start dispose - it calls disconnect() internally.
      final disposeFuture = module.dispose();

      // Flush - SignalingDisconnecting is emitted, but stream not yet closed.
      await pumpEventQueue();
      expect(streamDone, isFalse);

      // WS close-ack arrives - unblocks dispose().
      client.injectDisconnect(1000, 'going away');
      await pumpEventQueue();
      await disposeFuture;

      // SignalingDisconnected was emitted before stream closed.
      expect(
        events.whereType<SignalingDisconnected>(),
        isEmpty,
        reason: 'intentional disconnect from dispose suppresses reconnect hint',
      );
      expect(streamDone, isTrue);
    });
  });

  // -------------------------------------------------------------------------
  // _onHandshake / _onEvent are no-ops after dispose()
  // -------------------------------------------------------------------------

  group('SignalingModule - callbacks no-op after dispose()', () {
    test('_onHandshake and _onEvent emit nothing after dispose()', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();

      // dispose closes the module.
      unawaited(module.dispose());
      client.injectDisconnect(null, null);
      await pumpEventQueue();

      final countAfterDispose = events.length;

      // These should be silently dropped.
      client.injectHandshake(_kHandshake);
      client.injectEvent(HangupEvent(callId: 'call-1', line: 0, reason: 'bye', code: 0));
      await pumpEventQueue();

      expect(events.length, equals(countAfterDispose), reason: 'No events must be emitted after dispose()');
    });
  });

  // -------------------------------------------------------------------------
  // Internet dropped mid-session
  // Mirrors what CallBloc sees: connection was healthy, then socket dies.
  // -------------------------------------------------------------------------

  group('SignalingModule - internet dropped mid-session', () {
    test('_onError after handshake emits ConnectionFailed, not Disconnected, and clears signalingClient', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();

      // Simulate internet drop - socket emits an IOException-style error.
      client.injectError(Exception('Connection reset by peer'));
      await pumpEventQueue();
      // Automatic socket close follows the error - must be suppressed.
      client.injectDisconnect(null, null);
      await pumpEventQueue();

      expect(events.whereType<SignalingConnectionFailed>(), hasLength(1));
      expect(
        events.whereType<SignalingDisconnected>(),
        isEmpty,
        reason: 'Disconnect after _onError must be suppressed to avoid double reconnect trigger',
      );
      expect(module.signalingClient, isNull);
    });

    test('unexpected socket close (null code) after handshake emits Disconnected with reconnect delay', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();

      // Network disappeared - socket closes without a clean WebSocket close code.
      client.injectDisconnect(null, null);
      await pumpEventQueue();

      final disconnected = events.whereType<SignalingDisconnected>().single;
      expect(disconnected.code, isNull);
      expect(
        disconnected.recommendedReconnectDelay,
        equals(kSignalingClientReconnectDelay),
        reason: 'Unknown/null code should result in a slow reconnect, not a nil delay',
      );
      expect(module.signalingClient, isNull);
    });

    test('ConnectionFailed is buffered so late subscribers reconstruct last-known failure', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();
      // Internet drops.
      client.injectError(Exception('network gone'));
      await pumpEventQueue();

      // Late subscriber - joins after the error.
      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await pumpEventQueue();

      expect(late.whereType<SignalingConnecting>(), hasLength(1));
      expect(late.whereType<SignalingConnected>(), hasLength(1));
      expect(late.whereType<SignalingHandshakeReceived>(), hasLength(1));
      expect(late.whereType<SignalingConnectionFailed>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // Handshake not completed
  // Mirrors the scenario where a connection is established but the server
  // closes the socket before the StateHandshake arrives (e.g. TLS handshake
  // succeeds but server rejects the upgrade, or network drops immediately).
  // CallBloc keeps linesCount == 0 and registration == null in this case.
  // -------------------------------------------------------------------------

  group('SignalingModule - handshake not completed', () {
    test('disconnect before handshake emits Disconnected with reconnect delay but no HandshakeReceived', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();
      // Server closes before sending StateHandshake (e.g. reboot, load-balancer eviction).
      client.injectDisconnect(1001, 'Server going away');
      await pumpEventQueue();

      expect(events.whereType<SignalingConnecting>(), hasLength(1));
      expect(events.whereType<SignalingConnected>(), hasLength(1));
      expect(events.whereType<SignalingHandshakeReceived>(), isEmpty);
      final disconnected = events.whereType<SignalingDisconnected>().single;
      expect(
        disconnected.recommendedReconnectDelay,
        isNotNull,
        reason: 'Code 1001 (goingAway) should trigger a slow reconnect',
      );
    });

    test('late subscriber after handshake-less disconnect sees Connecting+Connected+Disconnected only', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();
      client.injectDisconnect(1001, 'Server going away');
      await pumpEventQueue();

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await pumpEventQueue();

      expect(
        late.whereType<SignalingHandshakeReceived>(),
        isEmpty,
        reason: 'Handshake never arrived so must not be replayed',
      );
      expect(late.whereType<SignalingConnecting>(), hasLength(1));
      expect(late.whereType<SignalingConnected>(), hasLength(1));
      expect(late.whereType<SignalingDisconnected>(), hasLength(1));
    });

    test('error before handshake: ConnectionFailed buffered, no HandshakeReceived', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();
      // Socket error arrives before any handshake.
      client.injectError(Exception('auth rejected'));
      await pumpEventQueue();

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await pumpEventQueue();

      expect(late.whereType<SignalingHandshakeReceived>(), isEmpty);
      expect(late.whereType<SignalingConnectionFailed>(), hasLength(1));
    });

    test('reconnect after no-handshake failure delivers fresh Connecting+Connected+Handshake', () async {
      int call = 0;
      final client1 = _FakeSignalingClient();
      final client2 = _FakeSignalingClient();
      final module = _buildModule(({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) async {
        call++;
        return call == 1 ? client1 : client2;
      });
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // First session - no handshake, drops immediately.
      module.connect();
      await pumpEventQueue();
      client1.injectDisconnect(1001, 'going away');
      await pumpEventQueue();

      // Reconnect - this time handshake arrives.
      module.connect();
      await pumpEventQueue();
      client2.injectHandshake(_kHandshake);
      await pumpEventQueue();

      // The second session must have a HandshakeReceived.
      expect(events.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // Late subscriber mid-session
  // CallBloc subscribes in its constructor; the module may already be in any
  // state by then (connecting, connected, or handshaken).
  // -------------------------------------------------------------------------

  group('SignalingModule - late subscriber mid-session', () {
    test('subscriber joining while factory still pending gets Connecting from buffer then Connected live', () async {
      final controlled = _ControlledFactory();
      final module = _buildModule(controlled.factory);
      addTearDown(module.dispose);

      // Start connecting - Connecting buffered, factory not yet resolved.
      module.connect();
      await pumpEventQueue();

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await pumpEventQueue(); // flush buffer replay

      expect(
        late.whereType<SignalingConnecting>(),
        hasLength(1),
        reason: 'Connecting must be replayed from buffer before factory resolves',
      );
      expect(late.whereType<SignalingConnected>(), isEmpty);

      // Factory resolves - Connected arrives live.
      controlled.complete(_FakeSignalingClient());
      await pumpEventQueue();

      expect(late.whereType<SignalingConnected>(), hasLength(1));
    });

    test('subscriber joining after full connect+handshake gets all three lifecycle events', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();
      client.injectHandshake(_kHandshake);
      await pumpEventQueue();

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await pumpEventQueue();

      expect(late.whereType<SignalingConnecting>(), hasLength(1));
      expect(late.whereType<SignalingConnected>(), hasLength(1));
      expect(late.whereType<SignalingHandshakeReceived>(), hasLength(1));
      // Protocol events are NOT replayed.
      expect(late.whereType<SignalingProtocolEvent>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // requestCallIdError (4610) — reconnect hint
  //
  // Code 4610 is sent by the server when a client submits a request (e.g.
  // hangup) on a SIP dialog that is already closed server-side.  This happens
  // after a blind transfer because the server closes the dialog via REFER while
  // the client concurrently tries to send a hangup request.
  //
  // The key asymmetry:
  //   - Non-intentional 4610 -> recommendedReconnectDelay != null -> CallBloc schedules reconnect.
  //   - Intentional disconnect() followed by server 4610 -> recommendedReconnectDelay == null
  //     -> CallBloc does NOT schedule a reconnect automatically.
  //
  // The second case was the root cause of WT-1214 (cannot make calls after
  // blind transfer): post-transfer cleanup called disconnect() (intentional),
  // then the server echoed back with 4610, suppressing the reconnect hint and
  // leaving signaling permanently disconnected until the next outgoing call
  // triggered the safety-net _scheduleReconnect(Duration.zero) added in the fix.
  // -------------------------------------------------------------------------

  group('SignalingModule - requestCallIdError (4610) reconnect hint', () {
    test('non-intentional 4610 emits SignalingDisconnected with non-null recommendedReconnectDelay', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();

      // Server closes the WebSocket with 4610 without the client calling disconnect() first.
      client.injectDisconnect(SignalingDisconnectCode.requestCallIdError.code, 'call request on wrong line');
      await pumpEventQueue();

      final disconnected = events.whereType<SignalingDisconnected>().single;
      expect(disconnected.knownCode, SignalingDisconnectCode.requestCallIdError);
      expect(
        disconnected.recommendedReconnectDelay,
        isNotNull,
        reason: 'Non-intentional 4610 should carry a reconnect hint so CallBloc schedules a reconnect',
      );
    });

    test('intentional disconnect() followed by server 4610 emits null recommendedReconnectDelay', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await pumpEventQueue();

      // Client calls disconnect() explicitly (e.g. post-transfer cleanup in onChange),
      // then the server echoes back with 4610 instead of the expected 1000.
      unawaited(module.disconnect());
      await pumpEventQueue();
      client.injectDisconnect(SignalingDisconnectCode.requestCallIdError.code, 'call request on wrong line');
      await pumpEventQueue();

      final disconnected = events.whereType<SignalingDisconnected>().single;
      expect(
        disconnected.recommendedReconnectDelay,
        isNull,
        reason: 'Intentional disconnect suppresses the reconnect hint even when the server closes with 4610',
      );
    });
  });

  // -------------------------------------------------------------------------
  // disconnect() robustness
  // CallBloc calls disconnect() on lifecycle / connectivity changes; it must
  // not break if the underlying WebSocket close throws.
  // -------------------------------------------------------------------------

  group('SignalingModule - disconnect() robustness', () {
    test('dispose() completes even when client.disconnect() throws', () async {
      final client = _ThrowingDisconnectClient();
      // Use a factory that wraps the throwing client.
      final module = _buildModule(
        ({
          required Uri url,
          required String tenantId,
          required String token,
          required Duration connectionTimeout,
          required TrustedCertificates certs,
          required bool force,
        }) async => client,
      );

      module.connect();
      await pumpEventQueue();

      // dispose() must not hang waiting for a disconnect ack that will never arrive.
      await expectLater(module.dispose().timeout(const Duration(seconds: 2)), completes);
    });

    test('disconnect() is a no-op when called while already disconnected', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await pumpEventQueue();

      // First disconnect.
      unawaited(module.disconnect());
      await pumpEventQueue();
      client.injectDisconnect(1000, 'ok');
      await pumpEventQueue();

      // Second disconnect - no client, must be a silent no-op.
      await module.disconnect();

      expect(client.disconnected, isTrue); // only one real disconnect happened
    });
  });
}
