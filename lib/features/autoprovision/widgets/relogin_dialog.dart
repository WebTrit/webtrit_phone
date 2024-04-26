import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class ReloginDialog extends StatelessWidget {
  const ReloginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.autoprovision_ReloginDialog_title),
      content: Text(context.l10n.autoprovision_ReloginDialog_text),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(context.l10n.autoprovision_ReloginDialog_confirm),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.l10n.autoprovision_ReloginDialog_decline),
        ),
      ],
    );
  }
}
