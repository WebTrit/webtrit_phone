import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginModeSelectScreenScreenshot extends StatelessWidget {
  const LoginModeSelectScreenScreenshot({
    super.key,
    this.appGreeting,
  });

  final String? appGreeting;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginModeSelectScreen(),
      child: LoginModeSelectScreen(
        appGreeting: appGreeting,
        actions: [
          LoginModeAction(
            titleL10n: 'login_ButtonTitle_signInToYourInstance',
            flavor: LoginFlavor.login,
          ),
        ],
      ),
    );
  }
}
