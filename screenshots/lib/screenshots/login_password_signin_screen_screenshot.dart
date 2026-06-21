import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';

import 'login_screenshot.dart';

class LoginPasswordSignInScreenshot extends StatelessWidget {
  const LoginPasswordSignInScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreenshot(initialLoginType: LoginType.passwordSignin);
  }
}
