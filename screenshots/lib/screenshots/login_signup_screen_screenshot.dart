import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginSignUpScreenshot extends StatelessWidget {
  const LoginSignUpScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginSwitchScreen(),
      child: const LoginSwitchScreen(
        body: LoginSignupRequestScreen(),
        currentLoginType: LoginType.signup,
        supportedLoginTypes: [
          LoginType.otpSignin,
          LoginType.passwordSignin,
          LoginType.signup,
        ],
      ),
    );
  }
}
