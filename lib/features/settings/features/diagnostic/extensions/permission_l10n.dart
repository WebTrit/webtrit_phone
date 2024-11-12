import 'package:flutter/widgets.dart';

import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

const int _kCameraPermission = 1; // Permission.camera
const int _kMicrophonePermission = 7; // Permission.microphone
const int _kContactsPermission = 2; // Permission.contacts
const int _kNotificationPermission = 17; // Permission.notification

extension PermissionL10n on Permission {
  String title(BuildContext context) {
    switch (value) {
      case _kCameraPermission:
        return context.l10n.diagnostic_permission_camera_title;
      case _kMicrophonePermission:
        return context.l10n.diagnostic_permission_microphone_title;
      case _kContactsPermission:
        return context.l10n.diagnostic_permission_contacts_title;
      case _kNotificationPermission:
        return context.l10n.diagnostic_permission_notification_title;
      default:
        return toString();
    }
  }

  String description(BuildContext context) {
    switch (value) {
      case _kCameraPermission:
        return context.l10n.diagnostic_permission_camera_description;
      case _kMicrophonePermission:
        return context.l10n.diagnostic_permission_microphone_description;
      case _kContactsPermission:
        return context.l10n.diagnostic_permission_contacts_description;
      case _kNotificationPermission:
        return context.l10n.diagnostic_permission_notification_description;
      default:
        return toString();
    }
  }
}
