import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import 'confirm_dialog_style.dart';
import 'confirm_dialog_styles.dart';

export 'confirm_dialog_style.dart';
export 'confirm_dialog_styles.dart';

class ConfirmDialog extends StatelessWidget {
  // Anchor the dialog to the nearest navigator instead of the app-wide root. The
  // originating theme is preserved by showDialog's InheritedTheme capture, so the
  // appearance and behavior are unchanged in the app; this only matters when a
  // screen is hosted inside another navigator (the configurator preview), where the
  // root navigator belongs to the host and the dialog would otherwise escape its
  // surface and lose the phone's Localizations.
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    ConfirmDialogStyle? style,
  }) {
    return showDialog<bool?>(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return ConfirmDialog._(title: title, content: content, style: style);
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
      useRootNavigator: false,
      builder: (context) {
        return ConfirmDialog._(dangerous: true, title: title, content: content, style: style);
      },
    );
  }

  const ConfirmDialog._({this.dangerous = false, required this.title, required this.content, required this.style});

  final bool dangerous;
  final String title;
  final String content;

  final ConfirmDialogStyle? style;

  @override
  Widget build(BuildContext context) {
    final localStyle = ConfirmDialogStyle.merge(style, Theme.of(context).extension<ConfirmDialogStyles>()?.primary);

    return AlertDialog(
      backgroundColor: localStyle.backgroundColor,
      surfaceTintColor: localStyle.surfaceTintColor,
      elevation: localStyle.elevation,
      shape: localStyle.shape,
      titleTextStyle: localStyle.titleTextStyle,
      contentTextStyle: localStyle.contentTextStyle,
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
