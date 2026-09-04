import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/backoff_retries.dart';

void main() {
  group('ExponentialBackoff', () {
    const backoff = ExponentialBackoff();
    const base = Duration(seconds: 5);

    test('doubles the base per consecutive error until the cap', () {
      expect(backoff.next(0, base), base);
      expect(backoff.next(1, base), const Duration(seconds: 10));
      expect(backoff.next(2, base), const Duration(seconds: 20));
      expect(backoff.next(3, base), const Duration(seconds: 40));
      expect(backoff.next(10, base, max: const Duration(minutes: 5)), const Duration(minutes: 5));
    });

    test('a long error streak stays capped instead of overflowing', () {
      const cap = Duration(minutes: 5);
      for (final errors in [31, 62, 63, 100]) {
        final delay = backoff.next(errors, base, max: cap);
        expect(delay.isNegative, isFalse, reason: '$errors consecutive errors must not overflow');
        expect(delay, cap, reason: '$errors consecutive errors must stay at the cap');
      }
    });
  });
}
