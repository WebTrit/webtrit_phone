import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

enum CompatibilityIssueDialogResult {
  logout,
  verify,
}

class CompatibilityIssueDialog extends StatelessWidget {
  static Future<CompatibilityIssueDialogResult?> show(
    BuildContext context, {
    required Object error,
  }) {
    return showDialog<CompatibilityIssueDialogResult>(
      context: context,
      builder: (context) {
        return CompatibilityIssueDialog._(
          error: error,
        );
      },
      barrierDismissible: false,
    );
  }

  const CompatibilityIssueDialog._({
    Key? key,
    required this.error,
  }) : super(key: key);

  final Object error;

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
        TextButton(
          child: Text(context.l10n.main_CompatibilityIssueDialogActions_logout),
          onPressed: () {
            Navigator.of(context).pop(CompatibilityIssueDialogResult.logout);
          },
        ),
        TextButton(
          child: Text(context.l10n.main_CompatibilityIssueDialogActions_verify),
          onPressed: () {
            Navigator.of(context).pop(CompatibilityIssueDialogResult.verify);
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
