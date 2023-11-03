import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class AuthModeSelectScreenScreenshot extends StatelessWidget {
  const AuthModeSelectScreenScreenshot({
    super.key,
    this.appGreeting,
  });

  final String? appGreeting;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ModeSelectCubit>(
      create: (context) => MockAuthModeSelectCubit.loginScreen(),
      child: ModeSelectScreen(
        appGreeting: appGreeting,
      ),
    );
  }
}
