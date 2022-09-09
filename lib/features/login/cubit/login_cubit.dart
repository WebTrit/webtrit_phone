import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

import '../login.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    this.httpClient,
  }) : super(const LoginState());

  final HttpClient? httpClient;

  void next() {
    var nextTabIndex = state.tabIndex + 1;
    if (nextTabIndex == 1 && state.coreUrl != null) {
      nextTabIndex++;
    }
    emit(state.copyWith(
      tabIndex: nextTabIndex,
      status: LoginStatus.input,
    ));
  }

  void back() {
    var prevTabIndex = state.tabIndex - 1;
    if (prevTabIndex == 1 && state.coreUrlInput.value.isEmpty) {
      prevTabIndex--;
    }
    emit(state.copyWith(
      tabIndex: prevTabIndex,
      status: LoginStatus.input,
    ));
  }

  void dismissError() {
    emit(state.copyWith(
      error: null,
    ));
  }

  // LoginModeSelectTab

  void loginModeSelectSubmitter(bool demo) {
    final coreUrl = demo
        ? EnvironmentConfig.DEMO_CORE_URL
        : EnvironmentConfig.CORE_URL.isEmpty
            ? null
            : EnvironmentConfig.CORE_URL;

    emit(LoginState(
      status: LoginStatus.ok,
      coreUrl: coreUrl,
    ));
  }

  // LoginCoreUrlAssignTab

  void loginCoreUrlAssignCoreUrlInputChanged(String value) {
    emit(state.copyWith(
      coreUrlInput: UrlInput.dirty(value),
    ));
  }

  void loginCoreUrlAssignSubmitted() async {
    if (!state.status.isInput || !state.coreUrlInput.valid) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.processing,
    ));

    var coreUrlInputValue = state.coreUrlInput.value;
    if (!coreUrlInputValue.startsWith('https://')) {
      coreUrlInputValue = 'https://$coreUrlInputValue';
    }
    final coreUrl = Uri.parse(coreUrlInputValue);
    final webtritApiClient = WebtritApiClient(coreUrl, customHttpClient: httpClient);
    try {
      final info = await webtritApiClient.info();
      if (info.core.version > Version(0, 3, 0)) {
        emit(state.copyWith(
          status: LoginStatus.ok,
          coreUrl: coreUrl.toString(),
        ));
      } else {
        emit(state.copyWith(
          status: LoginStatus.input,
          error: const LoginIncompatibleCoreVersionException(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.input,
        error: e,
      ));
    }
  }

  void loginCoreUrlAssignBack() async {
    if (state.status != LoginStatus.input) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.back,
      coreUrl: null,
      coreUrlInput: const UrlInput.pure(),
    ));
  }

  // LoginOtpRequestTab

  void loginOptRequestPhoneInputChanged(String value) {
    emit(state.copyWith(
      phoneInput: PhoneInput.dirty(value),
    ));
  }

  void loginOptRequestSubmitted() async {
    if (!state.status.isInput || !state.phoneInput.valid) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.processing,
    ));

    final coreUrl = Uri.parse(state.coreUrl!);
    final webtritApiClient = WebtritApiClient(coreUrl, customHttpClient: httpClient);
    final type = PlatformInfo().appType;
    final identifier = DeviceInfo().identifierForVendor;
    final phone = state.phoneInput.value;
    try {
      final otpId = await webtritApiClient.sessionOtpRequest(type, identifier, phone);
      emit(state.copyWith(
        status: LoginStatus.ok,
        otpId: otpId,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.input,
        error: e,
      ));
    }
  }

  void loginOptRequestBack() async {
    if (state.status != LoginStatus.input) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.back,
      phoneInput: const PhoneInput.pure(),
    ));
  }

  // LoginOtpVerifyTab

  void loginOptVerifyCodeInputChanged(String value) {
    emit(state.copyWith(
      codeInput: CodeInput.dirty(value),
    ));
  }

  void loginOptVerifySubmitted() async {
    if (state.status != LoginStatus.input || !state.codeInput.valid) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.processing,
    ));

    final coreUrl = Uri.parse(state.coreUrl!);
    final webtritApiClient = WebtritApiClient(coreUrl, customHttpClient: httpClient);
    final otpId = state.otpId!;
    final code = state.codeInput.value;
    try {
      final token = await webtritApiClient.sessionOtpVerify(otpId, code);
      emit(state.copyWith(
        status: LoginStatus.ok,
        token: token,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.input,
        error: e,
      ));
    }
  }

  void loginOptVerifyBack() async {
    if (state.status != LoginStatus.input) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.back,
      codeInput: const CodeInput.pure(),
    ));
  }
}

class LoginIncompatibleCoreVersionException implements Exception {
  const LoginIncompatibleCoreVersionException();
}
