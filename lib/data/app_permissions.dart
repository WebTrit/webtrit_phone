import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

export 'package:permission_handler/permission_handler.dart' show Permission, PermissionStatus;

final _logger = Logger('AppPermissions');

class AppPermissions {
  static const _specialPermissions = [
    CallkeepSpecialPermissions.fullScreenIntent,
  ];

  static late AppPermissions _instance;

  static Future<AppPermissions> init(FeatureAccess featureAccess) async {
    final bottomMenuFeature = featureAccess.bottomMenuFeature;
    final contactsSourceTypes = bottomMenuFeature.getTabEnabled(MainFlavor.contacts)?.toContacts?.contactSourceTypes;
    final localContactsSourceTypeEnabled = contactsSourceTypes?.contains(ContactSourceType.local) == true;

    final specialStatuses = await Future.wait(_specialPermissions.map((permission) => permission.status()));

    // Update initialization logic for better clarity and maintainability
    final permissions = [
      Permission.microphone,
      Permission.camera,
      if (localContactsSourceTypeEnabled) Permission.contacts,
    ];

    final statuses = await Future.wait(permissions.map((permission) => permission.status));
    final isDenied = statuses.every((status) => status.isDenied) || specialStatuses.every((status) => status.isDenied);
    _instance = AppPermissions._(isDenied, permissions);
    return _instance;
  }

  factory AppPermissions() {
    return _instance;
  }

  AppPermissions._(this._isDenied, this._permissions);

  bool _isDenied;

  List<Permission> _permissions;

  List<Permission> get permissions => _permissions;

  bool get isDenied => _isDenied;

  Future<List<CallkeepSpecialPermissions>> deniedSpecialPermissions() async {
    final statuses = await Future.wait(_specialPermissions.map((permission) async {
      final status = await permission.status();
      return status.isDenied ? permission : null;
    }));
    return statuses.whereType<CallkeepSpecialPermissions>().toList();
  }

  Future<Map<Permission, PermissionStatus>> request({List<Permission>? exclude}) async {
    // Filter out permissions that are in the exclude list
    final filteredPermissions = _permissions.where((permission) {
      return exclude == null || !exclude.contains(permission);
    }).toList();

    _logger.info('Requesting permissions: $_permissions');

    // Request statuses for the filtered permissions
    final permissionStatuses = await filteredPermissions.request();
    _logger.info('Requested permissions statuses: $permissionStatuses');

    // Get statuses for special permissions
    _logger.info('Requesting special permissions: $_specialPermissions');
    final specialPermissionStatuses = await Future.wait(_specialPermissions.map((permission) => permission.status()));
    _logger.info('Special permissions statuses: $specialPermissionStatuses');

    // Update the denied status flag based on the remaining permissions
    final isDeniedPermissions = permissionStatuses.values.every((status) => status.isDenied);
    final isDeniedSpecialPermissions = specialPermissionStatuses.every((status) => status.isDenied);
    _logger.info(
        'Checking if permissions are denied - requested: $isDeniedPermissions, special: $isDeniedSpecialPermissions');
    _isDenied = isDeniedPermissions || isDeniedSpecialPermissions;
    _logger.info('Updated denied status: $_isDenied');

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
  Future<void> toSpecialPermissionAppSettings(CallkeepSpecialPermissions permission) async {
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
}
