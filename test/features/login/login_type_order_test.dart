import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/login/login.dart';

void main() {
  group('sortLoginTypes', () {
    test('applies the built-in default (password first) when no config', () {
      // Input in backend-ish, "unstable" order.
      final result = sortLoginTypes([LoginType.signup, LoginType.otpSignin, LoginType.passwordSignin]);

      expect(result, [LoginType.passwordSignin, LoginType.otpSignin, LoginType.signup]);
    });

    test('is stable regardless of input order', () {
      const expected = [LoginType.passwordSignin, LoginType.otpSignin];

      expect(sortLoginTypes([LoginType.otpSignin, LoginType.passwordSignin]), expected);
      expect(sortLoginTypes([LoginType.passwordSignin, LoginType.otpSignin]), expected);
    });

    test('honours an explicit env-style order', () {
      final result = sortLoginTypes(
        [LoginType.passwordSignin, LoginType.otpSignin],
        orderConfig: const ['otpSignin', 'passwordSignin'],
      );

      expect(result, [LoginType.otpSignin, LoginType.passwordSignin]);
    });

    test('ignores unknown config names and falls back to default when none valid', () {
      final result = sortLoginTypes(
        [LoginType.otpSignin, LoginType.passwordSignin],
        orderConfig: const ['nope', 'bogus'],
      );

      expect(result, [LoginType.passwordSignin, LoginType.otpSignin]);
    });

    test('keeps types missing from the config at the end, preserving relative order', () {
      final result = sortLoginTypes(
        [LoginType.signup, LoginType.otpSignin, LoginType.passwordSignin],
        orderConfig: const ['otpSignin'],
      );

      // otpSignin first (configured), then the rest in their original relative order.
      expect(result, [LoginType.otpSignin, LoginType.signup, LoginType.passwordSignin]);
    });

    test('returns empty for empty input', () {
      expect(sortLoginTypes(const []), isEmpty);
    });
  });
}
