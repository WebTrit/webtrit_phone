import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class RecentsTabPage extends AutoRouter {
  const RecentsTabPage({super.key});
}

@RoutePage()
class RecentsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RecentsScreenPage();

  @override
  Widget build(BuildContext context) {
    const widget = RecentsScreen(
      title: Text(EnvironmentConfig.APP_NAME),
    );
    return widget;
  }
}
