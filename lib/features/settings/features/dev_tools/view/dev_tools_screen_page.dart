import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'dev_tools_screen.dart';

@RoutePage()
class DevToolsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DevToolsScreenPage();

  @override
  Widget build(BuildContext context) {
    return const DevToolsScreen();
  }
}
