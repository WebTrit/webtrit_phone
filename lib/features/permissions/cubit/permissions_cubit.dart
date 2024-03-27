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
    required this.appPreferences,
  }) : super(PermissionsState(userAgreementAccepted: appPreferences.getUserAgreementAccepted()));

  final AppPermissions appPermissions;
  final AppPreferences appPreferences;

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

  void changeUserAgreement(bool userAgreementAccepted) async {
    await appPreferences.setUserAgreementAccepted(userAgreementAccepted);
    emit(state.copyWith(userAgreementAccepted: userAgreementAccepted));
  }

  void dismissError() {
    emit(state.copyWith(
      error: null,
      status: PermissionsStatus.initial,
    ));
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
