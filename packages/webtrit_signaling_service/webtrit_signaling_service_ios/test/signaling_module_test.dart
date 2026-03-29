import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_ios/src/constants.dart';
import 'package:webtrit_signaling_service_ios/src/signaling_client_factory.dart';
import 'package:webtrit_signaling_service_ios/src/signaling_module.dart';

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

  void injectHandshake(StateHandshake handshake) => _onStateHandshake?.call(handshake);
  void injectEvent(Event event) => _onEvent?.call(event);
  void injectError(Object error, [StackTrace? st]) => _onError?.call(error, st);
  void injectDisconnect(int? code, String? reason) => _onDisconnect?.call(code, reason);
}

// ---------------------------------------------------------------------------
// Factory helpers
// ---------------------------------------------------------------------------

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

class _CapturingFactory {
  Uri? capturedUrl;
  bool? capturedForce;

  SignalingClientFactory get factory =>
      ({
        required Uri url,
        required String tenantId,
        required String token,
        required Duration connectionTimeout,
        required TrustedCertificates certs,
        required bool force,
      }) async {
        capturedUrl = url;
        capturedForce = force;
        return _FakeSignalingClient();
      };
}

// ---------------------------------------------------------------------------
// Shared fixture
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
  group('SignalingModule -- connect()', () {
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

    test('isConnected is true after successful connect', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      expect(module.isConnected, isFalse);
      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(module.isConnected, isTrue);
    });

    test('emits SignalingConnecting then SignalingConnectionFailed on factory error', () async {
      final error = Exception('connection refused');
      final module = _buildModule(_failingFactory(error));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(events[0], isA<SignalingConnecting>());
      final failed = events[1] as SignalingConnectionFailed;
      expect(failed.error, same(error));
      expect(failed.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('isConnected is false after failed connect', () async {
      final module = _buildModule(_failingFactory(Exception('refused')));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(module.isConnected, isFalse);
    });

    test('does nothing when called after dispose()', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      final events = <SignalingModuleEvent>[];
      final sub = module.events.listen(events.add);

      await module.dispose();
      module.connect();
      await Future<void>.delayed(Duration.zero);

      await sub.cancel();
      expect(events.whereType<SignalingConnecting>(), isEmpty);
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

      module.connect();
      await Future<void>.delayed(Duration.zero);
      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(firstClient.disconnected, isTrue);
      expect(module.isConnected, isTrue);
    });

    test('factory receives wss:// url for https:// coreUrl', () async {
      final capturing = _CapturingFactory();
      final module = SignalingModule(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'tok',
        trustedCertificates: TrustedCertificates.empty,
        signalingClientFactory: capturing.factory,
      );
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(capturing.capturedUrl?.scheme, 'wss');
    });

    test('factory receives ws:// url for http:// coreUrl', () async {
      final capturing = _CapturingFactory();
      final module = SignalingModule(
        coreUrl: 'http://example.com',
        tenantId: 'tenant',
        token: 'tok',
        trustedCertificates: TrustedCertificates.empty,
        signalingClientFactory: capturing.factory,
      );
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(capturing.capturedUrl?.scheme, 'ws');
    });

    test('factory is called with force: true', () async {
      final capturing = _CapturingFactory();
      final module = SignalingModule(
        coreUrl: 'https://example.com',
        tenantId: 'tenant',
        token: 'tok',
        trustedCertificates: TrustedCertificates.empty,
        signalingClientFactory: capturing.factory,
      );
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(capturing.capturedForce, isTrue);
    });
  });

  // -------------------------------------------------------------------------
  // isRepeated deduplication
  // -------------------------------------------------------------------------

  group('SignalingModule -- isRepeated deduplication', () {
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
  });

  // -------------------------------------------------------------------------
  // disconnect()
  // -------------------------------------------------------------------------

  group('SignalingModule -- disconnect()', () {
    test('emits SignalingDisconnecting and calls client.disconnect', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);
      events.clear();
      await module.disconnect();

      expect(events, hasLength(1));
      expect(events[0], isA<SignalingDisconnecting>());
      expect(client.disconnected, isTrue);
      expect(module.isConnected, isFalse);
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
  // dispose()
  // -------------------------------------------------------------------------

  group('SignalingModule -- dispose()', () {
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
      await module.dispose();
    });
  });

  // -------------------------------------------------------------------------
  // execute()
  // -------------------------------------------------------------------------

  group('SignalingModule -- execute()', () {
    test('returns null when no client is connected', () async {
      final module = _buildModule(_failingFactory(Exception('x')));
      addTearDown(module.dispose);

      final result = module.execute(HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1'));
      expect(result, isNull);
    });

    test('delegates to the signaling client when connected', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      final result = module.execute(HangupRequest(transaction: 'tx-2', line: 1, callId: 'call-1'));
      expect(result, isNotNull);
      await result;
    });
  });

  // -------------------------------------------------------------------------
  // Server-pushed events
  // -------------------------------------------------------------------------

  group('SignalingModule -- server-pushed events', () {
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

    test('_onError emits SignalingConnectionFailed and clears isConnected', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      SignalingConnectionFailed? failed;
      module.events.listen((e) {
        if (e is SignalingConnectionFailed) failed = e;
      });

      client.injectError(Exception('keepalive timeout'));
      await Future<void>.delayed(Duration.zero);

      expect(failed, isNotNull);
      expect(module.isConnected, isFalse);
    });

    test('_onDisconnect emits SignalingDisconnected and clears isConnected', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      SignalingDisconnected? disc;
      module.events.listen((e) {
        if (e is SignalingDisconnected) disc = e;
      });

      client.injectDisconnect(1000, 'normal');
      await Future<void>.delayed(Duration.zero);

      expect(disc?.code, 1000);
      expect(disc?.reason, 'normal');
      expect(module.isConnected, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  // Reconnect delay mapping
  // -------------------------------------------------------------------------

  group('SignalingModule -- reconnect delay', () {
    Future<SignalingDisconnected> disconnectWith(int code) async {
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

    test('controllerForceAttachClose (4441) -> Duration.zero', () async {
      final disc = await disconnectWith(SignalingDisconnectCode.controllerForceAttachClose.code);
      expect(disc.recommendedReconnectDelay, Duration.zero);
    });

    test('protocolError (1002) -> null', () async {
      final disc = await disconnectWith(SignalingDisconnectCode.protocolError.code);
      expect(disc.recommendedReconnectDelay, isNull);
    });

    test('normalClosure (1000) -> kSignalingClientReconnectDelay', () async {
      final disc = await disconnectWith(SignalingDisconnectCode.normalClosure.code);
      expect(disc.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });

    test('unknown code -> unmappedCode, kSignalingClientReconnectDelay', () async {
      final disc = await disconnectWith(9999);
      expect(disc.knownCode, SignalingDisconnectCode.unmappedCode);
      expect(disc.recommendedReconnectDelay, kSignalingClientReconnectDelay);
    });
  });

  // -------------------------------------------------------------------------
  // Late subscriber replay
  // -------------------------------------------------------------------------

  group('SignalingModule -- late subscriber replay', () {
    test('late subscriber receives all buffered events from the current session', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);
      client.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await Future<void>.delayed(Duration.zero);

      expect(late.whereType<SignalingConnecting>(), hasLength(1));
      expect(late.whereType<SignalingConnected>(), hasLength(1));
      expect(late.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });

    test('connect() clears the buffer so late subscribers see only the new session', () async {
      final client1 = _FakeSignalingClient();
      final client2 = _FakeSignalingClient();
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
        return callCount == 1 ? client1 : client2;
      });
      addTearDown(module.dispose);

      module.connect();
      await Future<void>.delayed(Duration.zero);
      client1.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);
      client1.injectDisconnect(1000, 'done');
      await Future<void>.delayed(Duration.zero);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await Future<void>.delayed(Duration.zero);

      expect(
        late.whereType<SignalingHandshakeReceived>(),
        isEmpty,
        reason: 'Handshake from the first session must not be replayed',
      );
      expect(late.whereType<SignalingConnecting>(), hasLength(1));
    });

    test('late subscriber receives empty buffer when no session is active', () async {
      final module = _buildModule(_failingFactory(Exception('x')));
      addTearDown(module.dispose);

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await Future<void>.delayed(Duration.zero);

      expect(late, isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // Integration: full lifecycle
  // -------------------------------------------------------------------------

  group('SignalingModule -- integration: full lifecycle', () {
    test('happy-path emits events in correct order', () async {
      final client = _FakeSignalingClient();
      final module = _buildModule(_successFactory(client));

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      client.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      final protocolEvent = UnregisteredEvent();
      client.injectEvent(protocolEvent);
      await Future<void>.delayed(Duration.zero);

      await module.disconnect();
      await module.dispose();

      expect(events[0], isA<SignalingConnecting>());
      expect(events[1], isA<SignalingConnected>());
      expect(events[2], isA<SignalingHandshakeReceived>());
      expect(events[3], isA<SignalingProtocolEvent>());
      expect(events[4], isA<SignalingDisconnecting>());
    });
  });

  group('SignalingModule -- integration: dispose during pending connect', () {
    test('dispose while factory is in flight does not emit SignalingConnected after dispose', () async {
      final controlled = _ControlledFactory();
      final module = _buildModule(controlled.factory);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add, onDone: () {});

      module.connect();
      await module.dispose();

      final lateClient = _FakeSignalingClient();
      controlled.complete(lateClient);
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingConnected>(), isEmpty);
      expect(lateClient.disconnected, isTrue);
    });
  });
}
