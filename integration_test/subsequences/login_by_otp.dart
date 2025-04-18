import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';

Future<void> loginByOtp(WidgetTester tester, String otpCredential, String otpVerifyCredential) async {
  final otpSegmentButton = find.byKey(LoginType.otpSignin.toLoginSegmentKey());
  final otpInput = find.byKey(optInputKey);
  final otpButton = find.byKey(otpButtonKey);
  final otpVerifyInput = find.byKey(otpVerifyInputKey);
  final otpVerifyButton = find.byKey(otpVerifyButtonKey);

  if (otpSegmentButton.evaluate().isNotEmpty) {
    await tester.tap(otpSegmentButton, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  await tester.enterText(otpInput, otpCredential);
  await tester.pumpAndSettle();

  await tester.tap(otpButton, warnIfMissed: true);
  await tester.pumpAndSettle();

  await tester.enterText(otpVerifyInput, otpVerifyCredential);
  await tester.pumpAndSettle();

  await tester.tap(otpVerifyButton, warnIfMissed: true);
  await tester.pumpAndSettle();
}
