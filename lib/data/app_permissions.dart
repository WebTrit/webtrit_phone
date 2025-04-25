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
    final statusesPerRequestedPermission = await filteredPermissions.request();
    _logger.info('Requested permissions statuses: $statusesPerRequestedPermission');

    // Get statuses for special permissions
    _logger.info('Requesting special permissions: $_specialPermissions');
    final specialStatuses = await Future.wait(_specialPermissions.map((permission) => permission.status()));
    _logger.info('Special permissions statuses: $specialStatuses');

    // Update the denied status flag based on the remaining permissions
    final isDeniedRequestedPermission = statusesPerRequestedPermission.values.every((status) => status.isDenied);
    final isDeniedSpecialPermissions = specialStatuses.every((status) => status.isDenied);
    _logger.info(
        'Checking if permissions are denied - requested: $isDeniedRequestedPermission, special: $isDeniedSpecialPermissions');
    _isDenied = isDeniedRequestedPermission || isDeniedSpecialPermissions;
    _logger.info('Updated denied status: $_isDenied');

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
