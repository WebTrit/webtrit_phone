import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/hub/signaling_hub.dart';
import 'package:webtrit_signaling_service_android/src/isolate/signaling_foreground_isolate_manager.dart';

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

/// Fake [SignalingModule] that tracks [connect] calls and lets tests control
/// [isConnected] and the event stream directly.
class _FakeSignalingModule extends Fake implements SignalingModule {
  final _controller = StreamController<SignalingModuleEvent>.broadcast();

  int connectCount = 0;
  bool _connected = false;

  @override
  bool get isConnected => _connected;

  @override
  Stream<SignalingModuleEvent> get events => _controller.stream;

  @override
  void connect() {
    connectCount++;
    _connected = true;
    _controller.add(SignalingConnected());
  }

  @override
  Future<void>? execute(Request request) => null;

  @override
  Future<void> disconnect() async {
    _connected = false;
  }

  @override
  Future<void> dispose() async {
    _connected = false;
    await _controller.close();
  }

  /// Simulates a WebSocket close with code 1002 (protocol error).
  ///
  /// [SignalingModuleImpl._reconnectDelay] maps 1002 to null, so the manager
  /// does not schedule an auto-reconnect -- reproducing the exact scenario
  /// that triggered the bug.
  void simulateDisconnect1002() {
    _connected = false;
    _controller.add(
      SignalingDisconnected(
        code: 1002,
        reason: null,
        knownCode: SignalingDisconnectCode.protocolError,
        recommendedReconnectDelay: null,
      ),
    );
  }

  /// Simulates a disconnect that includes a reconnect delay hint (e.g. code 1001).
  void simulateDisconnectWithDelay(Duration delay) {
    _connected = false;
    _controller.add(
      SignalingDisconnected(
        code: 1001,
        reason: null,
        knownCode: SignalingDisconnectCode.goingAway,
        recommendedReconnectDelay: delay,
      ),
    );
  }

  /// Simulates a connection failure with a delay hint.
  void simulateConnectionFailed(Duration delay) {
    _connected = false;
    _controller.add(
      SignalingConnectionFailed(error: Exception('timeout'), isRepeated: false, recommendedReconnectDelay: delay),
    );
  }
}

/// No-op [SignalingHub] that avoids [IsolateNameServer] and [ReceivePort] in tests.
class _FakeSignalingHub extends Fake implements SignalingHub {
  // ignore: avoid_unused_constructor_parameters
  _FakeSignalingHub(SignalingModule _);

  @override
  void start() {}

  @override
  Future<void> dispose() async {}
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

SignalingForegroundIsolateManager _makeManager(_FakeSignalingModule module) {
  return SignalingForegroundIsolateManager(
    coreUrl: 'wss://example.com',
    tenantId: 'tenant',
    token: 'tok',
    // moduleFactoryHandle is 0 by default, but _testModuleFactory overrides
    // the handle-resolution path, so 0 does not trigger the "no factory" guard.
    moduleFactory: (_) => module,
    hubFactory: _FakeSignalingHub.new,
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // Initial start
  // -------------------------------------------------------------------------

  group('SignalingForegroundIsolateManager -- initial start', () {
    test('calls connect() on the module on first handleStatus(enabled: true)', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      expect(module.connectCount, 1);
    });

    test('is idempotent when already started and connected', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      expect(module.connectCount, 1);
    });
  });

  // -------------------------------------------------------------------------
  // Reconnect after code-1002 disconnect (the bug scenario)
  // -------------------------------------------------------------------------

  group('SignalingForegroundIsolateManager -- reconnect after code-1002', () {
    test('reconnects when handleStatus(enabled: true) is called after a 1002 disconnect '
        'that did not schedule an auto-reconnect', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      // Initial start — module connects.
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);
      expect(module.isConnected, isTrue);

      // WebSocket closes with code 1002. recommendedReconnectDelay == null,
      // so the manager does not schedule an auto-reconnect.
      module.simulateDisconnect1002();
      await Future<void>.delayed(Duration.zero);
      expect(module.isConnected, isFalse);
      expect(module.connectCount, 1); // still 1 — no auto-reconnect

      // Main isolate detects WiFi restored and calls start() again.
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      expect(module.connectCount, 2);
    });

    test('does not reconnect when module is still connected after handleStatus(enabled: true)', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.isConnected, isTrue);

      // Trigger again while connected — should be a no-op.
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      expect(module.connectCount, 1);
    });
  });

  // -------------------------------------------------------------------------
  // Auto-reconnect via delay hint
  // -------------------------------------------------------------------------

  group('SignalingForegroundIsolateManager -- auto-reconnect via delay hint', () {
    test('schedules reconnect when disconnect carries a non-null delay', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      module.simulateDisconnectWithDelay(const Duration(milliseconds: 50));
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1); // not yet

      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(module.connectCount, 2); // reconnected via timer
    });

    test('schedules reconnect when connection fails with a delay hint', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      module.simulateConnectionFailed(const Duration(milliseconds: 50));
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(module.connectCount, 2);
    });
  });

  // -------------------------------------------------------------------------
  // Stop / restart cycle
  // -------------------------------------------------------------------------

  group('SignalingForegroundIsolateManager -- stop and restart', () {
    test('disposes module on handleStatus(enabled: false)', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      await manager.handleStatus(enabled: false);

      expect(module.isConnected, isFalse);
    });

    test('full restart creates a fresh module after stop', () async {
      final modules = <_FakeSignalingModule>[];
      int callCount = 0;
      final manager = SignalingForegroundIsolateManager(
        coreUrl: 'wss://example.com',
        tenantId: 'tenant',
        token: 'tok',
        moduleFactory: (_) {
          final m = _FakeSignalingModule();
          modules.add(m);
          callCount++;
          return m;
        },
        hubFactory: _FakeSignalingHub.new,
      );

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      await manager.handleStatus(enabled: false);

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      // Factory must have been called twice — once per start.
      expect(callCount, 2);
      expect(modules[0].connectCount, 1);
      expect(modules[1].connectCount, 1);

      await manager.handleStatus(enabled: false);
    });
  });
}
