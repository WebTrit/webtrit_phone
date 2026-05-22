import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/transient_debouncer.dart';

void main() {
  const duration = Duration(seconds: 2);

  // Simple enum-like values for testing
  const transientA = 'transientA';
  const transientB = 'transientB';
  const stable = 'stable';

  bool isTransient(String s) => s.startsWith('transient');

  TransientDebouncer<String> make(String initial, {String? latest}) => TransientDebouncer<String>(
    initial: initial,
    duration: duration,
    isTransient: isTransient,
    getLatest: () => latest ?? initial,
  );

  group('TransientDebouncer', () {
    test('non-transient → non-transient emits immediately', () {
      fakeAsync((async) {
        var updateCount = 0;
        final d = make(stable);

        d.update('stable2', () => updateCount++);

        expect(d.displayed, 'stable2');
        expect(updateCount, 1);

        d.dispose();
      });
    });

    test('non-transient → transient emits immediately', () {
      fakeAsync((async) {
        var updateCount = 0;
        final d = make(stable);

        d.update(transientA, () => updateCount++);

        expect(d.displayed, transientA);
        expect(updateCount, 1);

        d.dispose();
      });
    });

    test('transient → non-transient emits immediately and cancels any pending timer', () {
      fakeAsync((async) {
        var updateCount = 0;
        String? latestValue = transientA;
        final d = TransientDebouncer<String>(
          initial: transientA,
          duration: duration,
          isTransient: isTransient,
          getLatest: () => latestValue!,
        );

        // Schedule a debounced update within transient zone
        latestValue = transientB;
        d.update(transientB, () => updateCount++);
        expect(d.displayed, transientA); // still debounced

        // Now transition to non-transient — should cancel pending timer and emit immediately
        latestValue = stable;
        d.update(stable, () => updateCount++);
        expect(d.displayed, stable);
        expect(updateCount, 1);

        // Timer that was scheduled should NOT fire
        async.elapse(const Duration(seconds: 3));
        expect(d.displayed, stable);
        expect(updateCount, 1);

        d.dispose();
      });
    });

    test('transient → transient debounces and shows getLatest() on fire', () {
      fakeAsync((async) {
        var updateCount = 0;
        String latestValue = transientA;
        final d = TransientDebouncer<String>(
          initial: transientA,
          duration: duration,
          isTransient: isTransient,
          getLatest: () => latestValue,
        );

        latestValue = transientB;
        d.update(transientB, () => updateCount++);

        expect(d.displayed, transientA); // not yet emitted
        expect(updateCount, 0);

        async.elapse(const Duration(seconds: 2));

        expect(d.displayed, transientB); // getLatest() result
        expect(updateCount, 1);

        d.dispose();
      });
    });

    test('same pending value does not re-schedule the timer', () {
      fakeAsync((async) {
        var updateCount = 0;
        final d = TransientDebouncer<String>(
          initial: transientA,
          duration: duration,
          isTransient: isTransient,
          getLatest: () => transientB,
        );

        d.update(transientB, () => updateCount++);
        async.elapse(const Duration(seconds: 1));

        // Same value again — should be a no-op
        d.update(transientB, () => updateCount++);
        async.elapse(const Duration(seconds: 1));

        // Timer from first call fires now (2 s total from first schedule)
        expect(d.displayed, transientB);
        expect(updateCount, 1);

        d.dispose();
      });
    });

    test('same displayed value does not schedule a timer', () {
      fakeAsync((async) {
        var updateCount = 0;
        final d = make(transientA);

        d.update(transientA, () => updateCount++);

        expect(updateCount, 0);
        async.elapse(const Duration(seconds: 3));
        expect(updateCount, 0);

        d.dispose();
      });
    });

    test('dispose cancels pending debounced update', () {
      fakeAsync((async) {
        var updateCount = 0;
        final d = make(transientA, latest: transientB);

        d.update(transientB, () => updateCount++);
        d.dispose();

        async.elapse(const Duration(seconds: 3));
        expect(updateCount, 0);
      });
    });

    test('rapid transient oscillation — only fires once after quiet window', () {
      fakeAsync((async) {
        var updateCount = 0;
        String latestValue = transientA;
        final d = TransientDebouncer<String>(
          initial: transientA,
          duration: duration,
          isTransient: isTransient,
          getLatest: () => latestValue,
        );

        for (var i = 0; i < 5; i++) {
          latestValue = 'transient$i';
          d.update('transient$i', () => updateCount++);
          async.elapse(const Duration(milliseconds: 500));
        }

        expect(updateCount, 0);

        async.elapse(const Duration(seconds: 2));
        expect(updateCount, 1);
        expect(d.displayed, 'transient4');

        d.dispose();
      });
    });
  });
}
