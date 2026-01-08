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
  PermissionsCubit({required this.appPermissions, required this.deviceInfo}) : super(const PermissionsState());

  final AppPermissions appPermissions;

  final DeviceInfo deviceInfo;

  /// Verifies the current permission status without triggering a system prompt.
  ///
  /// This is primarily used when the app resumes from the background ([AppLifecycleState.resumed]).
  /// It handles the scenario where a user is sent to system settings to manually grant permissions
  /// and then returns to the app.
  ///
  /// Updates [isPermanentlyDenied] to reflect if permissions are still missing,
  /// allowing the UI to switch between the "Request" button and the "Open Settings" button.
  void checkPermissions() async {
    final isDenied = await appPermissions.isDenied;
    _logger.info('Is denied: $isDenied');

    final missingSpecialPermissions = await _getDeniedSpecialPermissions();
    _logger.info('Denied special permissions: $missingSpecialPermissions');

    emit(state.copyWith(isPermanentlyDenied: isDenied, missingSpecialPermissions: missingSpecialPermissions));
  }

  /// Executes the comprehensive permission request sequence:
  ///
  /// 1. **Standard Permissions:** Requests core app permissions (excluding specific cases).
  /// 2. **Firebase:** Initializes and requests notification permissions.
  /// 3. **Special Permissions:** Identifies denied special permissions (e.g., battery optimization).
  ///    Since these cannot be requested via a system modal, this triggers UI instructions/settings.
  /// 4. **Manufacturer Tips:** Resolves specific tips (e.g., for Xiaomi/Samsung) which the user can dismiss.
  /// 5. **Final Check:** Evaluates [isDenied]. If true (minimum requirements not met),
  ///    it triggers the UI to prompt the user to open system settings manually.
  void initiatePermissionFlow() async {
    _logger.info('Requesting permissions');

    // Set loading state to disable UI interaction and prevent concurrent permission requests.
    emit(state.copyWith(isRequesting: true));

    try {
      final requestedPermissions = await appPermissions.request();
      _logger.info('Permissions requested: ${requestedPermissions.values}');

      await _requestFirebaseMessagingPermission();
      _logger.info('Firebase messaging permission requested');

      final missingSpecialPermissions = await _getDeniedSpecialPermissions();
      _logger.info('Denied special permissions: $missingSpecialPermissions');

      final manufacturer = _checkManufacturer();
      _logger.info('Manufacturer: $manufacturer');

      final manufacturerTip = _getManufacturerTip(manufacturer, missingSpecialPermissions);
      _logger.info('Manufacturer tip: $manufacturerTip');

      final isDenied = await appPermissions.isDenied;

      if (isClosed) return;

      // Emit state at the end to ensure all dependent UI elements are initialized.
      // If emitted earlier, state listeners might trigger navigation before the widget tree is ready.
      emit(
        state.copyWith(
          initialRequestCompleted: true,
          isPermanentlyDenied: isDenied,
          manufacturerTip: manufacturerTip,
          missingSpecialPermissions: missingSpecialPermissions,
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

  ManufacturerTip? _getManufacturerTip(
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

  /// Fetches the list of special permissions that are currently denied by the user.
  /// This is used to identify which specific special permissions need to be requested or have their settings opened.
  Future<List<CallkeepSpecialPermissions>> _getDeniedSpecialPermissions() async {
    final specialPermissionsStatuses = await appPermissions.getSpecialPermissionStatuses();
    return specialPermissionsStatuses.entries.where((entry) => entry.value.isDenied).map((entry) => entry.key).toList();
  }

  /// Checks the device's manufacturer and maps it to a known [Manufacturer] enum value.
  /// This is used to provide manufacturer-specific instructions or tips for enabling permissions.
  /// Returns `null` if the manufacturer is not in the predefined list.
  Manufacturer? _checkManufacturer() {
    return Manufacturer.values.asNameMap()[deviceInfo.manufacturer.toLowerCase()];
  }

  void dismissError() {
    emit(state.copyWith(failure: null));
  }

  void dismissManufacturerTip() {
    emit(state.copyWith(manufacturerTip: state.manufacturerTip?.copyWith(shown: true)));
  }

  void openAppSettings() {
    appPermissions.toAppSettings();
  }

  void openAppSpecialPermissionSettings(CallkeepSpecialPermissions permission) {
    appPermissions.toSpecialPermissionsSetting(permission);
  }
}
