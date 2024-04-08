import 'package:permission_handler/permission_handler.dart';

export 'package:permission_handler/permission_handler.dart' show Permission, PermissionStatus;

class AppPermissions {
  static const _permissions = [
    Permission.microphone,
    Permission.camera,
    Permission.contacts,
  ];

  static late AppPermissions _instance;

  static Future<void> init() async {
    final statuses = await Future.wait(_permissions.map((permission) => permission.status));
    final isDenied = statuses.every((status) => status.isDenied);
    _instance = AppPermissions._(isDenied);
  }

  factory AppPermissions() {
    return _instance;
  }

  AppPermissions._(this._isDenied);

  bool _isDenied;

  bool get isDenied => _isDenied;

  Future<Map<Permission, PermissionStatus>> request() async {
    final statusesPerRequestedPermission = await _permissions.request();
    _isDenied = statusesPerRequestedPermission.values.every((status) => status.isDenied);
    return statusesPerRequestedPermission;
  }

  /// Opens the app settings page.
  Future<bool> toAppSettings() => openAppSettings();
}
