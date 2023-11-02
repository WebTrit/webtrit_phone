import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/auth/auth.dart';

class AuthShell extends StatelessWidget {
  const AuthShell({
    super.key,
    required this.appPreferences,
    required this.child,
  });

  final AppPreferences appPreferences;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          lazy: false,
          create: (context) {
            return AuthCubit(appPreferences: appPreferences);
          },
        ),
      ],
      child: child,
    );
  }
}
