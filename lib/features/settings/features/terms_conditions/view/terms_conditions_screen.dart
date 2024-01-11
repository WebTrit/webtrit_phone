import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../../../widgets/widgets.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({
    super.key,
    required this.initialUri,
  });

  final Uri initialUri;

  @override
  Widget build(BuildContext context) {
    return WebViewScaffold(
      title: Text(context.l10n.settings_ListViewTileTitle_termsConditions),
      initialUri: initialUri,
    );
  }
}
