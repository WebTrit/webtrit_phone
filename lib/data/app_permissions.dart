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
    final permissionsStatuses = await Future.wait(_permissions.map((permission) => permission.status));
    final isDenied = permissionsStatuses.every((permissionStatus) => permissionStatus.isDenied);
    _instance = AppPermissions._(isDenied);
  }

  factory AppPermissions() {
    return _instance;
  }

  AppPermissions._(this._isDenied);

  bool _isDenied;

  bool get isDenied => _isDenied;

  Future<Map<Permission, PermissionStatus>> request() async {
    final permissionsRequestResults = [for (final permission in _permissions) await permission.request()];
    _isDenied = permissionsRequestResults.every((permissionStatus) => permissionStatus.isDenied);
    return Map.fromIterables(_permissions, permissionsRequestResults);
  }
}
