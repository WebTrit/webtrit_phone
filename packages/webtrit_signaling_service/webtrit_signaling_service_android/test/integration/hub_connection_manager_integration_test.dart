/// Integration tests for [HubConnectionManager].
///
/// Tests run in a single Dart isolate using real [ReceivePort]/[SendPort] and
/// [IsolateNameServer]. No background isolate or Android service is involved.
///
/// Each test disposes the hub in tearDown so the port name is free for the next
/// test. All tests are sequential to avoid IsolateNameServer conflicts.
library;

import 'dart:async';
import 'dart:ui' show IsolateNameServer;

import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/constants.dart';
import 'package:webtrit_signaling_service_android/src/hub/signaling_hub.dart';
import 'package:webtrit_signaling_service_android/src/hub_connection_manager.dart';

// ---------------------------------------------------------------------------
// Minimal fake SignalingModule
// ---------------------------------------------------------------------------

class _FakeSignalingModule implements SignalingModule {
  final _controller = StreamController<SignalingModuleEvent>.broadcast();
  final List<SignalingModuleEvent> _buffer = [];
  bool _connected = false;
  bool _disposed = false;

  @override
  Stream<SignalingModuleEvent> get events {
    return Stream.multi((sink) {
      final sub = _controller.stream.listen(sink.add, onError: sink.addError, onDone: sink.close);
      sink.onCancel = sub.cancel;
      for (final e in List<SignalingModuleEvent>.of(_buffer)) {
        sink.add(e);
      }
    }, isBroadcast: true);
  }

  @override
  bool get isConnected => _connected;

  @override
  void connect() {
    _connected = true;
    _emit(SignalingConnecting());
    _emit(SignalingConnected());
  }

  @override
  Future<void> disconnect() async {
    _connected = false;
    _emit(SignalingDisconnecting());
    _emit(
      SignalingDisconnected(
        code: null,
        reason: null,
        knownCode: SignalingDisconnectCode.unmappedCode,
        recommendedReconnectDelay: null,
      ),
    );
  }

  @override
  Future<void>? execute(Request request) => Future<void>.value();

  @override
  void cancelRequestsByCallId(String callId) {}

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _buffer.clear();
    await _controller.close();
  }

  void inject(SignalingModuleEvent event) => _emit(event);

  void _emit(SignalingModuleEvent event) {
    if (_controller.isClosed) return;
    _buffer.add(event);
    _controller.add(event);
  }
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Builds and starts a [SignalingHub] backed by [module], then connects the
/// module so [SignalingConnected] is in the hub's session buffer.
///
/// New subscribers immediately receive the session buffer replay and see
/// [SignalingHubModule.isConnected] as true after the ack round-trip.
SignalingHub _startHub(_FakeSignalingModule module) {
  final hub = SignalingHub(module);
  hub.start();
  // Emit SignalingConnecting + SignalingConnected into the hub's session buffer
  // so late-subscribing [SignalingHubModule] instances become connected after
  // the hub replays the buffer on subscribe.
  module.connect();
  return hub;
}

/// Waits up to [timeout] for [condition] to become true, polling every 50 ms.
Future<void> _waitFor(bool Function() condition, {Duration timeout = const Duration(seconds: 2)}) async {
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('Condition not met within $timeout');
    }
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}

// ---------------------------------------------------------------------------
// Test setup helper
// ---------------------------------------------------------------------------

/// Wraps [HubConnectionManager] construction and captures forwarded events.
({HubConnectionManager manager, List<SignalingModuleEvent> received}) _buildManager({bool Function()? isActive}) {
  final received = <SignalingModuleEvent>[];
  bool active = true;
  final manager = HubConnectionManager(
    consumerId: 'test_consumer',
    onEvent: received.add,
    onError: (e, st) => fail('Unexpected error: $e'),
    isActive: isActive ?? () => active,
  );
  return (manager: manager, received: received);
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  SignalingHub? hub;
  _FakeSignalingModule? module;

  tearDown(() async {
    await hub?.dispose();
    await module?.dispose();
    hub = null;
    module = null;
    IsolateNameServer.removePortNameMapping(kSignalingHubPortName);
  });

  group('HubConnectionManager', () {
    test('connects when hub is already running before begin()', () async {
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      final (:manager, :received) = _buildManager();
      addTearDown(manager.tearDown);

      manager.begin();

      await _waitFor(() => manager.isConnected);
      expect(manager.isConnected, isTrue);
    });

    test('polls and connects when hub starts after begin()', () async {
      final (:manager, :received) = _buildManager();
      addTearDown(manager.tearDown);

      manager.begin();
      expect(manager.isConnected, isFalse);

      // Start hub after a delay — manager should find it via polling.
      await Future<void>.delayed(const Duration(milliseconds: 200));
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      await _waitFor(() => manager.isConnected);
      expect(manager.isConnected, isTrue);
    });

    test('second begin() call is a no-op when already connected', () async {
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      final (:manager, :received) = _buildManager();
      addTearDown(manager.tearDown);

      manager.begin();
      await _waitFor(() => manager.isConnected);

      final receivedBefore = received.length;
      manager.begin();
      await Future<void>.delayed(const Duration(milliseconds: 200));

      // No extra events should be emitted from a second connection attempt.
      expect(received.length, equals(receivedBefore));
      expect(manager.isConnected, isTrue);
    });

    test('forwards events from hub to onEvent callback', () async {
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      final (:manager, :received) = _buildManager();
      addTearDown(manager.tearDown);

      manager.begin();
      await _waitFor(() => manager.isConnected);

      module!.inject(SignalingConnecting());

      await _waitFor(() => received.whereType<SignalingConnecting>().isNotEmpty);
      expect(received.whereType<SignalingConnecting>(), isNotEmpty);
    });

    test('tearDown() while polling (no hub) stops cleanly', () async {
      final (:manager, :received) = _buildManager();

      manager.begin();
      expect(manager.isConnected, isFalse);

      // tearDown while still polling — should complete without error.
      await expectLater(manager.tearDown(), completes);
      expect(manager.isConnected, isFalse);
    });

    test('tearDown() after connected disposes the module', () async {
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      final (:manager, :received) = _buildManager();

      manager.begin();
      await _waitFor(() => manager.isConnected);

      await manager.tearDown();

      expect(manager.isConnected, isFalse);
    });

    test('events stop arriving after tearDown()', () async {
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      final (:manager, :received) = _buildManager();

      manager.begin();
      await _waitFor(() => manager.isConnected);
      await manager.tearDown();

      final countAfterTearDown = received.length;
      module!.inject(SignalingConnecting());
      await Future<void>.delayed(const Duration(milliseconds: 200));

      expect(received.length, equals(countAfterTearDown));
    });

    test('isActive() returning false causes polling loop to exit', () async {
      bool active = true;
      final received = <SignalingModuleEvent>[];
      final manager = HubConnectionManager(
        consumerId: 'test_consumer_inactive',
        onEvent: received.add,
        onError: (e, st) => fail('Unexpected error: $e'),
        isActive: () => active,
      );
      addTearDown(manager.tearDown);

      manager.begin();
      expect(manager.isConnected, isFalse);

      // Deactivate before hub appears — loop should exit on its next iteration.
      active = false;
      await Future<void>.delayed(const Duration(milliseconds: 300));

      // Hub starts now, but the loop has already exited.
      module = _FakeSignalingModule();
      hub = _startHub(module!);
      await Future<void>.delayed(const Duration(milliseconds: 300));

      expect(manager.isConnected, isFalse);
    });

    test('concurrent begin() calls result in exactly one connection', () async {
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      final (:manager, :received) = _buildManager();
      addTearDown(manager.tearDown);

      // Call begin() multiple times before polling completes.
      for (var i = 0; i < 5; i++) {
        manager.begin();
      }

      await _waitFor(() => manager.isConnected);

      // Only one SignalingConnected should have been forwarded.
      final connectedEvents = received.whereType<SignalingConnected>().toList();
      expect(connectedEvents.length, equals(1));
    });

    test('tearDown() does not allow whenComplete to restart polling', () async {
      // Regression: whenComplete inside begin() could call begin() again while
      // tearDown() was still running, creating an untracked polling loop.
      // This test verifies that tearDown() fully stops the manager and no
      // reconnection happens unless begin() is explicitly called again.
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      final (:manager, :received) = _buildManager();

      manager.begin();
      await _waitFor(() => manager.isConnected);

      await manager.tearDown();
      expect(manager.isConnected, isFalse);

      // Give the event loop time to run any unexpected restarted polling loops.
      await Future<void>.delayed(const Duration(milliseconds: 300));

      expect(manager.isConnected, isFalse);
    });

    test('reconnects after tearDown() and begin() cycle', () async {
      module = _FakeSignalingModule();
      hub = _startHub(module!);

      final (:manager, :received) = _buildManager();
      addTearDown(manager.tearDown);

      manager.begin();
      await _waitFor(() => manager.isConnected);

      await manager.tearDown();
      expect(manager.isConnected, isFalse);

      // Second begin() should reconnect to the same hub.
      manager.begin();
      await _waitFor(() => manager.isConnected);
      expect(manager.isConnected, isTrue);
    });
  });
}
