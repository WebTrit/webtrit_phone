import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class RecentsScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const RecentsScreenPage();

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    final widget = RecentsScreen(
      title: const Text(EnvironmentConfig.APP_NAME),
      videoCallEnable: featureAccess.callFeature.callConfig.isVideoCallEnabled,
      chatsEnabled: featureAccess.messagingFeature.chatsPresent,
    );
    return widget;
  }
}
