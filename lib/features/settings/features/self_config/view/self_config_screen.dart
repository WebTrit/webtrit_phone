import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class SelfConfigScreen extends StatelessWidget {
  const SelfConfigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse('https://google.com');
    return Scaffold(
      body: WebViewScaffold(
        title: Text(context.l10n.settings_ListViewTileTitle_self_config),
        initialUri: uri,
      ),
    );
  }
}
