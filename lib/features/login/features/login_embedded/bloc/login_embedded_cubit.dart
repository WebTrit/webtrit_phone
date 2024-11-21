import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../../../../../environment_config.dart';

part 'login_embedded_state.dart';

part 'login_embedded_cubit.freezed.dart';

class LoginEmbeddedCubit extends Cubit<LoginEmbeddedState> {
  LoginEmbeddedCubit(
    this.notificationsBloc, {
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
  }) : super(const LoginEmbeddedState());

  final NotificationsBloc notificationsBloc;

  final WebtritApiClientFactory createWebtritApiClient;

  final url = EnvironmentConfig.CORE_URL ?? EnvironmentConfig.DEMO_CORE_URL;

  void loginByNumber(String number) async {
    final emptyTenant =number;
    final client = createWebtritApiClient(url!, emptyTenant);

    emit(state.copyWith(processing: true, coreUrl: url, tenantId: emptyTenant));

    try {
      final result = await _createUserRequest(client, number);

      if (result is SessionOtpProvisional) {
        emit(state.copyWith(
          processing: false,
          tenantId: result.tenantId ?? state.tenantId!,
          signupSessionOtpProvisionalWithDateTime: (result, DateTime.now()),
        ));
      } else if (result is SessionToken) {
        emit(state.copyWith(
          processing: false,
          tenantId: result.tenantId ?? state.tenantId!,
          token: result.token,
          userId: result.userId ?? '',
        ));
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      emit(state.copyWith(processing: false));

      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }

  void verifyOtp(String otp) async {
    final client = createWebtritApiClient(url, state.tenantId ?? '');

    emit(state.copyWith(processing: true));

    try {
      final sessionToken = await _verifySessionOtp(client, state.signupSessionOtpProvisionalWithDateTime!.$1, otp);

      emit(state.copyWith(
        tenantId: state.tenantId,
        token: sessionToken.token,
        userId: sessionToken.userId ?? '',
        processing: false,
      ));
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
  }

  void login(String data) async {}

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
    return await webtritApiClient.createUserByNumber(
        SessionUserCredentialNumber(
          bundleId: PackageInfo().packageName,
          type: PlatformInfo().appType,
          identifier: AppInfo().identifier,
          phoneNumber: number,
        ),
        options: const RequestOptions(retries: 1));
  }

  Future<SessionToken> _verifySessionOtp(
    WebtritApiClient webtritApiClient,
    SessionOtpProvisional sessionOtpProvisional,
    String code,
  ) async {
    return await webtritApiClient.verifySessionOtp(
      sessionOtpProvisional,
      code,
      options: const RequestOptions(retries: 1),
    );
  }
}
