// ignore: depend_on_referenced_packages
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
