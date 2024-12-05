import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';

import 'call_to_actions_web_screen.dart';

@RoutePage()
class CallToActionsWebPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CallToActionsWebPage(this.initialUrl);

  final Uri initialUrl;

  @override
  Widget build(BuildContext context) {
    return CallToActionsWebScreen(initialUrl: initialUrl);
  }
}
