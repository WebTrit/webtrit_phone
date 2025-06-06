import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class SelfConfigScreen extends StatelessWidget {
  const SelfConfigScreen(this.url, {super.key});

  final Uri url;

  // TODO(JohnBorys): Replace WebViewScaffold with WebViewController after testing is complete

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewScaffold(
        title: Text(context.l10n.settings_ListViewTileTitle_self_config),
        userAgent: UserAgent.of(context),
        initialUri: url,
      ),
    );
  }
}
