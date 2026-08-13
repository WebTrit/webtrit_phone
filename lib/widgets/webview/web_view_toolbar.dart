import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/back_button.dart';
import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/semantic_action.dart';

class WebViewToolbar extends StatelessWidget {
  final Widget? title;
  final VoidCallback onReload;

  const WebViewToolbar({super.key, required this.title, required this.onReload});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: const ExtBackButton(),
      actions: [
        SemanticAction(
          label: context.l10n.common_SemanticsLabel_refresh,
          identifier: webViewReloadId,
          child: IconButton(icon: const Icon(Icons.refresh), onPressed: onReload),
        ),
      ],
    );
  }
}
