// ignore: depend_on_referenced_packages
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_phone/services/services.dart';

import '../mocks/fake_connectivity_service.dart';
import '../mocks/mock_refreshable_repository.dart';
import '../mocks/mock_suspendable_repository.dart';

void main() {
  Logger.root.level = Level.OFF;

  group('ConnectivityLifecycleService', () {
    late FakeConnectivityService connectivity;
    late ConnectivityLifecycleService service;

    setUp(() {
      connectivity = FakeConnectivityService();
    });

    tearDown(() async {
      await service.dispose();
      connectivity.dispose();
    });

    // Ensures flapping connectivity changes (online/offline/online quickly)
    // are debounced into a single stable state update.
    test('debounces flapping connectivity events', () {
      fakeAsync((async) {
        final r = MockRefreshableRepository();
        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            debounce: Duration(milliseconds: 300),
            runOnStart: false,
            jitterMaxMs: 0,
          ),
        );

        service.register(ConnectivityRecoveryRegistration.refreshable(r));

        // Rapidly flip connectivity: true, false, true within debounce window.
        connectivity.push(true);
        async.elapse(const Duration(milliseconds: 100));
        connectivity.push(false);
        async.elapse(const Duration(milliseconds: 100));
        connectivity.push(true);

        // Still within debounce window — nothing fired yet.
        expect(r.calls, 0);

        // Pass debounce threshold -> only the LAST state (true) should be applied -> refreshAll once.
        async.elapse(const Duration(milliseconds: 300));
        expect(r.calls, 1);
      });
    });

    // Verifies that when runOnStart = true, the service immediately runs
    // the appropriate action based on the initial connectivity state.
    test('runOnStart triggers initial action based on current connectivity', () {
      fakeAsync((async) {
        final r = MockRefreshableRepository();
        final s = MockSuspendableRepository();

        // Connectivity initially online.
        connectivity.push(true);

        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            runOnStart: true,
            debounce: Duration.zero, // still schedules via a zero-delay timer
            jitterMaxMs: 0,
          ),
        );

        service.register(ConnectivityRecoveryRegistration(refreshable: r, suspendable: s));

        // runOnStart uses checkConnection().then(...): flush microtasks,
        // then fire the zero-delay debounce timer.
        async.flushMicrotasks();
        async.elapse(Duration.zero);

        expect(r.calls, 1, reason: 'Should refresh immediately on start when online');
        expect(s.calls, 0);
      });
    });

    // Ensures that when onlineStabilizationDelay is set, refresh actions
    // are delayed until connectivity has remained stable for that period.
    test('onlineStabilizationDelay waits before refreshing on online', () {
      fakeAsync((async) {
        final r = MockRefreshableRepository();

        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            runOnStart: false,
            debounce: Duration(milliseconds: 1),
            onlineStabilizationDelay: Duration(seconds: 2),
            jitterMaxMs: 0,
          ),
        );

        service.register(ConnectivityRecoveryRegistration.refreshable(r));

        connectivity.push(true);
        // 1) let debounce fire
        async.elapse(const Duration(milliseconds: 2));
        // 2) allow handler to schedule the stabilization delay
        async.elapse(Duration.zero);
        // At this point stabilization has not elapsed yet
        expect(r.calls, 0);

        // After stabilization delay -> refresh should happen
        async.elapse(const Duration(seconds: 2));
        expect(r.calls, 1);
      });
    });

    // Checks that in sequential mode, listeners are executed one after another
    // and not in parallel.
    test('sequential mode runs listeners one-by-one', () {
      fakeAsync((async) {
        // Two refreshables — each takes 500ms. In sequential mode total ~1s.
        final r1 = MockRefreshableRepository(workTime: const Duration(milliseconds: 500));
        final r2 = MockRefreshableRepository(workTime: const Duration(milliseconds: 500));

        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            parallelism: Parallelism.sequential,
            debounce: Duration.zero,
            jitterMaxMs: 0,
          ),
        );

        service.register(ConnectivityRecoveryRegistration.refreshable(r1));
        service.register(ConnectivityRecoveryRegistration.refreshable(r2));

        connectivity.push(true);
        // Even with debounce=0, a zero-delay timer is used — trigger it:
        async.elapse(Duration.zero);

        // r1 starts immediately; r2 hasn't started yet.
        expect(r1.calls, 1);
        expect(r2.calls, 0);

        // After 500ms, r1 finishes and r2 starts immediately (sequential).
        async.elapse(const Duration(milliseconds: 500));
        expect(r1.calls, 1);
        expect(r2.calls, 1);

        // After another 500ms, r2 finishes; no extra calls.
        async.elapse(const Duration(milliseconds: 500));
        expect(r1.calls, 1);
        expect(r2.calls, 1);
      });
    });

    // Checks that in concurrent mode, all listeners run in parallel
    // instead of waiting for each other.
    test('concurrent mode runs listeners in parallel', () {
      fakeAsync((async) {
        // Two refreshables — each takes 500ms. In concurrent mode total ~0.5s.
        final r1 = MockRefreshableRepository(workTime: const Duration(milliseconds: 500));
        final r2 = MockRefreshableRepository(workTime: const Duration(milliseconds: 500));

        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            parallelism: Parallelism.concurrent,
            debounce: Duration.zero,
            jitterMaxMs: 0,
          ),
        );

        service.register(ConnectivityRecoveryRegistration.refreshable(r1));
        service.register(ConnectivityRecoveryRegistration.refreshable(r2));

        connectivity.push(true);
        // Fire zero-delay debounce timer:
        async.elapse(Duration.zero);

        // After 500ms both must have completed once.
        async.elapse(const Duration(milliseconds: 500));
        expect(r1.calls, 1);
        expect(r2.calls, 1);
      });
    });

    // Verifies that per-listener timeout ensures a slow or stuck listener
    // does not block others from executing.
    test('per-listener timeout prevents a slow listener from blocking others', () {
      fakeAsync((async) {
        final slow = MockRefreshableRepository(neverComplete: true);
        final fast = MockRefreshableRepository();

        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            parallelism: Parallelism.concurrent,
            perListenerTimeout: Duration(seconds: 1),
            debounce: Duration.zero,
            jitterMaxMs: 0,
          ),
        );

        service.register(ConnectivityRecoveryRegistration.refreshable(slow));
        service.register(ConnectivityRecoveryRegistration.refreshable(fast));

        connectivity.push(true);
        // Fire zero-delay debounce timer:
        async.elapse(Duration.zero);

        // After 1s timeout, fast should still complete.
        async.elapse(const Duration(seconds: 1));
        expect(fast.calls, 1);
        // slow incremented calls once (started), but future timed out
        expect(slow.calls, 1);
      });
    });

    // Ensures jitter=0 produces deterministic ordering of refresh calls
    // (important for reproducible test results).
    test('jitter=0 makes ordering deterministic in sequential mode', () {
      fakeAsync((async) {
        final order = <String>[];
        final r1 = MockRefreshableRepository(onStart: () => order.add('r1'));
        final r2 = MockRefreshableRepository(onStart: () => order.add('r2'));

        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            parallelism: Parallelism.sequential,
            debounce: Duration.zero,
            jitterMaxMs: 0, // determinism
          ),
        );

        service.register(ConnectivityRecoveryRegistration.refreshable(r1));
        service.register(ConnectivityRecoveryRegistration.refreshable(r2));

        connectivity.push(true);
        // Fire zero-delay debounce timer:
        async.elapse(Duration.zero);

        // No delays, sequential, so r1 must start before r2.
        expect(order, ['r1', 'r2']);
      });
    });

    // Ensures that the disposer returned from register() unsubscribes the listener
    // and prevents future callbacks.
    test('disposer from register() unsubscribes listener', () {
      fakeAsync((async) {
        final r = MockRefreshableRepository();

        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            debounce: Duration.zero,
            jitterMaxMs: 0,
          ),
        );

        final disposeReg = service.register(ConnectivityRecoveryRegistration.refreshable(r));

        // First online -> 1 call
        connectivity.push(true);
        async.elapse(Duration.zero);
        expect(r.calls, 1);

        // Unsubscribe
        disposeReg();

        // Flip offline->online again, should not call r anymore
        connectivity.push(false);
        async.elapse(Duration.zero);
        connectivity.push(true);
        async.elapse(Duration.zero);
        expect(r.calls, 1);
      });
    });

    // Verifies that all registered suspendable listeners are called
    // when connectivity goes offline.
    test('suspendAll is called on offline', () {
      fakeAsync((async) {
        final s1 = MockSuspendableRepository();
        final s2 = MockSuspendableRepository();

        service = ConnectivityLifecycleService(
          connectivity: connectivity,
          options: const ConnectivityLifecycleOptions(
            debounce: Duration.zero,
            jitterMaxMs: 0,
          ),
        );

        service.register(ConnectivityRecoveryRegistration.suspendable(s1));
        service.register(ConnectivityRecoveryRegistration.suspendable(s2));

        connectivity.push(false);
        // Fire zero-delay debounce timer:
        async.elapse(Duration.zero);

        expect(s1.calls, 1);
        expect(s2.calls, 1);
      });
    });

    // Ensures no events are processed after dispose(),
    // i.e., timers and subscriptions are cleaned up.
    test('ignores events after dispose', () async {
      final r = MockRefreshableRepository();

      service = ConnectivityLifecycleService(
        connectivity: connectivity,
        options: const ConnectivityLifecycleOptions(
          debounce: Duration(milliseconds: 10),
          jitterMaxMs: 0,
        ),
      );

      service.register(ConnectivityRecoveryRegistration.refreshable(r));

      // Dispose before any event is processed
      await service.dispose();

      // Push online — should be ignored completely
      connectivity.push(true);

      // Give some time in real async to ensure no stray timers fire.
      await Future<void>.delayed(const Duration(milliseconds: 20));
      expect(r.calls, 0);
    });
  });
}
