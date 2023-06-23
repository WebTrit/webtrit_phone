import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';

import '../login.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

typedef WebtritApiClientFactory = WebtritApiClient Function(String coreUrl);

WebtritApiClient defaultCreateWebtritApiClient(String coreUrl) {
  return WebtritApiClient(Uri.parse(coreUrl), connectionTimeout: kApiClientConnectionTimeout);
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
    LoginStep step, {
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
  }) : super(LoginState(step: step));

  final WebtritApiClientFactory createWebtritApiClient;

  String? get coreUrlFromEnvironment {
    return EnvironmentConfig.CORE_URL.isEmpty ? null : EnvironmentConfig.CORE_URL;
  }

  String? get demoCoreUrlFromEnvironment {
    return EnvironmentConfig.DEMO_CORE_URL.isEmpty ? null : EnvironmentConfig.DEMO_CORE_URL;
  }

  bool get isDemoModeEnabled => coreUrlFromEnvironment == null;

  void next() {
    var nextStepIndex = state.step.index + 1;
    if (nextStepIndex == 1 && state.coreUrl != null) {
      nextStepIndex++;
    }
    emit(state.copyWith(
      step: LoginStep.values[nextStepIndex],
      status: LoginStatus.input,
    ));
  }

  void back() {
    var prevStepIndex = state.step.index - 1;
    if (prevStepIndex == 1 && state.coreUrlInput.value.isEmpty) {
      prevStepIndex--;
    }
    final effectivePrevStep = prevStepIndex >= 0 ? LoginStep.values[prevStepIndex] : state.step;
    emit(state.copyWith(
      step: effectivePrevStep,
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
        await _verifyCoreVersion(createWebtritApiClient(coreUrl));
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
    if (!state.status.isInput || !state.coreUrlInput.isValid) {
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
      await _verifyCoreVersion(createWebtritApiClient(coreUrlInputValue));
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
    if (!state.status.isInput || !(state.demo ? state.emailInput.isValid : state.phoneInput.isValid)) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.processing,
    ));
    try {
      if (state.demo) {
        final response = await _createUserRequest(createWebtritApiClient(state.coreUrl!), state.emailInput.value);
        if (response is SessionOtpResponse) {
          emit(state.copyWith(
            status: LoginStatus.ok,
            sessionOtpResponse: response,
          ));
        } else if (response is SessionAuthorizedResponse) {
          // TODO: Add logic for navigate authorized user
        } else {
          // TODO: Add logic for navigate to undefine page
        }
      } else {
        final response = await _sessionOtpRequest(createWebtritApiClient(state.coreUrl!), state.phoneInput.value);
        emit(state.copyWith(
          status: LoginStatus.ok,
          sessionOtpResponse: response,
        ));
      }
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
    if (state.status != LoginStatus.input || !state.codeInput.isValid) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.processing,
    ));
    try {
      final verifyData = await _sessionOtpVerify(
        createWebtritApiClient(state.coreUrl!),
        state.sessionOtpResponse!.otpId,
        state.codeInput.value,
      );

      emit(state.copyWith(
        status: LoginStatus.ok,
        token: verifyData.token,
        tenantId: verifyData.tenantId,
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
      sessionOtpResponse: null,
      codeInput: const CodeInput.pure(),
    ));
  }

  void loginOptVerifyRepeat() async {
    if (state.status != LoginStatus.input) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.processing,
    ));

    // TODO: Part of duplicate code with method loginOptRequestSubmitted
    try {
      if (state.demo) {
        final response = await _createUserRequest(createWebtritApiClient(state.coreUrl!), state.emailInput.value);
        if (response is SessionOtpResponse) {
          emit(state.copyWith(
            status: LoginStatus.ok,
            sessionOtpResponse: response,
          ));
        } else if (response is SessionAuthorizedResponse) {
          // TODO: Add logic for navigate authorized user
        } else {
          // TODO: Add logic for navigate to undefine page
        }
      } else {
        final response = await _sessionOtpRequest(createWebtritApiClient(state.coreUrl!), state.phoneInput.value);
        emit(state.copyWith(
          status: LoginStatus.ok,
          sessionOtpResponse: response,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.input,
        error: e,
      ));
    }
  }
}

Future<void> _verifyCoreVersion(
  WebtritApiClient webtritApiClient,
) async {
  final actualCoreVersion = (await webtritApiClient.info()).core.version;
  CoreVersion.supported().verify(actualCoreVersion);
}

Future<BaseSessionResponse> _createUserRequest(
  WebtritApiClient webtritApiClient,
  String email,
) async {
  return await webtritApiClient.createUser(UserSignupCredentials(
    type: PlatformInfo().appType,
    identifier: AppInfo().identifier,
    email: email,
  ));
}

Future<SessionOtpResponse> _sessionOtpRequest(
  WebtritApiClient webtritApiClient,
  String phone,
) async {
  return await webtritApiClient.sessionOtpRequest(SessionOtpCredential(
    type: PlatformInfo().appType,
    identifier: AppInfo().identifier,
    phone: phone,
  ));
}

Future<SessionAuthorizedResponse> _sessionOtpVerify(
  WebtritApiClient webtritApiClient,
  String otpId,
  String code,
) async {
  return await webtritApiClient.sessionOtpVerify(otpId, code);
}
