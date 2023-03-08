import 'package:flutter/material.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../../../widgets/widgets.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WebViewScaffold(
      title: Text(context.l10n.settings_ListViewTileTitle_termsConditions),
      initialUri: Uri.parse(EnvironmentConfig.APP_TERMS_AND_CONDITIONS_URL),
    );
  }
}
