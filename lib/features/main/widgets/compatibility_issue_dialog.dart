import 'package:flutter/material.dart';

import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class CompatibilityIssueDialog extends StatelessWidget {
  static Future show(
    BuildContext context,
    Version currentVersion,
    VersionConstraint supportedConstraint, {
    VoidCallback? onUpdatePressed,
    VoidCallback? onLogoutPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return CompatibilityIssueDialog._(
          currentVersion,
          supportedConstraint,
          onUpdatePressed: onUpdatePressed,
          onLogoutPressed: onLogoutPressed,
        );
      },
      barrierDismissible: false,
    );
  }

  const CompatibilityIssueDialog._(
    this.currentVersion,
    this.supportedConstraint, {
    this.onUpdatePressed,
    this.onLogoutPressed,
  });

  final Version currentVersion;
  final VersionConstraint supportedConstraint;
  final VoidCallback? onUpdatePressed;
  final VoidCallback? onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.main_CompatibilityIssueDialog_title, textAlign: TextAlign.center),
      content: Text(
        context.l10n.main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(
          currentVersion.toString(),
          supportedConstraint.toString(),
        ),
      ),
      actions: [
        if (onUpdatePressed != null)
          TextButton(onPressed: onUpdatePressed, child: Text(context.l10n.main_CompatibilityIssueDialogActions_update)),
        TextButton(onPressed: onLogoutPressed, child: Text(context.l10n.main_CompatibilityIssueDialogActions_logout)),
      ],
    );
  }
}
