import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';

class UserAgreementScreenScreenshot extends StatelessWidget {
  const UserAgreementScreenScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserAgreementScreen(
      appTermsAndConditionsUrl: 'https://example.com/terms',
      appName: 'WebTrit',
    );
  }
}
