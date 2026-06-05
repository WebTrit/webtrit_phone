import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';

import 'login_screenshot.dart';

class LoginSignUpScreenshot extends StatelessWidget {
  const LoginSignUpScreenshot({
    super.key,
    this.supportedLoginTypes = const [LoginType.otpSignin, LoginType.passwordSignin, LoginType.signup],
  });

  final List<LoginType> supportedLoginTypes;

  @override
  Widget build(BuildContext context) {
    return LoginScreenshot(initialLoginType: LoginType.signup, supportedLoginTypes: supportedLoginTypes);
  }
}
