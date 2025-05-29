import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';

import 'login_mode_select_screen.dart';

@RoutePage()
class LoginModeSelectScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const LoginModeSelectScreenPage();

  @override
  Widget build(BuildContext context) {
    final loginFeature = context.read<FeatureAccess>().loginFeature;

    final widget = LoginModeSelectScreen(
      appGreetingL10n: context.read<FeatureAccess>().loginFeature.titleL10n,
      launchButtons: loginFeature.launchButtons,
    );
    return widget;
  }
}
