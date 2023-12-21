import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';

import 'package:screenshots/mocks/mocks.dart';

class AuthCoreUrlAssignScreenScreenshot extends StatelessWidget {
  const AuthCoreUrlAssignScreenScreenshot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCoreUrlAssignCubit>(
      create: (context) => MockAuthCoreUrlAssignCubit.loginScreen(),
      child: const LoginCoreUrlAssignScreen(),
    );
  }
}
