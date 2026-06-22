import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// A catalog page rendering every confirm-dialog variant inline so a single
/// screenshot shows the dialog theme (background, surface tint, shape, text and
/// button styling) without having to open each dialog modally.
class DialogsShowcaseScreenshot extends StatelessWidget {
  const DialogsShowcaseScreenshot({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = ConfirmDialogStyle.merge(null, Theme.of(context).extension<ConfirmDialogStyles>()?.primary);

    return Scaffold(
      appBar: AppBar(title: const Text('Dialogs')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _DialogPreview(
            label: 'Confirm',
            child: _confirmDialog(
              style,
              title: l10n.settings_LogoutConfirmDialog_title,
              content: l10n.settings_LogoutConfirmDialog_content,
              noLabel: l10n.alertDialogActions_no,
              yesLabel: l10n.alertDialogActions_yes,
              yesStyle: style.defaultButtonStyle,
            ),
          ),
          _DialogPreview(
            label: 'Dangerous confirm',
            child: _confirmDialog(
              style,
              title: l10n.settings_AccountDeleteConfirmDialog_title,
              content: l10n.settings_AccountDeleteConfirmDialog_content,
              noLabel: l10n.alertDialogActions_no,
              yesLabel: l10n.alertDialogActions_yes,
              yesStyle: style.activeButtonStyle2,
            ),
          ),
          _DialogPreview(
            label: 'Alert',
            child: AlertDialog(
              backgroundColor: style.backgroundColor,
              surfaceTintColor: style.surfaceTintColor,
              elevation: style.elevation,
              shape: style.shape,
              titleTextStyle: style.titleTextStyle,
              contentTextStyle: style.contentTextStyle,
              title: Text(l10n.settings_LogoutConfirmDialog_title),
              content: Text(l10n.settings_LogoutConfirmDialog_content),
              actions: [
                TextButton(onPressed: () {}, style: style.activeButtonStyle1, child: Text(l10n.alertDialogActions_yes)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog _confirmDialog(
    ConfirmDialogStyle style, {
    required String title,
    required String content,
    required String noLabel,
    required String yesLabel,
    required ButtonStyle? yesStyle,
  }) {
    return AlertDialog(
      backgroundColor: style.backgroundColor,
      surfaceTintColor: style.surfaceTintColor,
      elevation: style.elevation,
      shape: style.shape,
      titleTextStyle: style.titleTextStyle,
      contentTextStyle: style.contentTextStyle,
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(onPressed: () {}, style: style.activeButtonStyle1, child: Text(noLabel)),
        TextButton(onPressed: () {}, style: yesStyle, child: Text(yesLabel)),
      ],
    );
  }
}

class _DialogPreview extends StatelessWidget {
  const _DialogPreview({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          // AlertDialog renders inside a Dialog whose Align needs bounded
          // height; constrain it so it lays out in the scrolling catalog.
          SizedBox(height: 220, child: child),
        ],
      ),
    );
  }
}
