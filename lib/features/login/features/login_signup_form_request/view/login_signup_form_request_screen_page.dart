import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/constants.dart';

import 'login_signup_form_request_screen.dart';

@RoutePage()
class LoginSignupFormRequestScreenPage extends StatelessWidget {
  static const initialUriQueryParamName = 'initialUrl';

  // ignore: use_key_in_widget_constructors
  const LoginSignupFormRequestScreenPage({
    @QueryParam(initialUriQueryParamName) this.initialUriQueryParam,
  });

  final String? initialUriQueryParam;

  @override
  Widget build(BuildContext context) {
    final widget = LoginSignupFormRequestScreenScreen(
      initialUri: Uri.parse(initialUriQueryParam ?? kBlankUri),
    );
    return widget;
  }
}
