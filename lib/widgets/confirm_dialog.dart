import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/theme/theme.dart';

class ConfirmDialog extends StatelessWidget {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return ConfirmDialog._(
          title: title,
          content: content,
        );
      },
    );
  }

  static Future<bool?> showDangerous(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return ConfirmDialog._(
          dangerous: true,
          title: title,
          content: content,
        );
      },
    );
  }

  const ConfirmDialog._({
    Key? key,
    this.dangerous = false,
    required this.title,
    required this.content,
  }) : super(key: key);

  final bool dangerous;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextButtonStyles? textButtonStyles = themeData.extension<TextButtonStyles>();
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: textButtonStyles?.neutral,
          child: Text(context.l10n.alertDialogActions_no),
        ),
        TextButton(
          child: Text(context.l10n.alertDialogActions_yes),
          style: dangerous ? textButtonStyles?.dangerous : null,
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
