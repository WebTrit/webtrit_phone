import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class AutoprovisionScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AutoprovisionScreenPage({@QueryParam('config_token') this.configToken});
  final String? configToken;

  @override
  Widget build(BuildContext context) {
    // Explicitly cast to string,
    // coz value are verified by the router guard [onAutoprovisionScreenPageRouteGuardNavigation]
    String configToken = this.configToken!;

    final widget = AutoprovisionScreen(configToken: configToken);
    return widget;
  }
}
