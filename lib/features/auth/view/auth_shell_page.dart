import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/core_url_assign/cubit/login_core_url_assign_cubit.dart';
import '../features/mode_select/cubit/mode_select_cubit.dart';

@RoutePage()
class AuthShellPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AuthShellPage();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ModeSelectCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCoreUrlAssignCubit(),
        ),
      ],
      child: const AutoRouter(),
    );
  }
}
