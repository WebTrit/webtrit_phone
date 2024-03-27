import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/user_agreement/view/user_agreement_screen.dart';

@RoutePage()
class UserAgreementScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const UserAgreementScreenPage();

  @override
  Widget build(BuildContext context) {
    const appTermsAndConditionsUrl = EnvironmentConfig.APP_TERMS_AND_CONDITIONS_URL ?? '';
    const screen = UserAgreementScreen(appTermsAndConditionsUrl: appTermsAndConditionsUrl);
    return screen;
  }
}
