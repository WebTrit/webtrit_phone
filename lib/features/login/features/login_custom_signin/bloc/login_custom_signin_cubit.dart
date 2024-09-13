import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'login_custom_signin_state.dart';

part 'login_custom_signin_cubit.freezed.dart';

class LoginCustomSigninCubit extends Cubit<LoginCustomSigninState> {
  LoginCustomSigninCubit(
    this.notificationsBloc,
    this.loginCubit, {
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
  }) : super(const LoginCustomSigninState());

  final NotificationsBloc notificationsBloc;
  final LoginCubit loginCubit;

  final WebtritApiClientFactory createWebtritApiClient;

  void login(String data) async {
    try {
      final sessionToken = _parseSessionToken(data);

      final url = loginCubit.state.coreUrl!;
      final tenantId = sessionToken.tenantId ?? loginCubit.defaultTenantId!;

      await createWebtritApiClient(url, tenantId).getUserInfo(sessionToken.token);

      loginCubit.loginSigninSubmitted(sessionToken);
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }

  SessionToken _parseSessionToken(String data) {
    try {
      return SessionToken.fromJson(jsonDecode(data));
    } catch (e) {
      throw Exception('Failed to parse web view response: $e');
    }
  }
}
