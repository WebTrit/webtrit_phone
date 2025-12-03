import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/repositories/contacts_agreement_status/contacts_agreement_status_repository.dart';

import '../models/models.dart';

part 'permissions_cubit.freezed.dart';

part 'permissions_state.dart';

final _logger = Logger('PermissionsCubit');

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit({
    required this.contactsAgreementStatusRepository,
    required this.appPermissions,
    required this.deviceInfo,
  }) : super(const PermissionsState());

  final ContactsAgreementStatusRepository contactsAgreementStatusRepository;
  final AppPermissions appPermissions;
  final DeviceInfo deviceInfo;

  void requestPermissions() async {
    _logger.info('Requesting permissions');

    // Set loading state to disable UI interaction and prevent concurrent permission requests.
    emit(state.copyWith(isRequesting: true));

    try {
      // Request permissions, excluding the specified ones
      await appPermissions.request();
      _logger.info('Permissions requested');

      await _requestFirebaseMessagingPermission();
      _logger.info('Firebase messaging permission requested');

      // Handle special permissions
      final specialPermissionsStatuses = await appPermissions.getSpecialPermissionStatuses();
      final specialPendingPermissions = specialPermissionsStatuses.entries
          .where((entry) => entry.value.isDenied)
          .map((entry) => entry.key)
          .toList();
      _logger.info('Denied special permissions: $specialPendingPermissions');

      // Check for manufacturer-specific tips or denied special permissions
      final manufacturer = _checkManufacturer();
      _logger.info('Manufacturer: $manufacturer');

      final manufacturerTip = _getManufacturerTIp(manufacturer, specialPendingPermissions);
      _logger.info('Manufacturer tip: $manufacturerTip');

      if (isClosed) return;

      // Emit state at the end to ensure all dependent UI elements are initialized.
      // If emitted earlier, state listeners might trigger navigation before the widget tree is ready.
      emit(
        state.copyWith(
          hasRequestedPermissions: true,
          manufacturerTip: manufacturerTip,
          pendingSpecialPermissions: specialPendingPermissions,
        ),
      );
    } catch (e, st) {
      _logger.severe('Permission request failed', e, st);
      if (!isClosed) emit(state.copyWith(failure: e));
    } finally {
      // Ensure the loading state is reset whether the request succeeds or fails.
      if (!isClosed) emit(state.copyWith(isRequesting: false));
    }
  }

  ManufacturerTip? _getManufacturerTIp(
    Manufacturer? manufacturer,
    List<CallkeepSpecialPermissions> specialPermissions,
  ) {
    final hasManufacturer = manufacturer != null;
    final currentTip = state.manufacturerTip;

    // Determine if we need to set or keep the manufacturer tip
    return currentTip ?? (hasManufacturer ? ManufacturerTip(manufacturer: manufacturer) : null);
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
    emit(state.copyWith(failure: null));
  }

  void dismissTip() {
    emit(
      state.copyWith(
        hasRequestedPermissions: false,
        manufacturerTip: state.manufacturerTip?.copyWith(shown: true),
        pendingSpecialPermissions: [],
      ),
    );
  }

  void openAppSettings() {
    appPermissions.toAppSettings();
  }

  void openAppSpecialPermissionSettings(CallkeepSpecialPermissions permission) {
    appPermissions.toSpecialPermissionsSetting(permission);
  }
}
