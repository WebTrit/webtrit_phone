import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/services/signaling_module.dart';
import 'package:webtrit_phone/features/call/services/signaling_reconnect_controller.dart';

// ---------------------------------------------------------------------------
// Fake SignalingModule
// ---------------------------------------------------------------------------

class _FakeSignalingModule implements SignalingReconnectable {
  final _controller = StreamController<SignalingModuleEvent>.broadcast(sync: true);

  int connectCalls = 0;
  int disconnectCalls = 0;

  @override
  bool isConnected = false;

  @override
  Stream<SignalingModuleEvent> get events => _controller.stream;

  void emit(SignalingModuleEvent event) => _controller.add(event);

  @override
  void connect() => connectCalls++;

  @override
  Future<void> disconnect() async => disconnectCalls++;

  Future<void> dispose() async => _controller.close();
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

SignalingConnectionFailed _failed({Duration? delay}) => SignalingConnectionFailed(
  error: Exception('connect error'),
  recommendedReconnectDelay: delay ?? kSignalingClientReconnectDelay,
  isRepeated: false,
);

SignalingConnectionLost _lost() => SignalingConnectionLost(
  error: Exception('socket error'),
  recommendedReconnectDelay: kSignalingClientReconnectDelay,
  isRepeated: false,
);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  // -------------------------------------------------------------------------
  // Constructor validation
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - constructor', () {
    test('asserts when notifyAfterConsecutiveFailures < 1', () {
      final module = _FakeSignalingModule();
      addTearDown(module.dispose);

      expect(
        () => SignalingReconnectController(signalingModule: module, notifyAfterConsecutiveFailures: 0),
        throwsA(isA<AssertionError>()),
      );
    });

    test('asserts when notifyAfterConsecutiveFailures is negative', () {
      final module = _FakeSignalingModule();
      addTearDown(module.dispose);

      expect(
        () => SignalingReconnectController(signalingModule: module, notifyAfterConsecutiveFailures: -1),
        throwsA(isA<AssertionError>()),
      );
    });

    test('accepts notifyAfterConsecutiveFailures == 1', () {
      final module = _FakeSignalingModule();
      addTearDown(module.dispose);

      expect(
        () => SignalingReconnectController(signalingModule: module, notifyAfterConsecutiveFailures: 1)..dispose(),
        returnsNormally,
      );
    });
  });

  // -------------------------------------------------------------------------
  // Failure threshold — notifies exactly once
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - failure threshold', () {
    test('no notification below threshold', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: () => notifyCount++,
          notifyAfterConsecutiveFailures: 3,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_failed());
        module.emit(_failed());

        expect(notifyCount, 0);
      });
    });

    test('notifies exactly once when threshold is reached', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: () => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_failed());
        module.emit(_failed());

        expect(notifyCount, 1);
      });
    });

    test('does not notify again on failures beyond threshold', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: () => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_failed());
        module.emit(_failed());
        module.emit(_failed());
        module.emit(_failed());

        expect(notifyCount, 1);
      });
    });

    test('SignalingConnected resets counter — next outage notifies again at threshold', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: () => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        // First outage reaches threshold.
        module.emit(_failed());
        module.emit(_failed());
        expect(notifyCount, 1);

        // Recover.
        module.emit(SignalingConnected());

        // Second outage — counter reset, should notify again at threshold.
        module.emit(_failed());
        module.emit(_failed());
        expect(notifyCount, 2);
      });
    });
  });

  // -------------------------------------------------------------------------
  // SignalingConnectionLost — immediate notification
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - SignalingConnectionLost', () {
    test('notifies immediately on first SignalingConnectionLost', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: () => notifyCount++,
          notifyAfterConsecutiveFailures: 5,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_lost());

        expect(notifyCount, 1);
      });
    });

    test('resets consecutive failure counter on SignalingConnectionLost', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: () => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        // Accumulate one failure.
        module.emit(_failed());
        expect(notifyCount, 0);

        // Session lost — resets counter and notifies immediately.
        module.emit(_lost());
        expect(notifyCount, 1);

        // After reset, threshold requires 2 more failures.
        module.emit(_failed());
        expect(notifyCount, 1);
        module.emit(_failed());
        expect(notifyCount, 2);
      });
    });
  });

  // -------------------------------------------------------------------------
  // Reconnect scheduling
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - reconnect scheduling', () {
    test('schedules reconnect after SignalingConnectionFailed', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        module.emit(_failed(delay: kSignalingClientReconnectDelay));
        expect(module.connectCalls, 0);

        async.elapse(kSignalingClientReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });

    test('schedules reconnect after SignalingConnectionLost', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        module.emit(_lost());
        expect(module.connectCalls, 0);

        async.elapse(kSignalingClientReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });

    test('schedules reconnect after SignalingDisconnected with non-null delay', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        module.emit(
          SignalingDisconnected(
            code: 1001,
            reason: 'going away',
            knownCode: SignalingDisconnectCode.goingAway,
            recommendedReconnectDelay: kSignalingClientReconnectDelay,
          ),
        );

        async.elapse(kSignalingClientReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });

    test('does not schedule reconnect after SignalingDisconnected with null delay', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        module.emit(
          SignalingDisconnected(
            code: 1002,
            reason: 'protocol error',
            knownCode: SignalingDisconnectCode.protocolError,
            recommendedReconnectDelay: null,
          ),
        );

        async.elapse(const Duration(seconds: 60));
        expect(module.connectCalls, 0);
      });
    });

    test('reconnectEnabled: false — timer never fires connect', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final controller = SignalingReconnectController(signalingModule: module, reconnectEnabled: false);
        addTearDown(controller.dispose);

        module.emit(_failed());
        async.elapse(const Duration(minutes: 1));
        expect(module.connectCalls, 0);
      });
    });
  });

  // -------------------------------------------------------------------------
  // App lifecycle guards
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - app lifecycle', () {
    test('notifyAppPaused without active calls — disconnects and skips reconnect', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        module.isConnected = true;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyAppPaused(hasActiveCalls: false);
        expect(module.disconnectCalls, 1);

        module.emit(_failed());
        async.elapse(const Duration(minutes: 1));
        expect(module.connectCalls, 0);
      });
    });

    test('notifyAppPaused with active calls — does not disconnect, reconnect still fires', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyAppPaused(hasActiveCalls: true);
        expect(module.disconnectCalls, 0);

        module.emit(_failed(delay: kSignalingClientReconnectDelay));
        async.elapse(kSignalingClientReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });

    test('notifyAppResumed — sets app active and schedules fast reconnect', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyAppPaused(hasActiveCalls: false);
        controller.notifyAppResumed();

        async.elapse(kSignalingClientFastReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });
  });

  // -------------------------------------------------------------------------
  // Network guards
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - network guards', () {
    test('notifyNetworkUnavailable — disconnects and skips reconnect timer', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        module.isConnected = true;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyNetworkUnavailable();
        expect(module.disconnectCalls, 1);

        module.emit(_failed());
        async.elapse(const Duration(minutes: 1));
        expect(module.connectCalls, 0);
      });
    });

    test('notifyNetworkAvailable — schedules fast reconnect', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyNetworkUnavailable();
        controller.notifyNetworkAvailable();

        async.elapse(kSignalingClientFastReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });
  });

  // -------------------------------------------------------------------------
  // Force reconnect
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - notifyForceReconnect', () {
    test('fires connect even when app is paused', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyAppPaused(hasActiveCalls: false);
        controller.notifyForceReconnect();

        async.elapse(kSignalingClientFastReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });

    test('fires connect even when network is unavailable', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyNetworkUnavailable();
        controller.notifyForceReconnect();

        async.elapse(kSignalingClientFastReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });
  });

  // -------------------------------------------------------------------------
  // dispose() safety
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - dispose', () {
    test('timer does not call connect after dispose', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);

        module.emit(_failed(delay: kSignalingClientReconnectDelay));
        controller.dispose();

        async.elapse(kSignalingClientReconnectDelay);
        expect(module.connectCalls, 0);
      });
    });

    test('no events processed after dispose', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: () => notifyCount++,
          notifyAfterConsecutiveFailures: 1,
          reconnectEnabled: false,
        );

        controller.dispose();
        module.emit(_failed());

        expect(notifyCount, 0);
        expect(module.connectCalls, 0);
      });
    });
  });

  // -------------------------------------------------------------------------
  // onConnectionPresenceChanged
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - onConnectionPresenceChanged', () {
    test('emits false when consecutive failures reach threshold', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final presence = <bool>[];
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionPresenceChanged: presence.add,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_failed());
        expect(presence, isEmpty);

        module.emit(_failed());
        expect(presence, [false]);
      });
    });

    test('does not emit false again on subsequent failures after threshold', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final presence = <bool>[];
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionPresenceChanged: presence.add,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_failed());
        module.emit(_failed());
        module.emit(_failed());
        module.emit(_failed());

        expect(presence, [false]);
      });
    });

    test('emits false immediately on SignalingConnectionLost', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final presence = <bool>[];
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionPresenceChanged: presence.add,
          notifyAfterConsecutiveFailures: 5,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_lost());

        expect(presence, [false]);
      });
    });

    test('emits true on SignalingConnected after unavailable', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final presence = <bool>[];
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionPresenceChanged: presence.add,
          notifyAfterConsecutiveFailures: 1,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_failed());
        expect(presence, [false]);

        module.emit(SignalingConnected());
        expect(presence, [false, true]);
      });
    });

    test('does not emit true twice when already available', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final presence = <bool>[];
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionPresenceChanged: presence.add,
          notifyAfterConsecutiveFailures: 1,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(SignalingConnected());
        module.emit(SignalingConnected());

        expect(presence, isEmpty);
      });
    });

    test('emits false on notifyNetworkUnavailable', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final presence = <bool>[];
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionPresenceChanged: presence.add,
        );
        addTearDown(controller.dispose);

        controller.notifyNetworkUnavailable();

        expect(presence, [false]);
      });
    });

    test('full cycle: unavailable → available → unavailable', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        final presence = <bool>[];
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionPresenceChanged: presence.add,
          notifyAfterConsecutiveFailures: 1,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_failed());
        module.emit(SignalingConnected());
        module.emit(_lost());

        expect(presence, [false, true, false]);
      });
    });
  });
}
