import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class LoginCoreUrlAssignScreenScreenshot extends StatelessWidget {
  const LoginCoreUrlAssignScreenScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => MockLoginCubit.loginCoreUrlAssignScreen(),
      child: const LoginCoreUrlAssignScreenPage(),
    );
  }
}
