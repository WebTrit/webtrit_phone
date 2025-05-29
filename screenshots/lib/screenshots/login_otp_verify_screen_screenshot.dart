import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/app/constants.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginOtpVerifyInScreenshot extends StatelessWidget {
  const LoginOtpVerifyInScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginSwitchScreen(),
      child: LoginSwitchScreen(
        appBar: AppBar(
          leading: const ExtBackButton(disabled: false),
          backgroundColor: Colors.transparent,
        ),
        header: const Column(
          children: [
            OnboardingLogo(),
            SizedBox(height: kInset),
          ],
        ),
        body: LoginOtpSigninVerifyScreen(),
        currentLoginType: LoginType.otpSignin,
        supportedLoginTypes: [
          LoginType.otpSignin,
          LoginType.passwordSignin,
          LoginType.signup,
        ],
      ),
    );
  }
}
