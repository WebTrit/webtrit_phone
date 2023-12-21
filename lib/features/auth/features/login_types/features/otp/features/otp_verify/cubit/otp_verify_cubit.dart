import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/auth/auth.dart';

import '../models/models.dart';

part 'otp_verify_state.dart';

part 'otp_verify_cubit.freezed.dart';

class OtpVerifyCubit extends Cubit<OtpVerifyState> {
  OtpVerifyCubit(String email, String phone, AuthCubit authCubit,
      {@visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient})
      : super(OtpVerifyState(
          phone: phone,
          email: email,
          coreUrl: authCubit.state.url,
        )) {
    _loginOptVerify();
  }

  final WebtritApiClientFactory createWebtritApiClient;

  void loginOptVerifyCodeInputChanged(String value) {
    emit(state.copyWith(
      codeInput: CodeInput.dirty(value),
    ));
  }

  void loginOptVerifyRepeat() => _loginOptVerify();

  void loginOptVerifySubmitted() async {
    if (!state.codeInput.isValid) {
      return;
    }

    emit(state.copyWith(
      status: OtpVerifyStatus.processing,
    ));
    try {
      final client = createWebtritApiClient(state.coreUrl!, '');
      final sessionToken = await _sessionOtpVerify(client, state.sessionOtpProvisional!, state.codeInput.value);

      emit(state.copyWith(
        status: OtpVerifyStatus.ok,
        tenantId: sessionToken.tenantId ?? state.tenantId!,
        token: sessionToken.token,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: OtpVerifyStatus.error,
        error: e,
      ));
    }
  }

  void _loginOptVerify() async {
    emit(state.copyWith(
      status: OtpVerifyStatus.processing,
    ));

    try {
      final SessionResult result;
      final client = createWebtritApiClient(state.coreUrl!, '');
      if (state.email.isNotEmpty) {
        result = await _createUserRequest(client, state.email);
      } else {
        result = await _sessionOtpRequest(client, state.phone);
      }
      if (result is SessionOtpProvisional) {
        emit(state.copyWith(
          status: null,
          tenantId: result.tenantId,
          sessionOtpProvisional: result,
        ));
      } else if (result is SessionToken) {
        // TODO: Add logic for navigate authorized user
        throw UnimplementedError();
      } else {
        // TODO: Add logic for navigate to undefine page
        throw UnimplementedError();
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: OtpVerifyStatus.error,
        error: e,
      ));
    }
  }

  Future<SessionResult> _createUserRequest(
    WebtritApiClient webtritApiClient,
    String email,
  ) async {
    return await webtritApiClient.createUser(SessionUserCredential(
      bundleId: PackageInfo().packageName,
      type: PlatformInfo().appType,
      identifier: AppInfo().identifier,
      email: email,
    ));
  }

  Future<SessionOtpProvisional> _sessionOtpRequest(
    WebtritApiClient webtritApiClient,
    String phone,
  ) async {
    return await webtritApiClient.createSessionOtp(SessionOtpCredential(
      bundleId: PackageInfo().packageName,
      type: PlatformInfo().appType,
      identifier: AppInfo().identifier,
      userRef: phone,
    ));
  }

  Future<SessionToken> _sessionOtpVerify(
    WebtritApiClient webtritApiClient,
    SessionOtpProvisional sessionOtpProvisional,
    String code,
  ) async {
    return await webtritApiClient.verifySessionOtp(sessionOtpProvisional, code);
  }
}
