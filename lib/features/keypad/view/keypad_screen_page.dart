import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class KeypadScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const KeypadScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = KeypadScreen(
      title: Text(EnvironmentConfig.APP_NAME),
    );
    final provider = BlocProvider(
      create: (context) => KeypadCubit(),
      child: widget,
    );
    return provider;
  }
}
