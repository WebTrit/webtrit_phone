import 'dart:ui';

// ignore: depend_on_referenced_packages
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/services/services.dart';

import '../mocks/fake_connectivity_service.dart';
import '../mocks/mock_refreshable_repository.dart';

void main() {
  // PollingService registers itself as a WidgetsBindingObserver on
  // construction, which needs a live binding even in plain tests.
  TestWidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.OFF;

  group('PollingService', () {
    late FakeConnectivityService connectivity;
    late PollingService service;

    setUp(() {
      connectivity = FakeConnectivityService();
    });

    tearDown(() async {
      await service.dispose();
      connectivity.dispose();
    });

    // Ensures a leading refresh is executed immediately on startup
    // when the app is already connected to the network.
    test('leading refresh on boot when already connected', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 10))],
          options: const PollingOptions(
            leadingRefreshRequiresVerify: true,
            verifyReachabilityOnTick: true,
            reachabilityTtl: Duration(seconds: 30),
          ),
        );

        async.flushMicrotasks();

        expect(task.callCount, 1, reason: 'Leading refresh should execute at startup');
      });
    });

    // Verifies that refresh is triggered periodically while
    // the network connectivity remains true.
    test('periodic refresh ticks with connectivity true', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 5))],
        );

        async.flushMicrotasks();
        expect(task.callCount, 1);

        async.elapse(const Duration(seconds: 5, milliseconds: 600));
        expect(task.callCount, 2);

        async.elapse(const Duration(seconds: 5, milliseconds: 600));
        expect(task.callCount, 3);
      });
    });

    // Confirms that polling pauses when app goes to background
    // and resumes (with a leading refresh) when the app is resumed.
    test('pauses in background and resumes with leading refresh', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 5))],
          options: const PollingOptions(pauseInBackground: true),
        );

        async.flushMicrotasks();
        expect(task.callCount, 1);

        service.didChangeAppLifecycleState(AppLifecycleState.paused);
        async.elapse(const Duration(seconds: 10));
        expect(task.callCount, 1, reason: 'No refreshes should happen while in background');

        service.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        expect(task.callCount, 2, reason: 'Leading refresh should happen on resume');

        async.elapse(const Duration(seconds: 5, milliseconds: 600));
        expect(task.callCount, 3);
      });
    });

    // Regression: a connectivity event that arrives while the boot probe is
    // still in flight must not lead to a doubled leading cycle.
    test('connectivity event during the boot probe yields one leading cycle', () {
      fakeAsync((async) {
        connectivity = FakeConnectivityService(initialConnected: true)..nextCheckDelay = const Duration(seconds: 1);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 10))],
          options: const PollingOptions(jitterMaxMs: 0),
        );

        async.flushMicrotasks();
        expect(task.callCount, 0, reason: 'boot probe is still in flight');

        // The OS reports connectivity before the probe resolves.
        connectivity.setConnected(true);
        async.flushMicrotasks();
        expect(task.callCount, 1, reason: 'the connectivity event runs the leading cycle');

        // The probe resolves late with the same state: no second cycle.
        async.elapse(const Duration(seconds: 1));
        expect(task.callCount, 1, reason: 'the late boot probe must not repeat the leading cycle');

        async.elapse(const Duration(seconds: 10, milliseconds: 100));
        expect(task.callCount, 2, reason: 'periodic polling continues normally');
      });
    });

    // Regression: an offline event during the boot probe stops polling and a
    // probe resolving with the same offline state must not bring it up.
    test('offline event during the boot probe keeps polling off', () {
      fakeAsync((async) {
        connectivity = FakeConnectivityService(initialConnected: true)..nextCheckDelay = const Duration(seconds: 1);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 10))],
          options: const PollingOptions(jitterMaxMs: 0),
        );

        async.flushMicrotasks();

        // The device goes offline while the probe is still in flight.
        connectivity.setConnected(false);
        async.flushMicrotasks();
        expect(task.callCount, 0);

        async.elapse(const Duration(minutes: 2));
        expect(task.callCount, 0, reason: 'polling must not start while offline');
        expect(connectivity.checkCalls, 1, reason: 'no timers means no further reachability checks');
      });
    });

    // Regression: a transiently wrong offline event during the boot probe
    // must not permanently disable polling - the probe that completes later
    // carries fresher evidence and must win.
    test('boot probe completing after a false offline event restores polling', () {
      fakeAsync((async) {
        connectivity = FakeConnectivityService(initialConnected: true)..nextCheckDelay = const Duration(seconds: 1);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 10))],
          options: const PollingOptions(jitterMaxMs: 0),
        );

        async.flushMicrotasks();

        // A transport handoff pushes a wrong offline event while the network
        // is actually fine and the boot probe is still in flight.
        connectivity.emitConnectivityEvent(false);
        async.flushMicrotasks();
        expect(task.callCount, 0);

        // The boot probe completes and reports the network is up.
        async.elapse(const Duration(seconds: 1));
        expect(task.callCount, 1, reason: 'the completed probe must restore polling');

        async.elapse(const Duration(seconds: 10, milliseconds: 100));
        expect(task.callCount, 2, reason: 'periodic polling runs after recovery');
      });
    });

    // Regression: a repeated same-state connectivity event (typical duplicate
    // OS callback) must not run another leading cycle.
    test('duplicate online event after boot does not repeat the leading cycle', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 10))],
          options: const PollingOptions(jitterMaxMs: 0),
        );

        async.flushMicrotasks();
        expect(task.callCount, 1);

        connectivity.emitConnectivityEvent(true);
        async.flushMicrotasks();
        expect(task.callCount, 1, reason: 'a same-state event must not trigger another refresh');

        async.elapse(const Duration(seconds: 10, milliseconds: 100));
        expect(task.callCount, 2, reason: 'periodic cadence is unaffected');
      });
    });

    // Regression: a reachability probe that resolves after the connectivity
    // state changed must not overwrite the fresher cached value.
    test('stale reachability probe does not poison the TTL cache', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 10))],
          options: const PollingOptions(jitterMaxMs: 0, reachabilityTtl: Duration(seconds: 15)),
        );

        async.flushMicrotasks();
        expect(task.callCount, 1);

        // The tick at ~20s finds the cache expired and has to probe; make
        // that probe slow and stale: it will report offline from a dying link.
        async.elapse(const Duration(seconds: 15));
        connectivity.nextCheckDelay = const Duration(seconds: 2);
        connectivity.nextCheckResult = false;
        async.elapse(const Duration(seconds: 5, milliseconds: 100));
        final callsBeforeFlap = task.callCount;

        // While that probe is in flight the network flaps down and up.
        connectivity.setConnected(false);
        async.flushMicrotasks();
        connectivity.setConnected(true);
        async.flushMicrotasks();
        expect(task.callCount, callsBeforeFlap + 1, reason: 'the reconnect leading cycle refreshes');

        // The stale probe resolves with false: it must not overwrite the
        // fresh online state, so the next tick still refreshes from cache.
        async.elapse(const Duration(seconds: 12));
        expect(
          task.callCount,
          callsBeforeFlap + 2,
          reason: 'the tick after the flap must refresh from the fresh cache, not the stale probe result',
        );
      });
    });

    // Regression: backgrounding while a refresh is still in flight must not
    // let the resume leading cycle start an overlapping refresh of the same
    // listener.
    test('resume during an in-flight refresh does not overlap it', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository(workTime: const Duration(seconds: 5));
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 10))],
          options: const PollingOptions(jitterMaxMs: 0),
        );

        async.flushMicrotasks();
        expect(task.callCount, 1, reason: 'leading refresh starts and stays in flight');

        async.elapse(const Duration(seconds: 1));
        service.didChangeAppLifecycleState(AppLifecycleState.paused);
        service.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        expect(task.callCount, 1, reason: 'the in-flight refresh must not be overlapped on resume');

        async.elapse(const Duration(seconds: 30));
        expect(task.callCount, greaterThanOrEqualTo(2), reason: 'polling continues after the refresh completes');
      });
    });

    // Ensures that checkConnection() calls are cached during the TTL period
    // and only re-executed after the TTL expires.
    test('reachability TTL caches checkConnection calls', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 3))],
          options: const PollingOptions(
            verifyReachabilityOnTick: true,
            reachabilityTtl: Duration(seconds: 10),
            jitterMaxMs: 0,
          ),
        );

        async.flushMicrotasks();
        final initialCalls = connectivity.checkCalls;
        expect(task.callCount, 1);

        async.elapse(const Duration(seconds: 9));
        expect(task.callCount, greaterThanOrEqualTo(2));
        expect(connectivity.checkCalls, initialCalls, reason: 'Within TTL no new checkConnection() calls expected');

        async.elapse(const Duration(seconds: 3, milliseconds: 1));
        expect(
          connectivity.checkCalls,
          greaterThan(initialCalls),
          reason: 'After TTL expiry a new checkConnection() should occur',
        );
      });
    });

    // Validates that re-registering a listener with a new interval
    // updates the schedule and uses the new cadence.
    test('interval change restarts scheduling with new cadence', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 8))],
        );

        async.flushMicrotasks();
        expect(task.callCount, 1);

        service.register(PollingRegistration(listener: task, interval: const Duration(seconds: 3)));

        async.elapse(const Duration(seconds: 3, milliseconds: 600));
        expect(task.callCount, 2);

        async.elapse(const Duration(seconds: 3, milliseconds: 600));
        expect(task.callCount, 3);
      });
    });

    // Ensures exponential backoff kicks in after consecutive refresh failures,
    // increasing delay before retries and resetting after success.
    test('exponential backoff on consecutive errors', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository()..failTimes = 2;
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 1))],
          options: const PollingOptions(jitterMaxMs: 0),
        );

        async.flushMicrotasks();
        expect(task.callCount, 1);

        async.elapse(const Duration(seconds: 2, milliseconds: 1));
        expect(task.callCount, 2, reason: 'Second call after 2s backoff');

        async.elapse(const Duration(seconds: 4, milliseconds: 1));
        expect(task.callCount, 3, reason: 'Third call after 4s backoff');
      });
    });

    // Verifies that when a listener becomes inactive (isActive = false) it is
    // automatically unregistered on the next polling tick and never called again.
    test('listener becoming inactive is unregistered on next tick', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 5))],
          options: const PollingOptions(jitterMaxMs: 0),
        );

        async.flushMicrotasks();
        expect(task.callCount, 1, reason: 'Leading refresh on boot');

        // Listener becomes inactive after the leading call.
        task.active = false;

        // Next tick — isActive check unregisters the listener, no refresh call.
        async.elapse(const Duration(seconds: 5, milliseconds: 600));
        expect(task.callCount, 1, reason: 'No more calls after listener became inactive');

        // Further ticks — still no calls and no crash.
        async.elapse(const Duration(seconds: 10));
        expect(task.callCount, 1);
      });
    });

    // Verifies that an inactive listener is also skipped during the leading
    // refresh triggered on reconnect or app resume.
    test('inactive listener is skipped on leading refresh (resume/reconnect)', () {
      fakeAsync((async) {
        connectivity.setConnected(true);

        final task = MockRefreshableRepository();
        service = PollingService(
          connectivityService: connectivity,
          registrations: [PollingRegistration(listener: task, interval: const Duration(seconds: 60))],
          options: const PollingOptions(pauseInBackground: true, jitterMaxMs: 0),
        );

        async.flushMicrotasks();
        expect(task.callCount, 1);

        task.active = false;

        // Resume triggers a leading refresh — inactive listener must be skipped.
        service.didChangeAppLifecycleState(AppLifecycleState.paused);
        service.didChangeAppLifecycleState(AppLifecycleState.resumed);
        async.flushMicrotasks();
        expect(task.callCount, 1, reason: 'Inactive listener not refreshed on resume');
      });
    });

    // Confirms that after service.dispose() is called, all timers are canceled
    // and no further refresh calls are executed.
    test('dispose cancels timers — no further refresh calls', () async {
      connectivity.setConnected(true);

      final task = MockRefreshableRepository();
      service = PollingService(
        connectivityService: connectivity,
        registrations: [PollingRegistration(listener: task, interval: const Duration(milliseconds: 200))],
      );

      await Future<void>.delayed(const Duration(milliseconds: 50));
      await service.dispose();

      final prev = task.callCount;

      await Future<void>.delayed(const Duration(milliseconds: 500));
      expect(task.callCount, prev, reason: 'No additional refreshes should occur after dispose');
    });
  });
}
