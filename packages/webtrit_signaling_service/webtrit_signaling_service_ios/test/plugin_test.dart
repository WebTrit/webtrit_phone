import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_ios/src/plugin.dart';
import 'package:webtrit_signaling_service_ios/src/signaling_client_factory.dart';

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

class _FakeSignalingClient extends Fake implements WebtritSignalingClient {
  StateHandshakeHandler? _onStateHandshake;
  ErrorHandler? _onError;
  DisconnectHandler? _onDisconnect;

  bool disconnected = false;

  @override
  void listen({
    required StateHandshakeHandler onStateHandshake,
    required EventHandler onEvent,
    required ErrorHandler onError,
    required DisconnectHandler onDisconnect,
  }) {
    _onStateHandshake = onStateHandshake;
    _onError = onError;
    _onDisconnect = onDisconnect;
  }

  @override
  Future<void> disconnect([int? code, String? reason]) async {
    disconnected = true;
  }

  @override
  Future<void> execute(Request request, [Duration? timeout]) async {}

  void injectHandshake(StateHandshake handshake) => _onStateHandshake?.call(handshake);
  void injectDisconnect(int? code, String? reason) => _onDisconnect?.call(code, reason);
  void injectError(Object error) => _onError?.call(error, null);
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

// ---------------------------------------------------------------------------
// Config fixture
// ---------------------------------------------------------------------------

const _kConfig = SignalingServiceConfig(coreUrl: 'wss://example.com', tenantId: 'tenant', token: 'tok');

// Dummy top-level callbacks used to test setIncomingCallHandler.
// On iOS the method is a no-op, so the actual implementation does not matter.
Future<void> _dummyIncomingCallHandler(IncomingCallEvent event) async {}
Future<void> _anotherDummyHandler(IncomingCallEvent event) async {}

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
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // events stream
  // -------------------------------------------------------------------------

  group('WebtritSignalingServiceIos -- events', () {
    test('events stream is accessible before start()', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      expect(plugin.events, isA<Stream<SignalingModuleEvent>>());
    });

    test('events stream is a broadcast stream', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      expect(plugin.events.isBroadcast, isTrue);
    });

    test('events are forwarded from SignalingModule after start()', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      final events = <SignalingModuleEvent>[];
      plugin.events.listen(events.add);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingConnecting>(), hasLength(1));
      expect(events.whereType<SignalingConnected>(), hasLength(1));
    });

    test('server handshake is forwarded to events stream', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      final events = <SignalingModuleEvent>[];
      plugin.events.listen(events.add);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      client.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });

    test('connection error is forwarded to events stream', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('refused')));
      addTearDown(plugin.dispose);

      final events = <SignalingModuleEvent>[];
      plugin.events.listen(events.add);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingConnectionFailed>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // start()
  // -------------------------------------------------------------------------

  group('WebtritSignalingServiceIos -- start()', () {
    test('accepts persistent mode without error', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await expectLater(plugin.start(_kConfig, mode: SignalingServiceMode.persistent), completes);
    });

    test('accepts pushBound mode without error', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await expectLater(plugin.start(_kConfig, mode: SignalingServiceMode.pushBound), completes);
    });

    test('calling start() twice replaces the module and disposes the previous one', () async {
      final client1 = _FakeSignalingClient();
      final client2 = _FakeSignalingClient();
      var callCount = 0;

      final plugin = WebtritSignalingServiceIos.forTesting(({
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
      addTearDown(plugin.dispose);

      final events = <SignalingModuleEvent>[];
      plugin.events.listen(events.add);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      // First client disconnected when module was torn down
      expect(client1.disconnected, isTrue);
      // New session events appeared
      expect(events.whereType<SignalingConnected>(), hasLength(2));
    });
  });

  // -------------------------------------------------------------------------
  // attach()
  // -------------------------------------------------------------------------

  group('WebtritSignalingServiceIos -- attach()', () {
    test('completes without error before start()', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      await expectLater(plugin.attach(), completes);
    });

    test('completes without error after start()', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      await expectLater(plugin.attach(), completes);
    });

    test('does not emit any events', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      final events = <SignalingModuleEvent>[];
      plugin.events.listen(events.add);

      await plugin.attach();
      await Future<void>.delayed(Duration.zero);

      expect(events, isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // execute()
  // -------------------------------------------------------------------------

  group('WebtritSignalingServiceIos -- execute()', () {
    test('throws StateError when called before start()', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      await expectLater(
        plugin.execute(HangupRequest(transaction: 'tx-1', line: 1, callId: 'c1')),
        throwsA(isA<StateError>()),
      );
    });

    test('throws StateError when connection failed (not connected)', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('refused')));
      addTearDown(plugin.dispose);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      await expectLater(
        plugin.execute(HangupRequest(transaction: 'tx-2', line: 1, callId: 'c2')),
        throwsA(isA<StateError>()),
      );
    });

    test('completes normally when connected', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      await expectLater(plugin.execute(HangupRequest(transaction: 'tx-3', line: 1, callId: 'c3')), completes);
    });

    test('throws StateError after disconnect', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      client.injectDisconnect(1000, 'normal');
      await Future<void>.delayed(Duration.zero);

      await expectLater(
        plugin.execute(HangupRequest(transaction: 'tx-4', line: 1, callId: 'c4')),
        throwsA(isA<StateError>()),
      );
    });
  });

  // -------------------------------------------------------------------------
  // dispose()
  // -------------------------------------------------------------------------

  group('WebtritSignalingServiceIos -- dispose()', () {
    test('closes the events stream', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));

      final done = Completer<void>();
      plugin.events.listen(null, onDone: done.complete);

      await plugin.dispose();
      await done.future.timeout(const Duration(seconds: 1));
    });

    test('disposes the active module', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      await plugin.dispose();

      expect(client.disconnected, isTrue);
    });

    test('dispose before start() completes without error', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      await expectLater(plugin.dispose(), completes);
    });

    test('second dispose() is a no-op', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      await plugin.dispose();
      await expectLater(plugin.dispose(), completes);
    });
  });

  // -------------------------------------------------------------------------
  // updateMode() -- no-op on iOS
  // -------------------------------------------------------------------------

  group('WebtritSignalingServiceIos -- updateMode()', () {
    test('completes without error for persistent', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      await expectLater(plugin.updateMode(SignalingServiceMode.persistent), completes);
    });

    test('completes without error for pushBound', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      await expectLater(plugin.updateMode(SignalingServiceMode.pushBound), completes);
    });

    test('does not emit any events', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      final eventsAfterStart = <SignalingModuleEvent>[];
      plugin.events.listen(eventsAfterStart.add);
      await Future<void>.delayed(Duration.zero); // let session buffer replay arrive
      eventsAfterStart.clear();

      await plugin.updateMode(SignalingServiceMode.pushBound);
      await Future<void>.delayed(Duration.zero);

      expect(eventsAfterStart, isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // setIncomingCallHandler() -- no-op on iOS
  // -------------------------------------------------------------------------

  group('WebtritSignalingServiceIos -- setIncomingCallHandler()', () {
    test('completes without error for a callback function', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      await expectLater(plugin.setIncomingCallHandler(_dummyIncomingCallHandler), completes);
    });

    test('completes without error for a different callback function', () async {
      final plugin = WebtritSignalingServiceIos.forTesting(_failingFactory(Exception('x')));
      addTearDown(plugin.dispose);

      await expectLater(plugin.setIncomingCallHandler(_anotherDummyHandler), completes);
    });

    test('does not affect the events stream', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      final events = <SignalingModuleEvent>[];
      plugin.events.listen(events.add);
      await Future<void>.delayed(Duration.zero); // let session buffer replay arrive
      events.clear();

      await plugin.setIncomingCallHandler(_dummyIncomingCallHandler);
      await Future<void>.delayed(Duration.zero);

      expect(events, isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // Late subscriber replay via plugin events stream
  // -------------------------------------------------------------------------

  group('WebtritSignalingServiceIos -- events late subscriber', () {
    test('late subscriber receives buffered session events via Stream.multi replay', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      // plugin.events uses Stream.multi which replays _sessionBuffer to every
      // new subscriber, matching the Android plugin behaviour.
      final late = <SignalingModuleEvent>[];
      plugin.events.listen(late.add);
      await Future<void>.delayed(Duration.zero);

      expect(late.whereType<SignalingConnecting>(), hasLength(1));
      expect(late.whereType<SignalingConnected>(), hasLength(1));
    });

    test('late subscriber receives new live events after subscribing', () async {
      final client = _FakeSignalingClient();
      final plugin = WebtritSignalingServiceIos.forTesting(_successFactory(client));
      addTearDown(plugin.dispose);

      await plugin.start(_kConfig);
      await Future<void>.delayed(Duration.zero);

      final late = <SignalingModuleEvent>[];
      plugin.events.listen(late.add);

      client.injectHandshake(_kHandshake);
      await Future<void>.delayed(Duration.zero);

      expect(late.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });
  });
}
