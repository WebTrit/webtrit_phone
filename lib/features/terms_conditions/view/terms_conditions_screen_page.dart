import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class TermsConditionsScreenPage extends StatelessWidget {
  static const initialUriQueryParamName = 'initialUrl';

  // ignore: use_key_in_widget_constructors
  const TermsConditionsScreenPage({@QueryParam(initialUriQueryParamName) this.initialUriQueryParam});

  final String? initialUriQueryParam;

  @override
  Widget build(BuildContext context) {
    final appMetadataProvider = context.read<AppMetadataProvider>();

    final widget = TermsConditionsScreen(
      initialUri: Uri.parse(initialUriQueryParam ?? kBlankUri),
      userAgent: appMetadataProvider.userAgent,
    );
    return widget;
  }
}
