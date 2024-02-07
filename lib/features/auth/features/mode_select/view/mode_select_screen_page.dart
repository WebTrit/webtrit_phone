import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';

import 'mode_select_screen.dart';

@RoutePage()
class ModeSelectScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ModeSelectScreenPage();

  @override
  Widget build(BuildContext context) {
    return const ModeSelectScreen(
      appGreeting: EnvironmentConfig.APP_GREETING,
    );
  }
}
