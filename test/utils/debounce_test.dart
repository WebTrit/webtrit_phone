import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/debounce.dart';

void main() {
  const duration = Duration(seconds: 2);

  group('Debounce', () {
    test('fires callback after duration elapses', () {
      fakeAsync((async) {
        final debounce = Debounce(duration);
        var called = false;

        debounce.schedule(() => called = true);

        async.elapse(const Duration(seconds: 1));
        expect(called, isFalse);

        async.elapse(const Duration(seconds: 1));
        expect(called, isTrue);

        debounce.dispose();
      });
    });

    test('reschedules on repeated calls — only fires once', () {
      fakeAsync((async) {
        final debounce = Debounce(duration);
        var count = 0;

        debounce.schedule(() => count++);
        async.elapse(const Duration(seconds: 1));

        debounce.schedule(() => count++);
        async.elapse(const Duration(seconds: 1));

        expect(count, 0);

        async.elapse(const Duration(seconds: 1));
        expect(count, 1);

        debounce.dispose();
      });
    });

    test('cancel prevents callback from firing', () {
      fakeAsync((async) {
        final debounce = Debounce(duration);
        var called = false;

        debounce.schedule(() => called = true);
        async.elapse(const Duration(seconds: 1));

        debounce.cancel();
        async.elapse(const Duration(seconds: 2));

        expect(called, isFalse);

        debounce.dispose();
      });
    });

    test('cancel is no-op when nothing is scheduled', () {
      fakeAsync((async) {
        final debounce = Debounce(duration);
        expect(() => debounce.cancel(), returnsNormally);
        debounce.dispose();
      });
    });

    test('dispose cancels pending callback', () {
      fakeAsync((async) {
        final debounce = Debounce(duration);
        var called = false;

        debounce.schedule(() => called = true);
        debounce.dispose();

        async.elapse(const Duration(seconds: 3));
        expect(called, isFalse);
      });
    });

    test('can schedule again after cancel', () {
      fakeAsync((async) {
        final debounce = Debounce(duration);
        var count = 0;

        debounce.schedule(() => count++);
        debounce.cancel();

        debounce.schedule(() => count++);
        async.elapse(const Duration(seconds: 2));

        expect(count, 1);

        debounce.dispose();
      });
    });
  });
}
