import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginScreenScreenshot extends StatelessWidget {
  const LoginScreenScreenshot(
    this.step, {
    super.key,
    this.appGreeting,
  });

  final LoginStep step;

  final String? appGreeting;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginScreen(step),
      child: LoginScreen(
        step,
        appGreeting: appGreeting,
      ),
    );
  }
}
