import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:webtrit_api/webtrit_api.dart';
import 'package:webtrit_phone/data/data.dart';

import '../login.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.webtritApiClient,
  }) : super(const LoginState());

  final WebtritApiClient webtritApiClient;

  void next() {
    var nextTabIndex = state.tabIndex + 1;
    if (nextTabIndex == 1 && state.demo == true) {
      nextTabIndex++;
    }
    emit(state.copyWith(
      tabIndex: nextTabIndex,
      status: LoginStatus.input,
    ));
  }

  void back() {
    var prevTabIndex = state.tabIndex - 1;
    if (prevTabIndex == 1 && state.demo == true) {
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
    emit(LoginState(
      status: LoginStatus.ok,
      demo: demo,
    ));
  }

  // LoginCoreUrlAssignTab

  void loginCoreUrlAssignCoreUrlInputChanged(String value) {
    emit(state.copyWith(
      coreUrlInput: UrlInput.dirty(value),
    ));
  }

  void loginCoreUrlAssignSubmitted() async {
    // TODO: implement correct behaviour
    emit(state.copyWith(
      error: 'Sorry, not implemented yet',
    ));
  }

  void loginCoreUrlAssignBack() async {
    if (state.status != LoginStatus.input) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.back,
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
