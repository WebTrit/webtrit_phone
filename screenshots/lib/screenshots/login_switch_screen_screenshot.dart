import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

class LoginSwitchScreenScreenshot extends StatelessWidget {
  const LoginSwitchScreenScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    final signinOrder = context.watch<FeatureAccess?>()?.loginConfig.signinOrder ?? const <String>[];
    final orderedLoginTypes = sortLoginTypes(const [
      LoginType.otpSignin,
      LoginType.passwordSignin,
      LoginType.signup,
    ], orderConfig: signinOrder);

    return LoginSwitchScreen(
      appBar: AppBar(title: const Text('Sign In')),
      header: null,
      body: const Center(child: Text('Login form content')),
      currentLoginType: orderedLoginTypes.first,
      supportedLoginTypes: orderedLoginTypes,
      onLoginTypeChanged: null,
    );
  }
}
