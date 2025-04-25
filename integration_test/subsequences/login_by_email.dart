import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';

Future<void> loginByEmail(PatrolIntegrationTester $, String email, String verifyCode) async {
  final emailSegmentButton = $(LoginType.signup.toLoginSegmentKey());
  final emailInput = $(signupEmailInputKey);
  final emailButton = $(signupEmailButtonKey);
  final emailVerifyInput = $(signupVerifyInputKey);
  final emailVerifyButton = $(signupVerifyButtonKey);

  if (emailSegmentButton.visible) await emailSegmentButton.tap();
  await emailInput.enterText(email);
  await emailButton.tap();
  await emailVerifyInput.enterText(verifyCode);
  await emailVerifyButton.tap();
}
