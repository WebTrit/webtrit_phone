import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/data/app_permissions.dart';

part 'permissions_cubit.freezed.dart';

part 'permissions_state.dart';

class PermissionsCubit extends Cubit<PermissionsState> {
  PermissionsCubit({
    required this.appPermissions,
  }) : super(const PermissionsState());

  final AppPermissions appPermissions;

  void requestPermissions() async {
    emit(state.copyWith(status: PermissionsStatus.inProgress));
    try {
      await appPermissions.request();
      await requestFirebaseMessagingPermission();
      emit(state.copyWith(status: PermissionsStatus.success));
    } catch (e) {
      emit(state.copyWith(status: PermissionsStatus.failure));
    }
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
}
