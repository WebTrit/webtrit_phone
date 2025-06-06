import 'package:flutter/material.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({
    super.key,
    required this.initialUri,
  });

  final Uri initialUri;

  // TODO(JohnBorys): Replace WebViewScaffold with WebViewController after testing is complete

  @override
  Widget build(BuildContext context) {
    return WebViewScaffold(
      initialUri: initialUri,
      userAgent: UserAgent.of(context),
    );
  }
}
