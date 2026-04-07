import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/features.dart';

Future<void> loginByOtp(PatrolIntegrationTester $, String otpCredential, String otpVerifyCredential) async {
  final otpSegmentButton = $(LoginType.otpSignin.toLoginSegmentKey());
  final otpInput = $(optInputKey);
  final otpButton = $(otpButtonKey);
  final otpVerifyInput = $(otpVerifyInputKey);
  final otpVerifyButton = $(otpVerifyButtonKey);

  if (otpSegmentButton.visible) await otpSegmentButton.tap();
  await otpInput.enterText(otpCredential);
  await otpButton.tap();
  await otpVerifyInput.enterText(otpVerifyCredential);
  await otpVerifyButton.tap();
}
