import 'package:flutter/material.dart';

import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../../../widgets/widgets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebViewScaffold(
      title: Text(context.l10n.settings_ListViewTileTitle_help),
      initialUri: Uri.parse(EnvironmentConfig.APP_HELP_URL),
    );
  }
}
