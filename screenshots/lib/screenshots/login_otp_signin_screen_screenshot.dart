import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';

import 'login_screenshot.dart';

class LoginOtpSignInScreenshot extends StatelessWidget {
  const LoginOtpSignInScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreenshot(initialLoginType: LoginType.otpSignin);
  }
}
