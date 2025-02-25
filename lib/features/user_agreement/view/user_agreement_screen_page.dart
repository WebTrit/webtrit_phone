import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/user_agreement/view/user_agreement_screen.dart';

@RoutePage()
class UserAgreementScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const UserAgreementScreenPage();

  @override
  Widget build(BuildContext context) {
    final appTermsAndConditionsUrl = context.read<FeatureAccess>().termsFeature.configData.resource;

    const appName = EnvironmentConfig.APP_NAME;
    final screen = UserAgreementScreen(
      appTermsAndConditionsUrl: appTermsAndConditionsUrl.toString(),
      appName: appName,
    );
    return screen;
  }
}
