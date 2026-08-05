import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

/// The no-camera-permission state of the QR sign-in tab.
///
/// Offers a single action: request the permission while the OS can still show
/// the dialog; once the denial is permanent, the settings screen is the only
/// way left, so the button is replaced rather than stacked.
class QrSigninPermissionView extends StatelessWidget {
  const QrSigninPermissionView({
    super.key,
    required this.permanentlyDenied,
    required this.onRequestPermission,
    required this.onOpenSettings,
  });

  final bool permanentlyDenied;
  final VoidCallback onRequestPermission;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: CircleAvatar(
            radius: 40,
            backgroundColor: themeData.colorScheme.surfaceContainerHighest,
            child: Icon(Icons.no_photography_outlined, size: 36, color: themeData.colorScheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: kInset),
        Text(
          context.l10n.login_Text_qrSigninCameraPermissionTitle,
          textAlign: TextAlign.center,
          style: themeData.textTheme.titleLarge,
        ),
        const SizedBox(height: kInset / 2),
        Text(
          context.l10n.login_Text_qrSigninCameraPermissionDescription,
          textAlign: TextAlign.center,
          style: themeData.textTheme.bodyMedium,
        ),
        const SizedBox(height: kInset),
        if (permanentlyDenied)
          ElevatedButton(onPressed: onOpenSettings, child: Text(context.l10n.login_Button_qrSigninOpenSettings))
        else
          ElevatedButton(
            onPressed: onRequestPermission,
            child: Text(context.l10n.login_Button_qrSigninAllowCameraAccess),
          ),
      ],
    );
  }
}
