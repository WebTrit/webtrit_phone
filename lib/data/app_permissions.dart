import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/utils/utils.dart';

export 'package:permission_handler/permission_handler.dart' show Permission, PermissionStatus;

typedef ExcludePermissions = List<Permission> Function();

final _logger = Logger('AppPermissions');

class AppPermissions {
  /// A list of permissions that are absolutely required for the app to function correctly.
  static const _requiredPermissions = [Permission.microphone];

  /// The list of all possible permissions that the app may request.
  static const _fullPermissions = [..._requiredPermissions, Permission.camera, Permission.contacts, Permission.sms];

  /// A list of special permissions that are absolutely required for the app to function correctly.
  static const _requiredSpecialPermissions = [CallkeepSpecialPermissions.fullScreenIntent];

  /// A list of special permissions required by the app, handled via `webtrit_callkeep`.
  static const _specialPermissions = [..._requiredSpecialPermissions];

  /// Defines the list of permissions critical for the plugin's core functionality.
  ///
  /// [CallkeepPermission.readPhoneState] is included here to verify if the user
  /// has granted the necessary access for:
  /// Successfully registering the `PhoneAccount` with the Android Telecom framework.
  static const _callkeepDiagnosticPermissions = [CallkeepPermission.readPhoneState];

  /// The time-to-live for the permissions cache.
  static const _cacheTTL = Duration(seconds: 1);

  static Future<AppPermissions> init(ExcludePermissions excludePermissions) async {
    return AppPermissions._(excludePermissions, WebtritCallkeepPermissions());
  }

  AppPermissions._(this._excludePermissions, this._webtritCallkeepPermissions) {
    _permissionsCache = ExpiringCache(
      ttl: _cacheTTL,
      compute: () => _fullPermissions.where((p) => !_excludePermissions().contains(p)).toList(),
    );
  }

  /// Manages permissions related to `webtrit_callkeep` plugin.
  final WebtritCallkeepPermissions _webtritCallkeepPermissions;

  /// A function that returns a list of permissions to be excluded from the [_fullPermissions].
  final ExcludePermissions _excludePermissions;

  /// A cache for permissions with TTL-based expiration.
  late final ExpiringCache<List<Permission>> _permissionsCache;

  /// The list of permissions that the app may request, excluding those specified by [_excludePermissions].
  List<Permission> get permissions => _permissionsCache.value;

  /// Returns `true` if any of the required permissions are not granted.
  ///
  /// This checks the status of both [_requiredPermissions] and [_requiredSpecialPermissions].
  Future<bool> get isDenied async {
    for (final permission in _requiredPermissions) {
      final status = await permission.status;
      if (!status.isGranted) {
        return true;
      }
    }

    for (final permission in _requiredSpecialPermissions) {
      final status = await permission.status();
      if (!status.isGranted) {
        return true;
      }
    }

    return false;
  }

  /// Checks the status of special permissions.
  ///
  /// [onlyRequired] - If true, checks only [_requiredSpecialPermissions].
  ///                  If false (default), checks all [_specialPermissions].
  Future<Map<CallkeepSpecialPermissions, CallkeepSpecialPermissionStatus>> getSpecialPermissionStatuses({
    bool onlyRequired = false,
  }) async {
    final targetPermissions = onlyRequired ? _requiredSpecialPermissions : _specialPermissions;

    if (targetPermissions.isEmpty) return {};

    final entries = await Future.wait(
      targetPermissions.map((permission) async {
        final status = await permission.status();
        return MapEntry(permission, status);
      }),
    );

    return Map.fromEntries(entries);
  }

  /// Checks the status of regular permissions.
  ///
  /// [onlyRequired] - If true, checks only [_requiredPermissions].
  ///                  If false (default), checks all non-excluded permissions (the filtered list from [_fullPermissions]).
  Future<Map<Permission, PermissionStatus>> getPermissionStatuses({bool onlyRequired = false}) async {
    // Select the list based on the flag
    final targetPermissions = onlyRequired ? _requiredPermissions : permissions;

    if (targetPermissions.isEmpty) return {};

    final entries = await Future.wait(
      targetPermissions.map((permission) async {
        final status = await permission.status;
        return MapEntry(permission, status);
      }),
    );

    return Map.fromEntries(entries);
  }

  /// Requests permissions and returns a map of permissions to their statuses.
  Future<Map<Permission, PermissionStatus>> request() async {
    final permissionStatuses = await permissions.request();
    _logger.info('Requested permissions statuses: $permissionStatuses');

    return permissionStatuses;
  }

  /// Requests specific permissions via the native plugin required for generating diagnostic logs.
  ///
  /// This triggers the native implementation to ask for `READ_PHONE_STATE` / `READ_PHONE_NUMBERS`
  /// without triggering the broader `CALL_PHONE` permission request flow.
  ///
  /// Returns a Map of the requested permissions and their results (Granted/Denied).
  Future<Map<CallkeepPermission, CallkeepSpecialPermissionStatus>> requestDiagnosticsPermissions() async {
    _logger.info('Checking diagnostics permission statuses via native bridge');
    try {
      final results = await _webtritCallkeepPermissions.requestPermissions(_callkeepDiagnosticPermissions);
      _logger.info('Diagnostics permissions results: $results');
      return results;
    } catch (e, s) {
      _logger.severe('Failed to check diagnostics permission statuses', e, s);
      return {};
    }
  }

  Future<Map<CallkeepPermission, CallkeepSpecialPermissionStatus>> getDiagnosticPermissionStatuses() async {
    _logger.info('Requesting diagnostics permission statuses via native bridge');
    try {
      final results = await _webtritCallkeepPermissions.checkPermissionsStatus(_callkeepDiagnosticPermissions);
      _logger.info('Diagnostics permissions results: $results');
      return results;
    } catch (e, s) {
      _logger.severe('Failed to request diagnostics permissions', e, s);
      return {};
    }
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
    try {
      if (permission == CallkeepSpecialPermissions.fullScreenIntent) {
        await _webtritCallkeepPermissions.openFullScreenIntentSettings();
      } else {
        await _webtritCallkeepPermissions.openSettings();
      }
    } catch (e) {
      await _webtritCallkeepPermissions.openSettings();
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
