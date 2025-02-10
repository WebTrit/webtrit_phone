import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginModeSelectScreenScreenshot extends StatelessWidget {
  const LoginModeSelectScreenScreenshot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print('LoginModeSelectScreenScreenshot: ${ context.read<FeatureAccess?>()?.loginFeature.titleL10n}');
    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginModeSelectScreen(),
      child: LoginModeSelectScreen(
        appGreetingL10n: context.read<FeatureAccess?>()?.loginFeature.titleL10n,
      ),
    );
  }
}
