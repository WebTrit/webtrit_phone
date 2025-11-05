import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class HelpScreenPage extends StatelessWidget {
  static const initialUriQueryParamName = 'initialUrl';

  // ignore: use_key_in_widget_constructors
  const HelpScreenPage({@QueryParam(initialUriQueryParamName) this.initialUriQueryParam});

  final String? initialUriQueryParam;

  @override
  Widget build(BuildContext context) {
    final widget = HelpScreen(initialUri: Uri.parse(initialUriQueryParam ?? kBlankUri));
    return widget;
  }
}
