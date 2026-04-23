import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/debounce_map.dart';

void main() {
  const duration = Duration(seconds: 2);

  group('DebounceMap', () {
    test('fires callback after duration elapses', () {
      fakeAsync((async) {
        final map = DebounceMap<String>(duration);
        var called = false;

        map.schedule('a', () => called = true);

        async.elapse(const Duration(seconds: 1));
        expect(called, isFalse);

        async.elapse(const Duration(seconds: 1));
        expect(called, isTrue);

        map.dispose();
      });
    });

    test('reschedules on repeated calls — only fires once', () {
      fakeAsync((async) {
        final map = DebounceMap<String>(duration);
        var count = 0;

        map.schedule('a', () => count++);
        async.elapse(const Duration(seconds: 1));

        map.schedule('a', () => count++);
        async.elapse(const Duration(seconds: 1));

        // first timer was cancelled, second not yet done
        expect(count, 0);

        async.elapse(const Duration(seconds: 1));
        expect(count, 1);

        map.dispose();
      });
    });

    test('independent keys fire independently', () {
      fakeAsync((async) {
        final map = DebounceMap<String>(duration);
        var aFired = false;
        var bFired = false;

        map.schedule('a', () => aFired = true);
        async.elapse(const Duration(seconds: 1));

        map.schedule('b', () => bFired = true);
        async.elapse(const Duration(seconds: 1));

        expect(aFired, isTrue);
        expect(bFired, isFalse);

        async.elapse(const Duration(seconds: 1));
        expect(bFired, isTrue);

        map.dispose();
      });
    });

    test('cancel prevents callback from firing', () {
      fakeAsync((async) {
        final map = DebounceMap<String>(duration);
        var called = false;

        map.schedule('a', () => called = true);
        async.elapse(const Duration(seconds: 1));

        map.cancel('a');
        async.elapse(const Duration(seconds: 2));

        expect(called, isFalse);

        map.dispose();
      });
    });

    test('cancel on unknown key is a no-op', () {
      fakeAsync((async) {
        final map = DebounceMap<String>(duration);
        expect(() => map.cancel('nonexistent'), returnsNormally);
        map.dispose();
      });
    });

    test('dispose cancels all pending callbacks', () {
      fakeAsync((async) {
        final map = DebounceMap<String>(duration);
        var aFired = false;
        var bFired = false;

        map.schedule('a', () => aFired = true);
        map.schedule('b', () => bFired = true);

        map.dispose();

        async.elapse(const Duration(seconds: 3));

        expect(aFired, isFalse);
        expect(bFired, isFalse);
      });
    });

    test('can schedule again after dispose', () {
      fakeAsync((async) {
        final map = DebounceMap<String>(duration);
        var called = false;

        map.schedule('a', () {});
        map.dispose();

        map.schedule('a', () => called = true);
        async.elapse(const Duration(seconds: 2));

        expect(called, isTrue);

        map.dispose();
      });
    });

    test('works with integer keys', () {
      fakeAsync((async) {
        final map = DebounceMap<int>(duration);
        var called = false;

        map.schedule(42, () => called = true);
        async.elapse(const Duration(seconds: 2));

        expect(called, isTrue);

        map.dispose();
      });
    });
  });
}
