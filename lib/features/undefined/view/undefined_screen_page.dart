import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:webtrit_phone/features/features.dart';

@RoutePage()
class UndefinedScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const UndefinedScreenPage(this.undefinedType);

  final UndefinedType undefinedType;

  @override
  Widget build(BuildContext context) {
    return UndefinedScreen(undefinedType: undefinedType);
  }
}
