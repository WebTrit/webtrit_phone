import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'confirm_dialog_style.dart';
import 'confirm_dialog_styles.dart';

export 'confirm_dialog_style.dart';
export 'confirm_dialog_styles.dart';

class ConfirmDialog extends StatelessWidget {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    ConfirmDialogStyle? style,
  }) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return ConfirmDialog._(
          title: title,
          content: content,
          style: style,
        );
      },
    );
  }

  static Future<bool?> showDangerous(
    BuildContext context, {
    required String title,
    required String content,
    ConfirmDialogStyle? style,
  }) {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return ConfirmDialog._(
          dangerous: true,
          title: title,
          content: content,
          style: style,
        );
      },
    );
  }

  const ConfirmDialog._({
    this.dangerous = false,
    required this.title,
    required this.content,
    required this.style,
  });

  final bool dangerous;
  final String title;
  final String content;

  final ConfirmDialogStyle? style;

  @override
  Widget build(BuildContext context) {
    final localStyle = ConfirmDialogStyle.merge(style, Theme.of(context).extension<ConfirmDialogStyles>()?.primary);

    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          key: confirmDialogNoButtonKey,
          onPressed: () => Navigator.of(context).pop(false),
          style: localStyle.activeButtonStyle1,
          child: Text(context.l10n.alertDialogActions_no),
        ),
        TextButton(
          key: confirmDialogYesButtonKey,
          onPressed: () => Navigator.of(context).pop(true),
          style: dangerous ? localStyle.activeButtonStyle2 : localStyle.defaultButtonStyle,
          child: Text(context.l10n.alertDialogActions_yes),
        ),
      ],
    );
  }
}
