import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';
import './login_tabs.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen(
    this.step, {
    super.key,
  });

  final LoginStep step;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        step,
      ),
      child: LoginTabs(step),
    );
  }
}
