import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_api/webtrit_api.dart';

import 'package:screenshots/mocks/mocks.dart';

class AuthTypesScreenshot extends StatelessWidget {
  const AuthTypesScreenshot({
    super.key,
    required this.selected,
  });

  final SupportedLoginType selected;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginTypesCubit>(
          create: (context) => MockAuthTypesCubit.loginScreen(),
        ),
        BlocProvider<OtpRequestCubit>(
          create: (context) => MockAuthOtpRequestCubit.loginScreen(),
        ),
        BlocProvider<PasswordRequestCubit>(
          create: (context) => MockAuthPasswordRequestCubit.loginScreen(),
        )
      ],
      child: LoginTypesScreen(
        selected: selected,
        // child: OtpRequestScreen(),
        child: Builder(
          builder: (context) {
            switch (selected) {
              case SupportedLoginType.otpSignIn:
                return const OtpRequestScreen();
              case SupportedLoginType.passwordSignIn:
                return const PasswordRequestScreen();
            }
          },
        ),
      ),
    );
  }
}
