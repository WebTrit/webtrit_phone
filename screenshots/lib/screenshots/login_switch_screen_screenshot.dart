import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';

class LoginSwitchScreenScreenshot extends StatelessWidget {
  const LoginSwitchScreenScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return LoginSwitchScreen(
      appBar: AppBar(title: const Text('Sign In')),
      header: null,
      body: const Center(child: Text('Login form content')),
      currentLoginType: LoginType.otpSignin,
      supportedLoginTypes: const [
        LoginType.otpSignin,
        LoginType.passwordSignin,
        LoginType.signup,
      ],
      onLoginTypeChanged: null,
    );
  }
}
