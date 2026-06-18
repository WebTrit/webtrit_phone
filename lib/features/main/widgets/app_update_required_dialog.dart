import 'package:flutter/material.dart';

import 'package:pub_semver/pub_semver.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

/// Non-dismissible prompt shown when the running app is older than the
/// backend-declared minimum supported app version (`min_supported_app_version`
/// from system-info). The inverse of [CompatibilityIssueDialog]: there the
/// backend is too new, here the app is too old.
class AppUpdateRequiredDialog extends StatelessWidget {
  static Future show(
    BuildContext context,
    Version currentVersion,
    Version minSupportedVersion, {
    VoidCallback? onUpdatePressed,
    VoidCallback? onLogoutPressed,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AppUpdateRequiredDialog._(
          currentVersion,
          minSupportedVersion,
          onUpdatePressed: onUpdatePressed,
          onLogoutPressed: onLogoutPressed,
        );
      },
      barrierDismissible: false,
    );
  }

  const AppUpdateRequiredDialog._(
    this.currentVersion,
    this.minSupportedVersion, {
    this.onUpdatePressed,
    this.onLogoutPressed,
  });

  final Version currentVersion;
  final Version minSupportedVersion;
  final VoidCallback? onUpdatePressed;
  final VoidCallback? onLogoutPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.main_AppUpdateRequiredDialog_title, textAlign: TextAlign.center),
      content: Text(
        context.l10n.main_AppUpdateRequiredDialog_content(currentVersion.toString(), minSupportedVersion.toString()),
      ),
      actions: [
        if (onUpdatePressed != null)
          TextButton(onPressed: onUpdatePressed, child: Text(context.l10n.main_CompatibilityIssueDialogActions_update)),
        TextButton(onPressed: onLogoutPressed, child: Text(context.l10n.main_CompatibilityIssueDialogActions_logout)),
      ],
    );
  }
}
