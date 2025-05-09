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
  }) : super(const PermissionsState());

  final AppPreferences appPreferences;
  final AppPermissions appPermissions;
  final DeviceInfo deviceInfo;

  void requestPermissions() async {
    _logger.info('Requesting permissions');

    try {
      // Prepare the exclude list based on the contacts agreement status
      final excludePermissions = _buildExcludedPermissions();

      // Request permissions, excluding the specified ones
      await appPermissions.request(exclude: excludePermissions);
      _logger.info('Permissions requested');

      await _requestFirebaseMessagingPermission();
      _logger.info('Firebase messaging permission requested');

      // Update the state to indicate that permissions have been requested
      emit(state.copyWith(hasRequestedPermissions: true));

      // Handle special permissions
      final specialPermissions = await appPermissions.deniedSpecialPermissions();
      _logger.info('Denied special permissions: $specialPermissions');

      // Check for manufacturer-specific tips or denied special permissions
      final manufacturer = _checkManufacturer();
      _logger.info('Manufacturer: $manufacturer');

      _handleSpecialPermission(manufacturer, specialPermissions);
    } catch (e, st) {
      _logger.severe('Permission request failed', e, st);
      emit(state.copyWith(failure: e));
    }
  }

  void _handleSpecialPermission(
    Manufacturer? manufacturer,
    List<CallkeepSpecialPermissions> specialPermissions,
  ) {
    final hasManufacturer = manufacturer != null;
    final currentTip = state.manufacturerTip;

    // Determine if we need to set or keep the manufacturer tip
    final tip = currentTip ?? (hasManufacturer ? ManufacturerTip(manufacturer: manufacturer) : null);

    emit(state.copyWith(
      pendingSpecialPermissions: specialPermissions,
      manufacturerTip: tip,
    ));
    }

  List<Permission> _buildExcludedPermissions() {
    final contactsAgreementStatus = appPreferences.getContactsAgreementStatus();
    _logger.info('Contacts agreement status: ${contactsAgreementStatus.isAccepted}');

    final exclude = <Permission>[
      if (!contactsAgreementStatus.isAccepted) Permission.contacts,
    ];

    _logger.info('Excluding permissions: $exclude');
    return exclude;
  }

  Future<void> _requestFirebaseMessagingPermission() async {
    final notificationSettings = await FirebaseMessaging.instance.requestPermission();
    if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
      _logger.info('User granted firebase permission');
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
      _logger.info('User granted  firebase provisional permission');
    } else {
      _logger.info('User declined or has not accepted firebase permission');
    }
  }

  Manufacturer? _checkManufacturer() {
    return Manufacturer.values.asNameMap()[deviceInfo.manufacturer.toLowerCase()];
  }

  void dismissError() {
    emit(const PermissionsState());
  }

  void dismissTip() {
    emit(state.copyWith(
      manufacturerTip: state.manufacturerTip?.copyWith(shown: true),
    ));
  }

  void openAppSettings() {
    appPermissions.toAppSettings();
  }

  void openAppSpecialPermissionSettings(CallkeepSpecialPermissions permission) {
    appPermissions.toSpecialPermissionsSetting(permission);
  }
}
