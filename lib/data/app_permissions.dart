import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_phone/models/main_flavor.dart';

import 'feature_access.dart';

export 'package:permission_handler/permission_handler.dart' show Permission, PermissionStatus;

class AppPermissions {
  static late AppPermissions _instance;

  static Future<void> init() async {
    final featureAccess = FeatureAccess();

    // Update initialization logic for better clarity and maintainability
    final permissions = [
      Permission.microphone,
      Permission.camera,
      if (featureAccess.bottomMenuFeature.isTabEnabled(MainFlavor.contacts)) Permission.contacts,
    ];

    final statuses = await Future.wait(permissions.map((permission) => permission.status));
    final isDenied = statuses.every((status) => status.isDenied);
    _instance = AppPermissions._(isDenied, permissions);
  }

  factory AppPermissions() {
    return _instance;
  }

  AppPermissions._(this._isDenied, this._permissions);

  bool _isDenied;

  List<Permission> _permissions;

  bool get isDenied => _isDenied;

  Future<Map<Permission, PermissionStatus>> request() async {
    final statusesPerRequestedPermission = await _permissions.request();
    _isDenied = statusesPerRequestedPermission.values.every((status) => status.isDenied);
    return statusesPerRequestedPermission;
  }

  /// Opens the app settings page.
  Future<bool> toAppSettings() => openAppSettings();

  Future<bool> toSpecialPermissionAppSettings(CallkeepSpecialPermissions? permission) {
    if (permission == CallkeepSpecialPermissions.fullScreenIntent) {
      return WebtritCallkeepPermissions().openFullScreenIntentSettings();
    }

    return openAppSettings();
  }
}
