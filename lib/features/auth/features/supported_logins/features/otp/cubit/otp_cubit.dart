import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/features/auth/auth.dart';

import '../models/code_input.dart';
import '../models/models.dart';

part 'otp_state.dart';

part 'otp_cubit.freezed.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(
    String coreUrl,
    bool demo,
    String defaultTenantId, {
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
  }) : super(OtpState(
          demo: demo,
          coreUrl: coreUrl,
          tenantId: defaultTenantId,
        ));

  final WebtritApiClientFactory createWebtritApiClient;

  void loginOptRequestEmailInputChanged(String value) {
    emit(state.copyWith(
      emailInput: EmailInput.dirty(value),
    ));
  }

  void loginOptRequestPhoneInputChanged(String value) {
    emit(state.copyWith(
      phoneInput: PhoneInput.dirty(value),
    ));
  }

  void loginOptRequestSubmitted() async {
    if (!(state.demo ? state.emailInput.isValid : state.phoneInput.isValid)) {
      return;
    }

    emit(state.copyWith(
      status: OtpStatus.processing,
    ));

    try {
      final SessionResult result;
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId);
      if (state.emailInput.value.isNotEmpty) {
        result = await _createUserRequest(client, state.emailInput.value);
      } else {
        result = await _sessionOtpRequest(client, state.phoneInput.value);
      }
      if (result is SessionOtpProvisional) {
        emit(state.copyWith(
          status: null,
          tenantId: result.tenantId ?? state.tenantId,
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
        status: OtpStatus.error,
        error: e,
      ));
    }
  }

  void loginOptVerifyCodeInputChanged(String value) {
    emit(state.copyWith(
      codeInput: CodeInput.dirty(value),
    ));
  }

  void loginOptVerifyRepeat() => loginOptRequestSubmitted();

  void loginOptVerifySubmitted() async {
    if (!state.codeInput.isValid) {
      return;
    }

    emit(state.copyWith(
      status: OtpStatus.processing,
    ));
    try {
      final client = createWebtritApiClient(
        state.coreUrl!,
        state.sessionOtpProvisional?.tenantId ?? state.tenantId,
      );
      final sessionToken = await _sessionOtpVerify(client, state.sessionOtpProvisional!, state.codeInput.value);

      emit(state.copyWith(
        status: OtpStatus.ok,
        tenantId: sessionToken.tenantId ?? state.tenantId,
        token: sessionToken.token,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: OtpStatus.error,
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
