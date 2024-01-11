import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class LoginScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginScreenPage({
    @PathParam(LoginStep.pathParameterName) required this.stepPathParam,
  });

  final String stepPathParam;

  @override
  Widget build(BuildContext context) {
    final step = LoginStep.values.byName(stepPathParam);
    final widget = LoginScreen(
      step,
      appGreeting: EnvironmentConfig.APP_GREETING.isEmpty ? null : EnvironmentConfig.APP_GREETING,
    );
    final provider = BlocProvider(
      create: (context) => LoginCubit(
        step,
      ),
      child: widget,
    );
    return provider;
  }
}
