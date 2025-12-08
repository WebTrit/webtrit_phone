import 'dart:ui';

// ignore: depend_on_referenced_packages
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/services/services.dart';

import '../mocks/fake_connectivity_service.dart';
import '../mocks/mock_refreshable_repository.dart';

void main() {
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
