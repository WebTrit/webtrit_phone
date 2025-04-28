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
  Future<bool> toAppSettings() => openAppSettings();

  Future<bool> toSpecialPermissionAppSettings(CallkeepSpecialPermissions? permission) {
    if (permission == CallkeepSpecialPermissions.fullScreenIntent) {
      return WebtritCallkeepPermissions().openFullScreenIntentSettings();
    }

    return openAppSettings();
  }
}
