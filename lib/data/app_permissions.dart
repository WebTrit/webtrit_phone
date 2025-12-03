import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/utils/utils.dart';

export 'package:permission_handler/permission_handler.dart' show Permission, PermissionStatus;

typedef ExcludePermissions = List<Permission> Function();

final _logger = Logger('AppPermissions');

class AppPermissions {
  /// A list of special permissions required by the app, handled via `webtrit_callkeep`.
  static const _specialPermissions = [CallkeepSpecialPermissions.fullScreenIntent];

  /// The list of all possible permissions that the app may request.
  static const _fullPermissions = [Permission.microphone, Permission.camera, Permission.contacts, Permission.sms];

  /// The time-to-live for the permissions cache.
  static const _cacheTTL = Duration(seconds: 1);

  static Future<AppPermissions> init(ExcludePermissions excludePermissions) async {
    return AppPermissions._(excludePermissions);
  }

  AppPermissions._(this._excludePermissions) {
    _permissionsCache = ExpiringCache(
      ttl: _cacheTTL,
      compute: () => _fullPermissions.where((p) => !_excludePermissions().contains(p)).toList(),
    );
  }

  /// A function that returns a list of permissions to be excluded from the [_fullPermissions].
  final ExcludePermissions _excludePermissions;

  /// A cache for permissions with TTL-based expiration.
  late final ExpiringCache<List<Permission>> _permissionsCache;

  /// The list of permissions that the app may request, excluding those specified by [_excludePermissions].
  List<Permission> get permissions => _permissionsCache.value;

  /// Returns `true` if all regular permissions are denied or all special permissions are denied.
  ///
  /// This checks the status of both [_fullPermissions] (filtered by [_excludePermissions]) and [_specialPermissions].
  Future<bool> get isDenied async {
    final currentPermissions = permissions;

    if (currentPermissions.isNotEmpty) {
      final statuses = await Future.wait(currentPermissions.map((p) => p.status));
      if (statuses.every((status) => status.isDenied)) return true;
    }

    if (_specialPermissions.isNotEmpty) {
      final specialStatuses = await Future.wait(_specialPermissions.map((p) => p.status()));
      if (specialStatuses.every((status) => status.isDenied)) return true;
    }

    return false;
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
