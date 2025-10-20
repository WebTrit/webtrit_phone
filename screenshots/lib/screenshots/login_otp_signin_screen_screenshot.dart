import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/widgets/widgets.dart';
import 'package:webtrit_phone/app/constants.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginOtpSignInScreenshot extends StatelessWidget {
  const LoginOtpSignInScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final LoginSwitchScreenStyles? loginPageStyles = themeData.extension<LoginSwitchScreenStyles>();
    final LoginSwitchScreenStyle? localStyle = loginPageStyles?.primary;

    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginSwitchScreen(),
      child: LoginSwitchScreen(
        appBar: AppBar(
          leading: const ExtBackButton(disabled: false),
          backgroundColor: Colors.transparent,
        ),
        header: Column(
          children: [
            OnboardingLogo(style: localStyle?.onboardingLogoStyle),
            SizedBox(height: kInset),
          ],
        ),
        body: LoginOtpSigninRequestScreen(),
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
