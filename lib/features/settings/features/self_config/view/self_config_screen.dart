import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class SelfConfigScreen extends StatelessWidget {
  const SelfConfigScreen(this.url, {super.key});

  final Uri url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewScaffold(
        title: Text(context.l10n.settings_ListViewTileTitle_self_config),
        packageInfo: context.read<PackageInfo>(),
        initialUri: url,
      ),
    );
  }
}
