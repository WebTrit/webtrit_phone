import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/fgs/hub/signaling_hub.dart';
import 'package:webtrit_signaling_service_android/src/fgs/isolate/signaling_foreground_isolate_manager.dart';

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

  /// Controls whether the hub reports active subscribers.
  ///
  /// Default [true] simulates the normal case where the app is open and the
  /// main isolate is subscribed. Set to [false] to simulate persistent-service
  /// mode where the app is closed and there are no subscribers.
  @override
  bool hasSubscribers = true;

  /// Mirrors the real hub's [onHasSubscribersChanged] hook so tests can
  /// drive subscriber-count transitions directly.
  @override
  void Function(bool hasSubscribers)? onHasSubscribersChanged;

  @override
  void start() {}

  @override
  Future<void> dispose() async {}

  /// Simulates a subscriber connecting or disconnecting.
  ///
  /// Updates [hasSubscribers] and fires [onHasSubscribersChanged], matching
  /// what the real hub does on a 0→1 or 1→0 transition.
  void simulateSubscriberChange({required bool hasSubscribers}) {
    this.hasSubscribers = hasSubscribers;
    onHasSubscribersChanged?.call(hasSubscribers);
  }
}

// ---------------------------------------------------------------------------
// Helper
// ---------------------------------------------------------------------------

/// Creates a manager where the hub reports active subscribers (app is open).
///
/// Reconnect decisions are delegated to the main isolate; the background
/// isolate must not auto-reconnect in this configuration.
SignalingForegroundIsolateManager _makeManager(_FakeSignalingModule module) {
  return SignalingForegroundIsolateManager(
    coreUrl: 'wss://example.com',
    tenantId: 'tenant',
    token: 'tok',
    // moduleFactoryHandle is 0 by default, but _testModuleFactory overrides
    // the handle-resolution path, so 0 does not trigger the "no factory" guard.
    moduleFactory: (_) => module,
    hubFactory: _FakeSignalingHub.new, // hasSubscribers defaults to true
  );
}

/// Creates a manager (with subscribers) where [safetyReconnectGrace] is small
/// enough to test the safety fallback without real-time sleeping.
SignalingForegroundIsolateManager _makeManagerWithSafetyGrace(
  _FakeSignalingModule module, {
  Duration grace = const Duration(milliseconds: 20),
}) {
  return SignalingForegroundIsolateManager(
    coreUrl: 'wss://example.com',
    tenantId: 'tenant',
    token: 'tok',
    safetyReconnectGrace: grace,
    moduleFactory: (_) => module,
    hubFactory: _FakeSignalingHub.new, // hasSubscribers defaults to true
  );
}

/// Creates a manager where the hub reports NO subscribers (app is closed —
/// persistent-service mode). The background isolate must auto-reconnect
/// independently in this configuration.
SignalingForegroundIsolateManager _makeManagerPersistentMode(_FakeSignalingModule module) {
  return SignalingForegroundIsolateManager(
    coreUrl: 'wss://example.com',
    tenantId: 'tenant',
    token: 'tok',
    moduleFactory: (_) => module,
    hubFactory: (m) => _FakeSignalingHub(m)..hasSubscribers = false,
  );
}

/// Creates a pushBound manager and exposes the hub so tests can trigger
/// subscriber transitions.
///
/// [stopServiceCalls] is incremented every time [_requestServiceStop] fires,
/// which substitutes for the Pigeon [PSignalingServiceHostApi().stopService()]
/// call that is unavailable in unit tests.
({SignalingForegroundIsolateManager manager, _FakeSignalingHub Function() hub, List<int> stopServiceCalls})
_makePushBoundManager(_FakeSignalingModule module, {Duration grace = const Duration(milliseconds: 50)}) {
  _FakeSignalingHub? capturedHub;
  final stopCalls = <int>[];

  final manager = SignalingForegroundIsolateManager(
    coreUrl: 'wss://example.com',
    tenantId: 'tenant',
    token: 'tok',
    isPushBound: true,
    pushBoundNoSubscriberGrace: grace,
    moduleFactory: (_) => module,
    hubFactory: (m) {
      capturedHub = _FakeSignalingHub(m);
      return capturedHub!;
    },
    stopServiceOverride: () => stopCalls.add(1),
  );

  return (manager: manager, hub: () => capturedHub!, stopServiceCalls: stopCalls);
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
  // No auto-reconnect when subscribers present — delegated to main isolate
  // -------------------------------------------------------------------------

  // When the main isolate is subscribed to the hub (app is open), reconnect
  // decisions belong exclusively to SignalingReconnectController. It sends
  // SignalingHubConnectCommand via the hub when it decides to reconnect.
  // The foreground-service isolate must NOT reconnect on its own — doing so
  // would bypass lifecycle guards (e.g. app paused, no active calls) and
  // cause spurious 4502 reconnect loops.

  group('SignalingForegroundIsolateManager -- no auto-reconnect when main isolate is subscribed', () {
    test('does NOT reconnect when disconnect carries a non-null delay hint', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      module.simulateDisconnectWithDelay(const Duration(milliseconds: 50));
      await Future<void>.delayed(Duration.zero);

      // Wait well past the old reconnect deadline — no reconnect must fire.
      await Future<void>.delayed(const Duration(milliseconds: 150));
      expect(module.connectCount, 1, reason: 'isolate must not auto-reconnect; only main isolate may reconnect');
    });

    test('does NOT reconnect when connection fails with a delay hint', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      module.simulateConnectionFailed(const Duration(milliseconds: 50));

      await Future<void>.delayed(const Duration(milliseconds: 150));
      expect(module.connectCount, 1, reason: 'isolate must not auto-reconnect; only main isolate may reconnect');
    });
  });

  // -------------------------------------------------------------------------
  // Persistent-service mode — auto-reconnect when no subscribers (app closed)
  // -------------------------------------------------------------------------

  // In persistent signaling mode the foreground service outlives the app.
  // When the app is closed there are no hub subscribers, so
  // SignalingReconnectController is not running. The background isolate must
  // therefore manage reconnects locally until the app reopens and the main
  // isolate subscribes again.

  group('SignalingForegroundIsolateManager -- persistent mode auto-reconnect (no subscribers)', () {
    test('reconnects after disconnect when no subscribers and delay is provided', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManagerPersistentMode(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      module.simulateDisconnectWithDelay(const Duration(milliseconds: 50));
      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(module.connectCount, 2, reason: 'isolate must auto-reconnect in persistent mode when no subscribers');
    });

    test('reconnects after connection failed when no subscribers and delay is provided', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManagerPersistentMode(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      module.simulateConnectionFailed(const Duration(milliseconds: 50));
      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(module.connectCount, 2, reason: 'isolate must auto-reconnect in persistent mode when no subscribers');
    });

    test('does NOT reconnect when delay is null (e.g. code 1002) even with no subscribers', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManagerPersistentMode(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      // code 1002 → recommendedReconnectDelay == null → no reconnect
      module.simulateDisconnect1002();
      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(module.connectCount, 1, reason: 'null delay means server rejected reconnect');
    });

    test('stop() cancels a pending persistent-mode reconnect timer', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManagerPersistentMode(module);

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      module.simulateDisconnectWithDelay(const Duration(milliseconds: 50));

      // Stop before the timer fires.
      await manager.handleStatus(enabled: false);
      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(module.connectCount, 1, reason: 'timer cancelled by stop() — no reconnect after dispose');
    });
  });

  // -------------------------------------------------------------------------
  // pushBound mode — orphan-service cleanup
  // -------------------------------------------------------------------------

  // In pushBound mode the service is started by a push notification.
  // The push-notification isolate (FSM) always subscribes to the hub first,
  // then unsubscribes after processing the event. The cleanup timer is
  // scheduled on 1→0 subscriber transitions (not at start time) so that
  // the 10-second grace period begins from when the push isolate leaves —
  // giving the Activity time to connect. If no Activity connects within the
  // grace period, stopService() is called.

  group('SignalingForegroundIsolateManager -- pushBound cleanup timer', () {
    test('stopService called after grace period when push isolate leaves and Activity never connects', () async {
      final module = _FakeSignalingModule();
      final (:manager, :hub, :stopServiceCalls) = _makePushBoundManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      // Push isolate subscribes (simulating FCM handler connecting to hub).
      hub().simulateSubscriberChange(hasSubscribers: true);
      expect(stopServiceCalls, isEmpty);

      // Push isolate unsubscribes — 10s grace period starts now.
      hub().simulateSubscriberChange(hasSubscribers: false);
      expect(stopServiceCalls, isEmpty, reason: 'grace period has not elapsed yet');

      // Activity never connects — timer fires.
      await Future<void>.delayed(const Duration(milliseconds: 150));
      expect(stopServiceCalls, hasLength(1), reason: 'stopService must fire after grace period with no Activity');
    });

    test('cleanup timer is cancelled when Activity connects within the grace period', () async {
      final module = _FakeSignalingModule();
      final (:manager, :hub, :stopServiceCalls) = _makePushBoundManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      // Push isolate subscribes then unsubscribes — timer starts.
      hub().simulateSubscriberChange(hasSubscribers: true);
      hub().simulateSubscriberChange(hasSubscribers: false);

      // Activity connects before grace period expires — timer must be cancelled.
      hub().simulateSubscriberChange(hasSubscribers: true);

      await Future<void>.delayed(const Duration(milliseconds: 150));
      expect(stopServiceCalls, isEmpty, reason: 'Activity arrived — cleanup timer must be cancelled');
    });

    test('new cleanup timer is scheduled when Activity disconnects', () async {
      final module = _FakeSignalingModule();
      final (:manager, :hub, :stopServiceCalls) = _makePushBoundManager(module);
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      // Normal flow: push isolate subscribes/unsubscribes, Activity connects.
      hub().simulateSubscriberChange(hasSubscribers: true);
      hub().simulateSubscriberChange(hasSubscribers: false);
      hub().simulateSubscriberChange(hasSubscribers: true);

      // Activity disconnects — new cleanup timer starts.
      hub().simulateSubscriberChange(hasSubscribers: false);

      await Future<void>.delayed(const Duration(milliseconds: 150));
      expect(stopServiceCalls, hasLength(1), reason: 'last subscriber left — stopService must fire after grace period');
    });

    test('stop() cancels the cleanup timer — stopService not called after explicit stop', () async {
      final module = _FakeSignalingModule();
      final (:manager, :hub, :stopServiceCalls) = _makePushBoundManager(module);

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      // Push isolate subscribes/unsubscribes — timer starts.
      hub().simulateSubscriberChange(hasSubscribers: true);
      hub().simulateSubscriberChange(hasSubscribers: false);

      // Explicit stop before grace period expires.
      await manager.handleStatus(enabled: false);

      await Future<void>.delayed(const Duration(milliseconds: 150));
      expect(stopServiceCalls, isEmpty, reason: 'explicit stop cancels cleanup timer');
    });

    test('persistent mode (isPushBound=false) never schedules a cleanup timer', () async {
      final module = _FakeSignalingModule();
      _FakeSignalingHub? capturedHub;
      final stopCalls = <int>[];

      final manager = SignalingForegroundIsolateManager(
        coreUrl: 'wss://example.com',
        tenantId: 'tenant',
        token: 'tok',
        isPushBound: false,
        moduleFactory: (_) => module,
        hubFactory: (m) {
          capturedHub = _FakeSignalingHub(m);
          return capturedHub!;
        },
        stopServiceOverride: () => stopCalls.add(1),
      );
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);

      // Simulate subscriber leaving — in persistent mode this must be a no-op.
      capturedHub!.simulateSubscriberChange(hasSubscribers: false);

      await Future<void>.delayed(const Duration(milliseconds: 150));

      expect(stopCalls, isEmpty, reason: 'persistent mode must not schedule cleanup timer');
    });
  });

  // -------------------------------------------------------------------------
  // Safety reconnect — fallback when main isolate sync does not arrive
  // -------------------------------------------------------------------------

  // When hasSubscribers is true (app open), reconnect decisions normally belong
  // to SignalingReconnectController. If the sync round-trip (startService →
  // onStartCommand → synchronizeIsolate → Pigeon → handleStatus) fails silently
  // (e.g. Pigeon dropped on MIUI), the safety timer fires after
  // recommendedReconnectDelay + safetyReconnectGrace and reconnects directly.

  group('SignalingForegroundIsolateManager -- safety reconnect (main isolate fallback)', () {
    test('safety timer fires and reconnects when main isolate sync never arrives (disconnect)', () async {
      final module = _FakeSignalingModule();
      // Use a tiny grace so the test completes quickly.
      final manager = _makeManagerWithSafetyGrace(module, grace: const Duration(milliseconds: 20));
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      // WebSocket drops — reconnect delay 50ms, safety fires at 50+20=70ms.
      module.simulateDisconnectWithDelay(const Duration(milliseconds: 50));
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1); // no immediate reconnect

      // Wait past safety window — safety timer fires.
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(module.connectCount, 2, reason: 'safety timer must fire and reconnect');
    });

    test('safety timer fires and reconnects when main isolate sync never arrives (connection failed)', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManagerWithSafetyGrace(module, grace: const Duration(milliseconds: 20));
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      module.simulateConnectionFailed(const Duration(milliseconds: 50));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(module.connectCount, 2, reason: 'safety timer must fire after connection failed');
    });

    test('safety timer is cancelled when _start() arrives via main isolate sync', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManagerWithSafetyGrace(module, grace: const Duration(milliseconds: 50));
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      module.simulateDisconnectWithDelay(const Duration(milliseconds: 20));
      await Future<void>.delayed(Duration.zero);

      // Main isolate sync arrives before safety window — cancels timer and reconnects.
      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 2);

      // Wait past safety deadline — must not fire a second reconnect.
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(module.connectCount, 2, reason: 'safety timer must be cancelled by _start()');
    });

    test('safety timer is cancelled on SignalingConnected (connection restored by other means)', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManagerWithSafetyGrace(module, grace: const Duration(milliseconds: 50));
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      module.simulateDisconnectWithDelay(const Duration(milliseconds: 20));
      await Future<void>.delayed(Duration.zero);

      // Simulate the main isolate reconnecting via hub command (not handleStatus),
      // which causes _FakeSignalingModule.connect() to emit SignalingConnected.
      module.connect(); // emits SignalingConnected internally
      await Future<void>.delayed(Duration.zero);

      final countAfterReconnect = module.connectCount;

      // Safety timer must have been cancelled by the SignalingConnected event.
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(module.connectCount, countAfterReconnect, reason: 'safety timer must be cancelled on SignalingConnected');
    });

    test('safety timer does NOT fire when delay is null (server says do not reconnect)', () async {
      final module = _FakeSignalingModule();
      final manager = _makeManagerWithSafetyGrace(module, grace: const Duration(milliseconds: 20));
      addTearDown(() => manager.handleStatus(enabled: false));

      await manager.handleStatus(enabled: true);
      await Future<void>.delayed(Duration.zero);
      expect(module.connectCount, 1);

      // code 1002 → recommendedReconnectDelay == null → no safety timer.
      module.simulateDisconnect1002();
      await Future<void>.delayed(const Duration(milliseconds: 100));
      expect(module.connectCount, 1, reason: 'null delay must suppress the safety timer too');
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
