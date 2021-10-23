import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/data/data.dart';

import '../login.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.webtritApiClient,
    required this.secureStorage,
  }) : super(const LoginState());

  final WebtritApiClient webtritApiClient;
  final SecureStorage secureStorage;

  void next() {
    emit(state.copyWith(
      tabIndex: state.tabIndex + 1,
      status: LoginStatus.input,
    ));
  }

  void back() {
    emit(state.copyWith(
      tabIndex: state.tabIndex - 1,
      status: LoginStatus.input,
    ));
  }

  void dismisError() {
    emit(state.copyWith(
      error: LoginState.noError,
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

    final type = _appType;
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

    final otpId = state.otpId!;
    final code = state.codeInput.value;
    try {
      final token = await webtritApiClient.sessionOtpVerify(otpId, code);
      await SecureStorage().writeToken(token);
      emit(state.copyWith(
        status: LoginStatus.ok,
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

  //

  AppType get _appType {
    if (Platform.isAndroid) {
      return AppType.android;
    } else if (Platform.isIOS) {
      return AppType.ios;
    } else {
      throw UnsupportedError('platform not supported');
    }
  }
}
