import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class ChatsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ChatsScreenPage();

  @override
  Widget build(BuildContext context) {
    return const ChatsScreen(
      title: Text(EnvironmentConfig.APP_NAME),
    );
  }
}
