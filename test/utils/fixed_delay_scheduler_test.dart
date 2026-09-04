import 'dart:async';

import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/fixed_delay_scheduler.dart';

void main() {
  group('FixedDelayScheduler', () {
    test('runs ticks with the delay returned by the previous tick', () {
      fakeAsync((async) {
        final scheduler = FixedDelayScheduler();
        var ticks = 0;

        scheduler.start(const Duration(seconds: 1), () {
          ticks++;
          return const Duration(seconds: 5);
        });

        async.elapse(const Duration(seconds: 1));
        expect(ticks, 1);

        async.elapse(const Duration(seconds: 5));
        expect(ticks, 2);

        scheduler.cancel();
        async.elapse(const Duration(seconds: 30));
        expect(ticks, 2);
      });
    });

    test('start while a tick is scheduled does nothing', () {
      fakeAsync((async) {
        final scheduler = FixedDelayScheduler();
        var firstTicks = 0;
        var secondTicks = 0;

        scheduler.start(const Duration(seconds: 1), () {
          firstTicks++;
          return const Duration(seconds: 1);
        });
        scheduler.start(const Duration(seconds: 1), () {
          secondTicks++;
          return const Duration(seconds: 1);
        });

        async.elapse(const Duration(seconds: 3));
        expect(firstTicks, 3);
        expect(secondTicks, 0);
      });
    });

    test('restart during a running tick does not resurrect the old chain', () {
      fakeAsync((async) {
        final scheduler = FixedDelayScheduler();
        var ticks = 0;

        Future<Duration> onTick() async {
          ticks++;
          // Simulates the awaited work a real tick performs before returning
          // the next delay (e.g. a reachability probe).
          await Future.delayed(const Duration(milliseconds: 100));
          return const Duration(seconds: 10);
        }

        scheduler.start(const Duration(seconds: 10), onTick);
        async.elapse(const Duration(seconds: 10));
        expect(ticks, 1, reason: 'first tick is now mid-flight');

        // Mid-tick restart, exactly what a leading refresh does: cancel the
        // pending schedule and start a fresh loop.
        scheduler.cancel();
        scheduler.start(const Duration(seconds: 10), onTick);

        // Let the old tick finish: it must NOT reschedule its own chain on
        // top of the freshly started one.
        async.elapse(const Duration(milliseconds: 100));

        async.elapse(const Duration(seconds: 10, milliseconds: 200));
        expect(ticks, 2, reason: 'only the restarted chain may tick');

        async.elapse(const Duration(seconds: 10, milliseconds: 200));
        expect(ticks, 3, reason: 'cadence stays single, not doubled');

        scheduler.cancel();
      });
    });

    test('start during a running tick without cancel does not fork the chain', () {
      fakeAsync((async) {
        final scheduler = FixedDelayScheduler();
        var ticks = 0;
        var lateTicks = 0;

        Future<Duration> onTick() async {
          ticks++;
          await Future.delayed(const Duration(milliseconds: 100));
          return const Duration(seconds: 10);
        }

        scheduler.start(const Duration(seconds: 10), onTick);
        async.elapse(const Duration(seconds: 10));
        expect(ticks, 1, reason: 'first tick is now mid-flight');
        expect(scheduler.isScheduled, isFalse);
        expect(scheduler.isActive, isTrue, reason: 'a running tick keeps the chain active');

        // No cancel: the chain is alive, so this start must be a no-op.
        scheduler.start(const Duration(seconds: 1), () {
          lateTicks++;
          return const Duration(seconds: 1);
        });

        async.elapse(const Duration(seconds: 21));
        expect(ticks, 3, reason: 'original cadence continues');
        expect(lateTicks, 0, reason: 'the refused start must not tick');

        scheduler.cancel();
      });
    });

    test('a throwing tick releases the chain so start can re-arm', () {
      fakeAsync((async) {
        final scheduler = FixedDelayScheduler();
        var recoveredTicks = 0;
        Object? tickError;

        // The scheduler does not swallow tick errors - they stay the owner's
        // responsibility - so catch the zone error the failing tick produces.
        runZonedGuarded(() {
          scheduler.start(const Duration(seconds: 1), () {
            throw StateError('tick failed');
          });
        }, (error, _) => tickError = error);

        async.elapse(const Duration(seconds: 1));
        expect(tickError, isA<StateError>());
        expect(scheduler.isActive, isFalse, reason: 'the failed chain must release ownership');
        expect(scheduler.isScheduled, isFalse);

        scheduler.start(const Duration(seconds: 1), () {
          recoveredTicks++;
          return const Duration(seconds: 1);
        });

        async.elapse(const Duration(seconds: 2));
        expect(recoveredTicks, 2, reason: 'the scheduler must accept a new chain after a failure');

        scheduler.cancel();
      });
    });

    test('cancel during a running tick stops rescheduling', () {
      fakeAsync((async) {
        final scheduler = FixedDelayScheduler();
        var ticks = 0;

        Future<Duration> onTick() async {
          ticks++;
          await Future.delayed(const Duration(milliseconds: 100));
          return const Duration(seconds: 10);
        }

        scheduler.start(const Duration(seconds: 10), onTick);
        async.elapse(const Duration(seconds: 10));
        expect(ticks, 1);

        scheduler.cancel();
        async.elapse(const Duration(minutes: 1));
        expect(ticks, 1);
      });
    });
  });
}
