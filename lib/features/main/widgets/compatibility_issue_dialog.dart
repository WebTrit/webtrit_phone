import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

enum CompatibilityIssueDialogResult {
  verify,
  logout,
}

class CompatibilityIssueDialog extends StatelessWidget {
  static Future<CompatibilityIssueDialogResult?> show(
    BuildContext context, {
    required Object error,
    VoidCallback? onUpdatePressed,
  }) {
    return showDialog<CompatibilityIssueDialogResult>(
      context: context,
      builder: (context) {
        return CompatibilityIssueDialog._(
          error: error,
          onUpdatePressed: onUpdatePressed,
        );
      },
      barrierDismissible: false,
    );
  }

  const CompatibilityIssueDialog._({
    required this.error,
    this.onUpdatePressed,
  });

  final Object error;
  final VoidCallback? onUpdatePressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        context.l10n.main_CompatibilityIssueDialog_title,
        textAlign: TextAlign.center,
      ),
      content: Text(
        _errorL10n(context),
      ),
      actions: [
        if (onUpdatePressed != null)
          TextButton(
            onPressed: onUpdatePressed,
            child: Text(context.l10n.main_CompatibilityIssueDialogActions_update),
          ),
        TextButton(
          child: Text(context.l10n.main_CompatibilityIssueDialogActions_verify),
          onPressed: () {
            Navigator.of(context).pop(CompatibilityIssueDialogResult.verify);
          },
        ),
        TextButton(
          child: Text(context.l10n.main_CompatibilityIssueDialogActions_logout),
          onPressed: () {
            Navigator.of(context).pop(CompatibilityIssueDialogResult.logout);
          },
        ),
      ],
    );
  }

  String _errorL10n(BuildContext context) {
    final error = this.error;
    if (error is CoreVersionUnsupportedException) {
      return context.l10n.main_CompatibilityIssueDialog_contentCoreVersionUnsupportedExceptionError(
        error.actual.toString(),
        error.supportedConstraint.toString(),
      );
    } else {
      return error.toString();
    }
  }
}
