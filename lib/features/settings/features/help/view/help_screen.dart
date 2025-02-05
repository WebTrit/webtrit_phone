import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({
    super.key,
    required this.initialUri,
  });

  final Uri initialUri;

  @override
  Widget build(BuildContext context) {
    final widget = WebViewScaffold(
      title: Text(context.l10n.settings_ListViewTileTitle_help),
      initialUri: initialUri,
      packageInfo: context.read<PackageInfo>(),
    );
    return widget;
  }
}
