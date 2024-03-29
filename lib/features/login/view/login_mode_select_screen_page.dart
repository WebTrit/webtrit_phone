import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';

import 'login_mode_select_screen.dart';

@RoutePage()
class LoginModeSelectScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginModeSelectScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = LoginModeSelectScreen(
      appGreeting: EnvironmentConfig.APP_GREETING,
    );
    return widget;
  }
}
