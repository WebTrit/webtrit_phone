import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class CallScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CallScreenPage();

  @override
  Widget build(BuildContext context) {
    final featureAccess = context.read<FeatureAccess>();

    final widget = CallScreen(
      transferConfig: featureAccess.callFeature.transfer,
    );
    return widget;
  }
}
