import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/models/models.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginSignUpScreenshot extends StatelessWidget {
  const LoginSignUpScreenshot({
    super.key,
    this.supportedLoginTypes = const [
      LoginType.otpSignin,
      LoginType.passwordSignin,
      LoginType.signup,
    ],
  });

  final List<LoginType> supportedLoginTypes;

  @override
  Widget build(BuildContext context) {
    final sections = context
        .watch<FeatureAccess?>()
        ?.loginFeature
        .actions
        .firstWhereOrNull((element) => element.flavor == LoginFlavor.embedded);

    final embedded = sections as LoginEmbeddedModeButton?;

    if (embedded == null) {
      return const Center(
        child: Text('Embedded page not set up'),
      );
    }

    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginSwitchScreen(embedded: embedded.customLoginFeature),
      child: LoginSwitchScreen(
        body: LoginSignupEmbeddedRequestScreen(
          initialUrl: embedded.customLoginFeature.resource,
        ),
        currentLoginType: LoginType.signup,
        supportedLoginTypes: supportedLoginTypes,
      ),
    );
  }
}
