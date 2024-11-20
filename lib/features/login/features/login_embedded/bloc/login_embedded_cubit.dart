import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/utils/utils.dart';

part 'login_embedded_state.dart';

part 'login_embedded_cubit.freezed.dart';

class LoginEmbeddedCubit extends Cubit<LoginEmbeddedState> {
  LoginEmbeddedCubit(
    this.notificationsBloc,
    this.loginCubit, {
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
  }) : super(const LoginEmbeddedState());

  final NotificationsBloc notificationsBloc;
  final LoginCubit loginCubit;

  final WebtritApiClientFactory createWebtritApiClient;

  void loginByNumber(String number) async {
    final url = loginCubit.state.coreUrl!;
    final tenantId = loginCubit.defaultTenantId;
    final client = createWebtritApiClient(url, tenantId);

    final result = await _createUserRequest(client, number);

    if (result is SessionOtpProvisional) {
      emit(state.copyWith(
        //   processing: false,
        signupSessionOtpProvisionalWithDateTime: (result, DateTime.now()),
      ));
    } else if (result is SessionToken) {
      // does not set processing to false to hold processing widgets state during navigation
      emit(state.copyWith(
        tenantId: result.tenantId ?? state.tenantId!,
        token: result.token,
        // Use an empty user ID as a fallback for outdated core versions that do not support this field.
        userId: result.userId ?? '',
      ));
    } else {
      throw UnimplementedError();
    }
  }

  void verifyOtp(String otp) async {
    final url = loginCubit.state.coreUrl!;
    final tenantId = loginCubit.defaultTenantId;
    final client = createWebtritApiClient(url, tenantId);

    // try {
    //   final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
    final sessionToken = await _verifySessionOtp(client, state.signupSessionOtpProvisionalWithDateTime!.$1, otp);
    //
    //   // does not set processing to false to hold processing widgets state during navigation
    emit(state.copyWith(
      tenantId: sessionToken.tenantId ?? state.tenantId!,
      token: sessionToken.token,
      // Use an empty user ID as a fallback for outdated core versions that do not support this field.
      userId: sessionToken.userId ?? '',
    ));
    // } catch (e) {
    //   notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    //
    //   emit(state.copyWith(processing: false));
    // }
  }

  void login(String data) async {
    try {
      final sessionToken = _parseSessionToken(data);

      final url = loginCubit.state.coreUrl!;
      final tenantId = sessionToken.tenantId ?? loginCubit.defaultTenantId;

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

  Future<SessionResult> _createUserRequest(
    WebtritApiClient webtritApiClient,
    String number,
  ) async {
    return await webtritApiClient.createUserByNumber(SessionUserCredentialNumber(
      bundleId: PackageInfo().packageName,
      type: PlatformInfo().appType,
      identifier: AppInfo().identifier,
      phoneNumber: number,
    ));
  }

  Future<SessionToken> _verifySessionOtp(
    WebtritApiClient webtritApiClient,
    SessionOtpProvisional sessionOtpProvisional,
    String code,
  ) async {
    return await webtritApiClient.verifySessionOtp(sessionOtpProvisional, code);
  }
}
