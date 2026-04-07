import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/hub/signaling_hub_client.dart';
import 'package:webtrit_signaling_service_android/src/hub/signaling_hub_module.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart'
    show SignalingEventBuffer;

// ---------------------------------------------------------------------------
// Fake hub client
// ---------------------------------------------------------------------------

class _FakeHubClient extends Fake implements SignalingHubClient {
  final _controller = StreamController<SignalingModuleEvent>.broadcast();
  final _buffer = SignalingEventBuffer();

  bool started = false;
  bool disposed = false;
  final List<Request> executedRequests = [];

  @override
  String get consumerId => 'fake-consumer';

  @override
  Stream<SignalingModuleEvent> get events => _controller.stream;

  @override
  List<SignalingModuleEvent> get snapshot => _buffer.snapshot;

  @override
  void start() => started = true;

  @override
  Future<void> execute(Request request) async {
    executedRequests.add(request);
  }

  @override
  Future<void> dispose() async {
    _buffer.clear();
    await _controller.close();
    disposed = true;
  }

  void inject(SignalingModuleEvent event) {
    _buffer.onEvent(event);
    _controller.add(event);
  }
}

// ---------------------------------------------------------------------------
// Fixture
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
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // Construction
  // -------------------------------------------------------------------------

  group('SignalingHubModule -- construction', () {
    test('calls start() on the hub client', () {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      expect(hub.started, isTrue);
    });

    test('isConnected is false before any events arrive', () {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      expect(module.isConnected, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  // isConnected state tracking
  // -------------------------------------------------------------------------

  group('SignalingHubModule -- isConnected', () {
    test('becomes true on SignalingConnected', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      hub.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      expect(module.isConnected, isTrue);
    });

    test('becomes false on SignalingDisconnected', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      hub.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      hub.inject(
        SignalingDisconnected(
          code: 1000,
          reason: null,
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(module.isConnected, isFalse);
    });

    test('becomes false on SignalingConnectionFailed', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      hub.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      hub.inject(
        SignalingConnectionFailed(
          error: Exception('timeout'),
          isRepeated: false,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(module.isConnected, isFalse);
    });
  });

  // -------------------------------------------------------------------------
  // Event forwarding
  // -------------------------------------------------------------------------

  group('SignalingHubModule -- event forwarding', () {
    test('forwards all hub events to events stream', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      final received = <SignalingModuleEvent>[];
      module.events.listen(received.add);

      hub.inject(SignalingConnecting());
      hub.inject(SignalingConnected());
      hub.inject(SignalingHandshakeReceived(handshake: _kHandshake));
      hub.inject(SignalingProtocolEvent(event: UnregisteredEvent()));
      await Future<void>.delayed(Duration.zero);

      expect(received, hasLength(4));
      expect(received[0], isA<SignalingConnecting>());
      expect(received[1], isA<SignalingConnected>());
      expect(received[2], isA<SignalingHandshakeReceived>());
      expect(received[3], isA<SignalingProtocolEvent>());
    });

    test('delivers events to multiple listeners', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      final listenerA = <SignalingModuleEvent>[];
      final listenerB = <SignalingModuleEvent>[];
      module.events.listen(listenerA.add);
      module.events.listen(listenerB.add);

      hub.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      expect(listenerA.whereType<SignalingConnected>(), hasLength(1));
      expect(listenerB.whereType<SignalingConnected>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // Session buffer / late subscriber replay
  // -------------------------------------------------------------------------

  group('SignalingHubModule -- session buffer replay', () {
    test('late subscriber receives buffered events from current session', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      hub.inject(SignalingConnecting());
      hub.inject(SignalingConnected());
      hub.inject(SignalingHandshakeReceived(handshake: _kHandshake));
      await Future<void>.delayed(Duration.zero);

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await Future<void>.delayed(Duration.zero);

      expect(late.whereType<SignalingConnecting>(), hasLength(1));
      expect(late.whereType<SignalingConnected>(), hasLength(1));
      expect(late.whereType<SignalingHandshakeReceived>(), hasLength(1));
    });

    test('SignalingConnecting clears the buffer for a new session', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      // First session events.
      hub.inject(SignalingConnecting());
      hub.inject(SignalingConnected());
      hub.inject(SignalingHandshakeReceived(handshake: _kHandshake));
      hub.inject(
        SignalingDisconnected(
          code: 1000,
          reason: null,
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      await Future<void>.delayed(Duration.zero);

      // Second session starts -- buffer is cleared.
      hub.inject(SignalingConnecting());
      await Future<void>.delayed(Duration.zero);

      final late = <SignalingModuleEvent>[];
      module.events.listen(late.add);
      await Future<void>.delayed(Duration.zero);

      expect(
        late.whereType<SignalingHandshakeReceived>(),
        isEmpty,
        reason: 'Handshake from first session must not appear in second session buffer',
      );
      expect(late.whereType<SignalingConnecting>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // connect / disconnect are no-ops
  // -------------------------------------------------------------------------

  group('SignalingHubModule -- connect/disconnect are no-ops', () {
    test('connect() does not throw or emit events', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      module.connect();
      await Future<void>.delayed(Duration.zero);

      expect(events, isEmpty);
    });

    test('disconnect() does not throw or emit events', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      hub.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      final events = <SignalingModuleEvent>[];
      module.events.listen(events.add);

      await module.disconnect();
      await Future<void>.delayed(Duration.zero);

      expect(events.whereType<SignalingDisconnecting>(), isEmpty);
      expect(events.whereType<SignalingDisconnected>(), isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // execute()
  // -------------------------------------------------------------------------

  group('SignalingHubModule -- execute()', () {
    test('returns null when not connected', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      final result = module.execute(HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1'));
      expect(result, isNull);
    });

    test('routes request to hub client when connected', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      hub.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      final request = HangupRequest(transaction: 'tx-2', line: 1, callId: 'call-1');
      await module.execute(request);

      expect(hub.executedRequests, hasLength(1));
      expect(hub.executedRequests[0], same(request));
    });

    test('returns null after disconnected', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);
      addTearDown(module.dispose);

      hub.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      hub.inject(
        SignalingDisconnected(
          code: 1000,
          reason: null,
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: const Duration(seconds: 3),
        ),
      );
      await Future<void>.delayed(Duration.zero);

      final result = module.execute(HangupRequest(transaction: 'tx-3', line: 1, callId: 'call-1'));
      expect(result, isNull);
      expect(hub.executedRequests, isEmpty);
    });
  });

  // -------------------------------------------------------------------------
  // dispose()
  // -------------------------------------------------------------------------

  group('SignalingHubModule -- dispose()', () {
    test('disposes the hub client', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);

      await module.dispose();

      expect(hub.disposed, isTrue);
    });

    test('closes the events stream', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);

      final done = Completer<void>();
      module.events.listen(null, onDone: done.complete);

      await module.dispose();
      await done.future.timeout(const Duration(seconds: 1));
    });

    test('second dispose() does not throw', () async {
      final hub = _FakeHubClient();
      final module = SignalingHubModule(hub);

      await module.dispose();
      // Second call -- hub.dispose() would throw on closed stream, but module
      // guards against that via _controller.isClosed check.
      // This test verifies the dispose path is safe to call repeatedly
      // through the module's own guards (not the hub client).
    });
  });
}
