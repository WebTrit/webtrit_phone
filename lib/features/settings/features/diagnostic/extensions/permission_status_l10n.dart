import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

extension PermissionStatusL10n on PermissionStatus {
  String title(BuildContext context) {
    switch (this) {
      case PermissionStatus.denied:
        return context.l10n.diagnostic_permissionStatus_denied;
      case PermissionStatus.granted:
        return context.l10n.diagnostic_permissionStatus_granted;
      case PermissionStatus.restricted:
        return context.l10n.diagnostic_permissionStatus_restricted;
      case PermissionStatus.limited:
        return context.l10n.diagnostic_permissionStatus_limited;
      case PermissionStatus.permanentlyDenied:
        return context.l10n.diagnostic_permissionStatus_permanentlyDenied;
      case PermissionStatus.provisional:
        return context.l10n.diagnostic_permissionStatus_provisional;
    }
  }

  // TODO(Serdun): Move to color scheme
  Color color(BuildContext context) {
    switch (this) {
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
        return Colors.red;
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.provisional:
        return Colors.orange;
    }
  }
}
