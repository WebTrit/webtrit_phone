import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

class PrivacyScreenScreenshot extends StatelessWidget {
  const PrivacyScreenScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    final url = context.read<FeatureAccess>().termsFeature.configData.uri;
    final appMetadataProvider = context.read<AppMetadataProvider>();

    return TermsConditionsScreen(
      initialUri: url,
      userAgent: appMetadataProvider.userAgent,
    );
  }
}
