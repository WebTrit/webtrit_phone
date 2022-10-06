import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String? get coreUrlFromEnvironment {
    return EnvironmentConfig.CORE_URL.isEmpty ? null : EnvironmentConfig.CORE_URL;
  }

  String? get demoCoreUrlFromEnvironment {
    return EnvironmentConfig.DEMO_CORE_URL.isEmpty ? null : EnvironmentConfig.DEMO_CORE_URL;
  }

  bool get isDemoModeEnabled => coreUrlFromEnvironment == null;

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

  void launchLinkableElement(LinkableElement link) async {
    final url = Uri.parse(link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  // LoginModeSelectTab

  void loginModeSelectSubmitter(bool demo) async {
    emit(state.copyWith(
      demo: demo,
    ));

    final coreUrl = demo ? demoCoreUrlFromEnvironment : coreUrlFromEnvironment;

    if (coreUrl != null) {
      emit(state.copyWith(
        status: LoginStatus.processing,
      ));
      try {
        await _verifyCoreVersion(Uri.parse(coreUrl));
        emit(state.copyWith(
          status: LoginStatus.ok,
          coreUrl: coreUrl,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: LoginStatus.input,
          error: e,
        ));
      }
    } else {
      emit(state.copyWith(
        status: LoginStatus.ok,
      ));
    }
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
    if (!coreUrlInputValue.startsWith(RegExp(r'(https|http)://'))) {
      coreUrlInputValue = 'https://$coreUrlInputValue';
    }
    try {
      await _verifyCoreVersion(Uri.parse(coreUrlInputValue));
      emit(state.copyWith(
        status: LoginStatus.ok,
        coreUrl: coreUrlInputValue,
      ));
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
      coreUrlInput: const UrlInput.pure(),
    ));
  }

  // LoginOtpRequestTab

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
    if (!state.status.isInput || !(state.demo ? state.emailInput.valid : state.phoneInput.valid)) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.processing,
    ));

    final webtritApiClient = WebtritApiClient(Uri.parse(state.coreUrl!), customHttpClient: httpClient);
    final type = PlatformInfo().appType;
    final identifier = DeviceInfo().identifierForVendor;
    try {
      late final otpId;
      if (state.demo) {
        final email = state.emailInput.value;
        otpId = await webtritApiClient.sessionOtpRequestDemo(type, identifier, email);
      } else {
        final phone = state.phoneInput.value;
        otpId = await webtritApiClient.sessionOtpRequest(type, identifier, phone);
      }
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
      coreUrl: null,
      emailInput: const EmailInput.pure(),
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

    final webtritApiClient = WebtritApiClient(Uri.parse(state.coreUrl!), customHttpClient: httpClient);
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

  Future<void> _verifyCoreVersion(Uri coreUrl) async {
    final webtritApiClient = WebtritApiClient(coreUrl, customHttpClient: httpClient);
    final actualVersion = (await webtritApiClient.info()).core.version;
    final expectVersion = Version(0, 4, 0);
    if (actualVersion >= expectVersion) {
      return;
    } else {
      throw LoginIncompatibleCoreVersionException(actualVersion, expectVersion);
    }
  }
}

class LoginIncompatibleCoreVersionException implements Exception {
  const LoginIncompatibleCoreVersionException(this.actual, this.expected);

  final Version actual;
  final Version expected;
}
