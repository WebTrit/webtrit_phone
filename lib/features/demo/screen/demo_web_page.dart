import 'package:flutter/widgets.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/features/demo/screen/demo_web_screen.dart';

@RoutePage()
class DemoWebPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const DemoWebPage(this.initialUri);

  final Uri initialUri;

  @override
  Widget build(BuildContext context) {
    return DemoWebScreen(initialUri: initialUri);
  }
}
