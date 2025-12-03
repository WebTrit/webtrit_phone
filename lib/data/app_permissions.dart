import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

export 'package:permission_handler/permission_handler.dart' show Permission, PermissionStatus;

typedef ExcludePermissions = List<Permission> Function();

final _logger = Logger('AppPermissions');

class AppPermissions {
  static const _specialPermissions = [CallkeepSpecialPermissions.fullScreenIntent];
  static const _fullPermissions = [Permission.microphone, Permission.camera, Permission.contacts, Permission.sms];

  static Future<AppPermissions> init(ExcludePermissions excludePermissions) async {
    return AppPermissions._(excludePermissions);
  }

  AppPermissions._(this.excludePermissions);

  final ExcludePermissions excludePermissions;

  List<Permission> get permissions => _fullPermissions.where((p) => !excludePermissions().contains(p)).toList();

  Future<bool> get isDenied async {
    final statuses = await Future.wait(permissions.map((permission) => permission.status));
    final specialStatuses = await Future.wait(_specialPermissions.map((permission) => permission.status()));
    final isDenied = statuses.every((status) => status.isDenied) || specialStatuses.every((status) => status.isDenied);

    return isDenied;
  }

  Future<List<CallkeepSpecialPermissions>> deniedSpecialPermissions() async {
    final statuses = await Future.wait(
      _specialPermissions.map((permission) async {
        final status = await permission.status();
        return status.isDenied ? permission : null;
      }),
    );
    return statuses.whereType<CallkeepSpecialPermissions>().toList();
  }

  Future<Map<Permission, PermissionStatus>> request() async {
    // Request statuses for the filtered permissions
    final permissionStatuses = await permissions.request();
    _logger.info('Requested permissions statuses: $permissionStatuses');

    // Get statuses for special permissions
    _logger.info('Requesting special permissions: $_specialPermissions');
    final specialPermissionStatuses = await Future.wait(_specialPermissions.map((permission) => permission.status()));
    _logger.info('Special permissions statuses: $specialPermissionStatuses');

    // Update the denied status flag based on the remaining permissions
    final isDeniedPermissions = permissionStatuses.values.every((status) => status.isDenied);
    final isDeniedSpecialPermissions = specialPermissionStatuses.every((status) => status.isDenied);
    _logger.info(
      'Checking if permissions are denied - requested: $isDeniedPermissions, special: $isDeniedSpecialPermissions',
    );

    return permissionStatuses;
  }

  /// Opens the app settings page.
  Future<void> toAppSettings() => openAppSettings();

  /// Attempts to open the settings screen for the given special permission.
  ///
  /// If the specific permission screen (e.g., full screen intent) is not supported
  /// on the current Android version or fails to open, it falls back to opening
  /// the general app settings screen instead. This is useful for permissions that
  /// are typically located outside the standard app settings.
  Future<void> toSpecialPermissionsSetting(CallkeepSpecialPermissions permission) async {
    final callkeepPermission = WebtritCallkeepPermissions();

    try {
      if (permission == CallkeepSpecialPermissions.fullScreenIntent) {
        await callkeepPermission.openFullScreenIntentSettings();
      } else {
        await callkeepPermission.openSettings();
      }
    } catch (e) {
      await callkeepPermission.openSettings();
    }
  }

  Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  Future<bool> isContactPermissionGranted() async {
    return isPermissionGranted(Permission.contacts);
  }

  Future<bool> requestContactPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }
}
