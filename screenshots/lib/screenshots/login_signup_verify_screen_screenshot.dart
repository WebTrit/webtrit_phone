import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginSignUpVerifyScreenshot extends StatelessWidget {
  const LoginSignUpVerifyScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginSwitchScreen(),
      child: LoginSwitchScreen(
        appBar: AppBar(
          leading: const ExtBackButton(disabled: false),
          backgroundColor: Colors.transparent,
        ),
        body: LoginSignupVerifyScreen(),
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
