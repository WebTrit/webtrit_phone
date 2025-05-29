import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';

Future<void> loginByEmail(WidgetTester tester, String email, String verifyCode) async {
  final emailSegmentButton = find.byKey(LoginType.signup.toLoginSegmentKey());
  final emailInput = find.byKey(signupEmailInputKey);
  final emailButton = find.byKey(signupEmailButtonKey);
  final emailVerifyInput = find.byKey(signupVerifyInputKey);
  final emailVerifyButton = find.byKey(signupVerifyButtonKey);

  if (emailSegmentButton.evaluate().isNotEmpty) {
    await tester.tap(emailSegmentButton, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  await tester.enterText(emailInput, email);
  await tester.pumpAndSettle();

  await tester.tap(emailButton, warnIfMissed: true);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  await tester.enterText(emailVerifyInput, verifyCode);
  await tester.pumpAndSettle();

  await tester.tap(emailVerifyButton, warnIfMissed: true);
  await tester.pumpAndSettle(const Duration(seconds: 1));
}
