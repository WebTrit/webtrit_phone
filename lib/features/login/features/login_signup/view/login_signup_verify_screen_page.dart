import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class LoginSignupVerifyScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginSignupVerifyScreenPage({
    required this.bodySafeAreaSides,
  });

  final Set<SafeAreaSide> bodySafeAreaSides;

  @override
  Widget build(BuildContext context) {
    final widget = LoginSignupVerifyScreen(bodySafeAreaSides: bodySafeAreaSides);
    return widget;
  }
}
