import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class SelfConfigScreen extends StatelessWidget {
  const SelfConfigScreen(this.url, this.userAgent, {super.key});

  final Uri url;
  final String userAgent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewContainer(
        title: Text(context.l10n.settings_ListViewTileTitle_self_config),
        userAgent: userAgent,
        initialUri: url,
      ),
    );
  }
}
