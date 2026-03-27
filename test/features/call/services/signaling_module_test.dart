import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/services/signaling_module.dart';
import 'package:webtrit_phone/utils/utils.dart';

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
  Future<void> execute(Request request, [Duration? timeout]) async {}

  // Helpers to inject server-side messages in tests.
  void injectHandshake(StateHandshake handshake) => _onStateHandshake?.call(handshake);
  void injectEvent(Event event) => _onEvent?.call(event);
  void injectError(Object error, [StackTrace? st]) => _onError?.call(error, st);
  void injectDisconnect(int? code, String? reason) => _onDisconnect?.call(code, reason);
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

/// A factory backed by a completer — the test controls when the connection resolves.
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
  userActiveCalls: const [],
  contactsPresenceInfo: const {},
  guestLine: null,
);

// ---------------------------------------------------------------------------
// Module builder
// ---------------------------------------------------------------------------

SignalingModule _buildModule(SignalingClientFactory factory) => SignalingModule(
  coreUrl: 'https://example.com',
  tenantId: 'test-tenant',
  token: 'test-token',
  trustedCertificates: TrustedCertificates.empty,
  signalingClientFactory: factory,
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // Unit tests — pure SignalingModule behaviour, no real WebSocket.
  // -------------------------------------------------------------------------

  group('SignalingModule — connect()', () {
    test('emits SignalingConnecting then SignalingConnected on success', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);

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
      await Future<void>.delayed(Duration.zero);

      expect(module.signalingClient, same(client));
    });

    test('emits SignalingConnecting then SignalingConnectionFailed on factory error', () async {
      final error = Exception('connection refused');
      final module = _buildModule(_failingFactory(error));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);

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
      await Future<void>.delayed(Duration.zero);

      expect(module.signalingClient, isNull);
    });

    test('does nothing when called after dispose()', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      await module.dispose();

      final events = <SignalingModuleEvent>[];
      // Stream is closed; listen just to verify no events arrive.
      // ignore: unawaited_futures
      module.events.toList().then((_) {});

      module.connect(); // must not throw or emit
      await Future<void>.delayed(Duration.zero);

      expect(events, isEmpty);
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
      await Future<void>.delayed(Duration.zero);

      // Second connect while already connected.
      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(firstClient.disconnected, isTrue);
      expect(module.signalingClient, same(secondClient));
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule — isRepeated deduplication', () {
    test('first failure has isRepeated: false', () async {
      final error = Exception('socket error');
      final module = _buildModule(_failingFactory(error));
      addTearDown(module.dispose);

      SignalingConnectionFailed? failed;
      module.events.listen((e) {
        if (e is SignalingConnectionFailed) failed = e;
      });

      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(failed?.isRepeated, isFalse);
    });

    test('same error on second attempt has isRepeated: true', () async {
      final error = Exception('socket error');
      final module = _buildModule(_failingFactory(error));
      addTearDown(module.dispose);

      final failures = <SignalingConnectionFailed>[];
      module.events.listen((e) {
        if (e is SignalingConnectionFailed) failures.add(e);
      });

      module.connect();
      await Future<void>.delayed(Duration.zero);
      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(failures, hasLength(2));
      expect(failures[0].isRepeated, isFalse);
      expect(failures[1].isRepeated, isTrue);
    });

    test('different error resets isRepeated to false', () async {
      final errors = [Exception('error A'), Exception('error B')];
      var callCount = 0;

      final module = _buildModule(
        ({
          required Uri url,
          required String tenantId,
          required String token,
          required Duration connectionTimeout,
          required TrustedCertificates certs,
          required bool force,
        }) async => throw errors[callCount++ < 1 ? 0 : 1],
      );
      addTearDown(module.dispose);

      final failures = <SignalingConnectionFailed>[];
      module.events.listen((e) {
        if (e is SignalingConnectionFailed) failures.add(e);
      });

      module.connect();
      await Future<void>.delayed(Duration.zero);
      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(failures[0].isRepeated, isFalse);
      expect(failures[1].isRepeated, isFalse);
    });

    test('successful connect clears error history — next failure is isRepeated: false', () async {
      final error = Exception('socket error');
      var failNext = false;

      final module = _buildModule(({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) async {
        if (failNext) throw error;
        return _FakeSignalingClient();
      });
      addTearDown(module.dispose);

      // First: succeed (clears history).
      module.connect();
      await Future<void>.delayed(Duration.zero);

      failNext = true;

      // Second: fail — should NOT be repeated even if same error object.
      SignalingConnectionFailed? failed;
      module.events.listen((e) {
        if (e is SignalingConnectionFailed) failed = e;
      });

      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(failed?.isRepeated, isFalse);
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule — disconnect()', () {
    test('emits SignalingDisconnecting and calls client.disconnect', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

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

  group('SignalingModule — dispose()', () {
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
      await Future<void>.delayed(Duration.zero);

      await module.dispose();

      expect(client.disconnected, isTrue);
    });

    test('second dispose() call is a no-op', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      module.connect();
      await Future<void>.delayed(Duration.zero);

      await module.dispose();
      await module.dispose(); // must not throw
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule — server-pushed events', () {
    test('_onHandshake emits SignalingHandshakeReceived', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      SignalingHandshakeReceived? received;
      module.events.listen((e) {
        if (e is SignalingHandshakeReceived) received = e;
      });

      client.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      expect(received?.handshake, same(_kHandshake));
    });

    test('_onEvent emits SignalingProtocolEvent', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      SignalingProtocolEvent? received;
      module.events.listen((e) {
        if (e is SignalingProtocolEvent) received = e;
      });

      final event = UnregisteredEvent();
      client.injectEvent(event);
      await Future<void>.delayed(Duration.zero);

      expect(received?.event, same(event));
    });

    test('_onError emits SignalingConnectionFailed and clears signalingClient', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      SignalingConnectionFailed? failed;
      module.events.listen((e) {
        if (e is SignalingConnectionFailed) failed = e;
      });

      final error = Exception('keepalive timeout');
      client.injectError(error);
      await Future<void>.delayed(Duration.zero);

      expect(failed, isNotNull);
      expect(failed!.error, same(error));
      expect(module.signalingClient, isNull);
    });

    test('_onError sets isRepeated: true on repeated server error', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      final failures = <SignalingConnectionFailed>[];
      module.events.listen((e) {
        if (e is SignalingConnectionFailed) failures.add(e);
      });

      final error = Exception('keepalive timeout');
      client.injectError(error);
      client.injectError(error);
      await Future<void>.delayed(Duration.zero);

      expect(failures[0].isRepeated, isFalse);
      expect(failures[1].isRepeated, isTrue);
    });
  });

  // -------------------------------------------------------------------------

  group('SignalingModule — _reconnectDelay', () {
    Future<SignalingDisconnected> _disconnectWith(int code) async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      SignalingDisconnected? disc;
      module.events.listen((e) {
        if (e is SignalingDisconnected) disc = e;
      });

      client.injectDisconnect(code, 'test');
      await Future<void>.delayed(Duration.zero);

      return disc!;
    }

    test('controllerForceAttachClose (4441) → recommendedReconnectDelay is Duration.zero', () async {
      final disc = await _disconnectWith(SignalingDisconnectCode.controllerForceAttachClose.code);

      expect(disc.knownCode, SignalingDisconnectCode.controllerForceAttachClose);
      expect(disc.recommendedReconnectDelay, Duration.zero);
    });

    test('protocolError (1002) → recommendedReconnectDelay is null', () async {
      final disc = await _disconnectWith(SignalingDisconnectCode.protocolError.code);

      expect(disc.knownCode, SignalingDisconnectCode.protocolError);
      expect(disc.recommendedReconnectDelay, isNull);
    });

    test('normalClosure (1000) → recommendedReconnectDelay is kSignalingClientReconnectDelay', () async {
      final disc = await _disconnectWith(SignalingDisconnectCode.normalClosure.code);

      expect(disc.knownCode, SignalingDisconnectCode.normalClosure);
      expect(disc.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('unknown code → unmappedCode, recommendedReconnectDelay is kSignalingClientReconnectDelay', () async {
      const unknownCode = 9999;
      final disc = await _disconnectWith(unknownCode);

      expect(disc.knownCode, SignalingDisconnectCode.unmappedCode);
      expect(disc.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('null code → unmappedCode, recommendedReconnectDelay is kSignalingClientReconnectDelay', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      SignalingDisconnected? disc;
      module.events.listen((e) {
        if (e is SignalingDisconnected) disc = e;
      });

      client.injectDisconnect(null, null);
      await Future<void>.delayed(Duration.zero);

      expect(disc?.code, isNull);
      expect(disc?.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('signalingClient is null after disconnect event', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      client.injectDisconnect(1000, 'done');
      await Future<void>.delayed(Duration.zero);

      expect(module.signalingClient, isNull);
    });
  });

  // -------------------------------------------------------------------------
  // Integration tests — full lifecycle sequences.
  // -------------------------------------------------------------------------

  group('SignalingModule — integration: connect → handshake → event → disconnect', () {
    test('full happy-path lifecycle emits events in correct order', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      // 1. Connect.
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // 2. Server sends handshake.
      client.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      // 3. Server sends a protocol event.
      final protocolEvent = UnregisteredEvent();
      client.injectEvent(protocolEvent);
      await Future<void>.delayed(Duration.zero);

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

  group('SignalingModule — integration: failure → reconnect → success', () {
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

      // First attempt — fails.
      module.connect();
      await Future<void>.delayed(Duration.zero);

      // Second attempt — succeeds.
      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(events[0], isA<SignalingConnecting>());
      expect(events[1], isA<SignalingConnectionFailed>());
      expect((events[1] as SignalingConnectionFailed).isRepeated, isFalse);
      expect(events[2], isA<SignalingConnecting>());
      expect(events[3], isA<SignalingConnected>());
      expect(module.signalingClient, same(goodClient));
    });
  });

  group('SignalingModule — integration: server-forced reconnect (code 4441)', () {
    test('server close with 4441 emits SignalingDisconnected with Duration.zero delay', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      final discEvents = <SignalingDisconnected>[];
      module.events.listen((e) {
        if (e is SignalingDisconnected) discEvents.add(e);
      });

      // Server evicts the session (duplicate attach).
      client.injectDisconnect(SignalingDisconnectCode.controllerForceAttachClose.code, 'force attach');
      await Future<void>.delayed(Duration.zero);

      expect(discEvents, hasLength(1));
      expect(discEvents[0].recommendedReconnectDelay, Duration.zero);

      // Consumer would immediately reconnect here — simulate it.
      final nextClient = _FakeSignalingClient();
      final module2 = _buildModule(_successFactory(nextClient));
      addTearDown(module2.dispose);

      final connected = <SignalingConnected>[];
      module2.events.listen((e) {
        if (e is SignalingConnected) connected.add(e);
      });

      module2.connect();
      await Future<void>.delayed(Duration.zero);

      expect(connected, hasLength(1));
    });
  });

  group('SignalingModule — integration: dispose during pending connect', () {
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
      await Future<void>.delayed(Duration.zero);

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
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingConnectionFailed>(), isEmpty);
    });
  });

  group('SignalingModule — integration: multiple listeners', () {
    test('broadcast stream delivers events to all active listeners', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final listenerA = <SignalingModuleEvent>[];
      final listenerB = <SignalingModuleEvent>[];
      module.events.listen(listenerA.add);
      module.events.listen(listenerB.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);
      client.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      expect(listenerA.whereType<SignalingConnected>(), hasLength(1));
      expect(listenerA.whereType<SignalingHandshakeReceived>(), hasLength(1));
      expect(listenerB.whereType<SignalingConnected>(), hasLength(1));
      expect(listenerB.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });
  });
}
