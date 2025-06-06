import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({
    super.key,
    required this.initialUri,
  });

  final Uri initialUri;

  // TODO(JohnBorys): Replace WebViewScaffold with WebViewContainer after testing is complete

  @override
  Widget build(BuildContext context) {
    final widget = WebViewScaffold(
      title: Text(context.l10n.settings_ListViewTileTitle_help),
      initialUri: initialUri,
      userAgent: UserAgent.of(context),
    );
    return widget;
  }
}
