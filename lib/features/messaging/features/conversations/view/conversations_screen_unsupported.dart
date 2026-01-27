import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/main_app_bar.dart';

class ConversationsScreenUnsupported extends StatelessWidget {
  const ConversationsScreenUnsupported({this.title, super.key});

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: title, context: context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(child: Text(context.l10n.messaging_ConversationsScreen_unsupported, textAlign: TextAlign.center)),
      ),
    );
  }
}
