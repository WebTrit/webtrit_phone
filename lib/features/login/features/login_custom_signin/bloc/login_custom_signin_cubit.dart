import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/login/models/notifications.dart';

part 'login_custom_signin_state.dart';

part 'login_custom_signin_cubit.freezed.dart';

class LoginCustomSigninCubit extends Cubit<LoginCustomSigninState> {
  LoginCustomSigninCubit(this.notificationsBloc) : super(const LoginCustomSigninState());

  final NotificationsBloc notificationsBloc;

  void manageScriptChannelsData(String data) {
    try {
      final token = SessionToken.fromJson(jsonDecode(data));
      emit(state.copyWith(sessionToken: token));
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }
}
