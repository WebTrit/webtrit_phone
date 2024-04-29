import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/data.dart';

part 'permissions_cubit.freezed.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit({
    required this.appPermissions,
    required this.deviceInfo,
  }) : super(const PermissionsState.initial());

  final AppPermissions appPermissions;
  final DeviceInfo deviceInfo;

  void requestPermissions() async {
    emit(const PermissionsState.inProgress());
    try {
      await appPermissions.request();
      await requestFirebaseMessagingPermission();

      final subPlatform = _checkManufacturer();
      if (subPlatform == null) {
        emit(const PermissionsState.success());
      } else {
        emit(PermissionsState.subPlatformTipNeeded(subPlatform));
      }
    } catch (e) {
      emit(PermissionsState.failure(e));
    }
  }

  void dismissError() {
    emit(const PermissionsState.initial());
  }

  void dismissSubPlatformTip() {
    emit(const PermissionsState.success());
  }

  void openAppSettings() {
    appPermissions.toAppSettings();
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
    return Manufacturer.values.asNameMap()[deviceInfo.manufacturer?.toLowerCase()];
  }
}
