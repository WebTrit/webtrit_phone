import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class CallScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CallScreenPage();

  @override
  Widget build(BuildContext context) {
    final widget = CallScreen(
      config: CallActiveConfig(enableTransfer: EnvironmentConfig.ENABLE_ATTENDED_TRANSFER),
    );
    return widget;
  }
}
