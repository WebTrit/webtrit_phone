import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';

import '../models/models.dart';

part 'permissions_cubit.freezed.dart';

part 'permissions_state.dart';

final _logger = Logger('PermissionsCubit');

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit({
    required this.appPreferences,
    required this.appPermissions,
    required this.deviceInfo,
  }) : super(const PermissionsState.initial());

  final AppPreferences appPreferences;
  final AppPermissions appPermissions;
  final DeviceInfo deviceInfo;

  void requestPermissions() async {
    _logger.info('Requesting permissions');

    emit(const PermissionsState.inProgress());
    try {
      // Check if the contacts agreement is accepted
      final contactsAgreementStatus = appPreferences.getContactsAgreementStatus();
      _logger.info('Contacts agreement status: ${contactsAgreementStatus.isAccepted}');

      // Prepare the exclude list based on the contacts agreement status
      final excludePermissions = <Permission>[
        if (!contactsAgreementStatus.isAccepted) Permission.contacts,
      ];
      _logger.info('Excluding permissions: $excludePermissions');

      // Request permissions, excluding the specified ones
      await appPermissions.request(exclude: excludePermissions);
      _logger.info('Permissions requested');
      await requestFirebaseMessagingPermission();
      _logger.info('Firebase messaging permission requested');

      // Handle special permissions
      final specialPermissions = await appPermissions.deniedSpecialPermissions();
      _logger.info('Denied special permissions: $specialPermissions');

      // Check for manufacturer-specific tips or denied special permissions
      final manufacturer = _checkManufacturer();
      _logger.info('Manufacturer: $manufacturer');

      if (manufacturer == null && specialPermissions.isEmpty) {
        emit(const PermissionsState.success());
      } else if (manufacturer != null) {
        emit(PermissionsState.manufacturerTipNeeded(manufacturer));
      } else if (specialPermissions.isNotEmpty) {
        emit(PermissionsState.permissionFullScreenIntentNeeded(specialPermissions.first));
      }
    } catch (e) {
      emit(PermissionsState.failure(e));
    }
  }

  void dismissError() {
    emit(const PermissionsState.initial());
  }

  void dismissTip() {
    emit(const PermissionsState.success());
  }

  void openAppSettings() {
    appPermissions.toAppSettings();
  }

  void openAppSpecialPermissionSettings(CallkeepSpecialPermissions permission) {
    appPermissions.toSpecialPermissionsSetting(permission);
  }

  Future<void> requestFirebaseMessagingPermission() async {
    final logger = Logger('FirebaseMessaging');

    final notificationSettings = await FirebaseMessaging.instance.requestPermission();
    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      logger.info('User granted permission');
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
      logger.info('User granted provisional permission');
    } else {
      logger.info('User declined or has not accepted permission');
    }
  }

  Manufacturer? _checkManufacturer() {
    return Manufacturer.values.asNameMap()[deviceInfo.manufacturer.toLowerCase()];
  }
}
