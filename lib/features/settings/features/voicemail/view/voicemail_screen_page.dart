import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'voicemail_screen.dart';

@RoutePage()
class VoicemailScreenPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const VoicemailScreenPage();

  @override
  Widget build(BuildContext context) {
    final widget = VoicemailScreen();
    return widget;
  }
}
