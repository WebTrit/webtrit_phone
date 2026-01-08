import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key, required this.initialUri, required this.userAgent});

  final Uri initialUri;
  final String userAgent;

  @override
  Widget build(BuildContext context) {
    return WebViewContainer(initialUri: initialUri, userAgent: userAgent);
  }
}
