import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class AcknowledgeDialog extends StatelessWidget {
  static Future<void> show(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AcknowledgeDialog._(
          title: title,
          content: content,
        );
      },
    );
  }

  const AcknowledgeDialog._({
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.alertDialogActions_ok),
        ),
      ],
    );
  }
}
