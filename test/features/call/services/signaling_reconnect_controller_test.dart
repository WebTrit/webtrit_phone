import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/call/services/signaling_reconnect_controller.dart';

// ---------------------------------------------------------------------------
// Fake SignalingModule
// ---------------------------------------------------------------------------

class _FakeSignalingModule implements SignalingModule {
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

  @override
  Future<void>? execute(Request request) => null;

  @override
  void cancelRequestsByCallId(String callId) {}

  @override
  void clearTerminatingMark(String callId) {}

  @override
  Future<void> dispose() async => _controller.close();
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

SignalingConnectionFailed _failed({Duration? delay}) => SignalingConnectionFailed(
  error: Exception('connect error'),
  isRepeated: false,
  recommendedReconnectDelay: delay ?? kSignalingClientReconnectDelay,
);

// Simulates an unexpected TCP-level connection close (established session lost).
SignalingDisconnected _lost() => SignalingDisconnected(
  code: null,
  reason: null,
  knownCode: SignalingDisconnectCode.unmappedCode,
  recommendedReconnectDelay: kSignalingClientReconnectDelay,
);

// Simulates a server-side keepalive timeout (backgrounded app, Android network restrictions).
SignalingDisconnected _keepaliveTimeout() => SignalingDisconnected(
  code: 4502,
  reason: 'signaling keepalive timeout error',
  knownCode: SignalingDisconnectCode.signalingKeepaliveTimeoutError,
  recommendedReconnectDelay: kSignalingClientReconnectDelay,
);

// Simulates server closing WS after SIP unregistration (user toggled Online off).
SignalingDisconnected _appUnregistered() => SignalingDisconnected(
  code: 4302,
  reason: 'app unregister processed',
  knownCode: SignalingDisconnectCode.appUnregisteredError,
  recommendedReconnectDelay: kSignalingClientReconnectDelay,
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
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
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
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
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
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
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
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
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
  // onConnectionFailed — knownCode forwarding
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - onConnectionFailed knownCode', () {
    test('passes null knownCode on SignalingConnectionFailed', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        SignalingDisconnectCode? receivedCode = SignalingDisconnectCode.unmappedCode; // sentinel
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (failure) => receivedCode = failure.knownCode,
          notifyAfterConsecutiveFailures: 1,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(_failed());

        expect(receivedCode, isNull);
      });
    });

    test('passes knownCode on SignalingDisconnected (unexpected)', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        SignalingDisconnectCode? receivedCode;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (failure) => receivedCode = failure.knownCode,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(SignalingConnected());
        module.emit(_lost());

        expect(receivedCode, SignalingDisconnectCode.unmappedCode);
      });
    });

    test('passes signalingKeepaliveTimeoutError knownCode on keepalive disconnect', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        SignalingDisconnectCode? receivedCode;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (failure) => receivedCode = failure.knownCode,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(SignalingConnected());
        module.emit(_keepaliveTimeout());

        expect(receivedCode, SignalingDisconnectCode.signalingKeepaliveTimeoutError);
      });
    });

    test('passes appUnregisteredError knownCode on SIP unregister disconnect', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        SignalingDisconnectCode? receivedCode;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (failure) => receivedCode = failure.knownCode,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(SignalingConnected());
        module.emit(_appUnregistered());

        expect(receivedCode, SignalingDisconnectCode.appUnregisteredError);
      });
    });
  });

  // -------------------------------------------------------------------------
  // SignalingDisconnected (unexpected) — immediate notification
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - SignalingDisconnected (unexpected)', () {
    test('notifies immediately on first SignalingDisconnected (unexpected)', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
          notifyAfterConsecutiveFailures: 5,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        module.emit(SignalingConnected());
        module.emit(_lost());

        expect(notifyCount, 1);
      });
    });

    test(
      'does not notify when disconnect arrives without established session (WT-1337: stale socket close on resume)',
      () {
        fakeAsync((async) {
          final module = _FakeSignalingModule();
          addTearDown(module.dispose);
          int notifyCount = 0;
          final controller = SignalingReconnectController(
            signalingModule: module,
            onConnectionFailed: (_) => notifyCount++,
            reconnectEnabled: false,
          );
          addTearDown(controller.dispose);

          // Simulates _connectAsync closing a stale socket after notifyAppResumed()
          // resets _wasConnected to false. No prior SignalingConnected in this cycle.
          module.emit(_lost());

          expect(notifyCount, 0);
        });
      },
    );

    test('resets consecutive failure counter on SignalingDisconnected (unexpected)', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        // Accumulate one failure.
        module.emit(_failed());
        expect(notifyCount, 0);

        // Session established, then lost — resets counter and notifies immediately.
        module.emit(SignalingConnected());
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
        addTearDown(module.dispose);
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        module.emit(_failed(delay: kSignalingClientReconnectDelay));
        expect(module.connectCalls, 0);

        async.elapse(kSignalingClientReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });

    test('schedules reconnect after SignalingDisconnected (unexpected)', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyAppPaused(hasActiveCalls: false);
        controller.notifyAppResumed();

        async.elapse(kSignalingClientFastReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });

    // WT-1221: "Connecting to the core failed" toast on screen unlock.
    //
    // Scenario: user had an active session (_wasConnected = true), locked the
    // screen, then unlocked. The first post-unlock connect failure must go
    // through the consecutive-failure threshold — not fire onConnectionFailed
    // immediately as if an established session was lost.
    test('notifyAppPaused resets _wasConnected — post-unlock failure respects threshold (WT-1221)', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        // Establish a session so _wasConnected = true.
        module.emit(SignalingConnected());
        expect(notifyCount, 0);

        // Screen lock — intentional disconnect.
        controller.notifyAppPaused(hasActiveCalls: false);

        // Screen unlock — first post-unlock connect failure.
        controller.notifyAppResumed();
        module.emit(_failed());

        // Must NOT fire immediately (would be wrong: no session was lost).
        expect(notifyCount, 0, reason: 'first post-unlock failure must not trigger toast immediately');

        // Second failure reaches threshold — now it is appropriate to notify.
        module.emit(_failed());
        expect(notifyCount, 1);
      });
    });

    // Copilot review: notifyAppResumed must NOT reset _wasConnected when there
    // is an active call. If it did, a subsequent SignalingConnectionFailed would
    // be misclassified as an initial connect attempt (going through the
    // consecutive-failure threshold) instead of an established-session drop
    // that notifies immediately.
    test('notifyAppResumed during active call preserves _wasConnected — failure notifies immediately', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
          notifyAfterConsecutiveFailures: 3,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        // Session established — _wasConnected = true.
        module.emit(SignalingConnected());

        // Brief background while a call is active (e.g. user swipes away and back).
        controller.notifyAppPaused(hasActiveCalls: true);
        controller.notifyHasActiveCalls(hasActiveCalls: true);

        // App comes back to foreground during the call.
        controller.notifyAppResumed();

        // Connection drops — must notify immediately because _wasConnected is still true.
        module.emit(_failed());
        expect(
          notifyCount,
          1,
          reason: 'established-session drop during active call must notify immediately, not wait for threshold',
        );
      });
    });

    // Background reconnect race: on Android the hub module's connect/disconnect
    // are no-ops, so the background isolate can reconnect while the app is
    // paused and set _wasConnected = true. A subsequent failure must NOT queue
    // a notification (it would appear incorrectly when the app resumes).
    test('background reconnect while paused — failure does not fire onConnectionFailed', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        // App goes background.
        controller.notifyAppPaused(hasActiveCalls: false);

        // Background isolate reconnects independently (hub broadcasts SignalingConnected).
        module.emit(SignalingConnected());

        // Connection fails while still paused (e.g. 4502 or generic error).
        module.emit(_failed());
        module.emit(_keepaliveTimeout());

        // No notifications must have been queued — user is not watching.
        expect(notifyCount, 0, reason: 'backgrounded without calls — no toast must be queued');
      });
    });

    // notifyAppResumed resets _consecutiveFailures so that many background
    // failures do not push the counter past the threshold, preventing
    // notifications from appearing on the first post-unlock failures.
    test('notifyAppResumed resets consecutiveFailures — threshold works correctly after unlock', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
          reconnectEnabled: false,
        );
        addTearDown(controller.dispose);

        // App goes background and accumulates many failures (counter climbs past threshold).
        controller.notifyAppPaused(hasActiveCalls: false);
        for (var i = 0; i < 10; i++) {
          module.emit(_failed());
        }
        expect(notifyCount, 0, reason: 'no notifications while backgrounded');

        // Unlock — state is reset.
        controller.notifyAppResumed();

        // First post-unlock failure: counter is 1, below threshold — no toast.
        module.emit(_failed());
        expect(notifyCount, 0, reason: 'first post-unlock failure must not notify');

        // Second post-unlock failure: counter reaches threshold — toast is correct here.
        module.emit(_failed());
        expect(notifyCount, 1);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyAppPaused(hasActiveCalls: false);
        controller.notifyForceReconnect();

        // Must fire immediately, not after kSignalingClientFastReconnectDelay.
        async.elapse(Duration.zero);
        expect(module.connectCalls, 1);
      });
    });

    test('fires connect even when network is unavailable', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyNetworkUnavailable();
        controller.notifyForceReconnect();

        // Must fire immediately, not after kSignalingClientFastReconnectDelay.
        async.elapse(Duration.zero);
        expect(module.connectCalls, 1);
      });
    });
  });

  // -------------------------------------------------------------------------
  // Force reconnect — timing
  //
  // notifyForceReconnect is called when an active call needs signaling urgently
  // (outgoing call start, incoming call answer from push). A 1-second delay
  // before reconnect makes calls placed immediately after screen unlock appear
  // to hang for ~2 s before the server receives the SDP offer.
  //
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - notifyForceReconnect timing', () {
    test('reconnects immediately (Duration.zero), not after kSignalingClientFastReconnectDelay', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyForceReconnect();

        // connect() must be scheduled for the next event-loop iteration via a
        // Duration.zero timer, not after the full kSignalingClientFastReconnectDelay = 1 s.
        expect(module.connectCalls, 0, reason: 'timer not yet fired synchronously');
        async.elapse(Duration.zero);
        expect(module.connectCalls, 1);
      });
    });

    // Full screen-unlock → immediate-call scenario.
    //
    // Reproduces the sequence from the bug log:
    //   screen lock  → signaling intentionally disconnected
    //   screen unlock → notifyAppResumed schedules 1 s reconnect timer
    //   user taps    → notifyForceReconnect must NOT reset the timer to another
    //                   full second; it must connect NOW.
    test('screen unlock → immediate call: connect fires before kSignalingClientFastReconnectDelay', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        // Screen locked — signaling disconnects intentionally (code 1000, no reconnect).
        controller.notifyAppPaused(hasActiveCalls: false);

        // Screen unlocked — schedules fast reconnect in kSignalingClientFastReconnectDelay.
        controller.notifyAppResumed();

        // User taps a recent call ~200 ms after unlock,
        // well before the notifyAppResumed timer would fire.
        async.elapse(const Duration(milliseconds: 200));
        expect(module.connectCalls, 0, reason: 'notifyAppResumed 1 s timer not yet elapsed');

        // Outgoing call started — signaling needed urgently.
        controller.notifyForceReconnect();

        // connect() must fire immediately, not after another full second.
        async.elapse(Duration.zero);
        expect(module.connectCalls, 1, reason: 'force reconnect for an outgoing call must be immediate');

        // The notifyAppResumed timer was cancelled by notifyForceReconnect;
        // no second connect() call should happen when that duration elapses.
        async.elapse(kSignalingClientFastReconnectDelay);
        expect(module.connectCalls, 1, reason: 'cancelled notifyAppResumed timer must not fire separately');
      });
    });

    // Verifies that reducing the delay to Duration.zero does NOT re-introduce
    // spurious "connection failed" toasts on transient failures.
    //
    // Toasts are suppressed by the consecutive-failure threshold (≥ 2),
    // which is independent of the reconnect delay.
    test('first connect failure after immediate reconnect does not trigger toast', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        module.isConnected = false;
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
          notifyAfterConsecutiveFailures: 2,
        );
        addTearDown(controller.dispose);

        // Screen unlock + immediate outgoing call.
        controller.notifyAppPaused(hasActiveCalls: false);
        controller.notifyAppResumed();
        controller.notifyForceReconnect();
        async.elapse(Duration.zero);
        expect(module.connectCalls, 1);

        // Transient DNS failure on the first attempt (e.g. post-unlock glitch).
        module.emit(_failed());

        // Toast must NOT appear — only 1 failure, threshold is 2.
        expect(notifyCount, 0, reason: 'spurious toast must be suppressed on first failure');
      });
    });
  });

  // -------------------------------------------------------------------------
  // Opportunistic reconnect on network restore in background
  // -------------------------------------------------------------------------

  group('SignalingReconnectController - network-restore opportunistic reconnect', () {
    // App is backgrounded with no active calls, network drops and restores
    // while a call is pending on the server. FCM push was discarded during
    // the offline window, so no notifyForceReconnect arrives. The controller
    // must still reconnect once to read Core's handshake state and surface
    // the pending call.
    test('reconnects once when network is restored in background with no active calls', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        // App goes to background, signaling disconnects intentionally.
        controller.notifyAppPaused(hasActiveCalls: false);
        expect(module.disconnectCalls, 1);

        // Network drops and restores while offline (e.g. WiFi toggle).
        controller.notifyNetworkUnavailable();
        controller.notifyNetworkAvailable();

        // Must connect after the fast-reconnect delay.
        expect(module.connectCalls, 0);
        async.elapse(kSignalingClientFastReconnectDelay);
        expect(module.connectCalls, 1);
      });
    });

    // The opportunistic reconnect is one-shot: after the first timer consumes
    // the _networkJustRestored flag, subsequent failure-driven timers must
    // respect the background-skip guard as normal. Without this guarantee the
    // fix would silently turn into persistent-mode reconnection.
    test('no duplicate connect when module is already connected at timer fire time', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        module.isConnected = true;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyAppPaused(hasActiveCalls: false);
        controller.notifyNetworkUnavailable();
        controller.notifyNetworkAvailable();

        // Timer fires: networkJustRestored=true bypasses the appActive guard,
        // but isConnected guard applies — no duplicate connect() call.
        async.elapse(kSignalingClientFastReconnectDelay);
        expect(
          module.connectCalls,
          0,
          reason: 'already connected — opportunistic reconnect must not call connect() again',
        );
      });
    });

    test('opportunistic reconnect is one-shot — subsequent failures skip in background', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
        module.isConnected = false;
        final controller = SignalingReconnectController(signalingModule: module);
        addTearDown(controller.dispose);

        controller.notifyAppPaused(hasActiveCalls: false);
        controller.notifyNetworkUnavailable();
        controller.notifyNetworkAvailable();

        // First timer: opportunistic reconnect fires.
        async.elapse(kSignalingClientFastReconnectDelay);
        expect(module.connectCalls, 1);

        // Connection attempt fails — schedules the next reconnect timer.
        module.emit(_failed(delay: kSignalingClientReconnectDelay));

        // Second timer: flag already consumed, background skip applies again.
        async.elapse(kSignalingClientReconnectDelay);
        expect(module.connectCalls, 1, reason: 'background skip must apply after opportunistic flag is consumed');
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
        int notifyCount = 0;
        final controller = SignalingReconnectController(
          signalingModule: module,
          onConnectionFailed: (_) => notifyCount++,
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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

    test('emits false immediately on SignalingDisconnected (unexpected)', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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
        addTearDown(module.dispose);
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

    test('full cycle: unavailable -> available -> unavailable', () {
      fakeAsync((async) {
        final module = _FakeSignalingModule();
        addTearDown(module.dispose);
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
