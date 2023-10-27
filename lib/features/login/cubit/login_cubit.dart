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

typedef WebtritApiClientFactory = WebtritApiClient Function(String coreUrl, String tenantId);

WebtritApiClient defaultCreateWebtritApiClient(String coreUrl, String tenantId) {
  return WebtritApiClient(Uri.parse(coreUrl), tenantId, connectionTimeout: kApiClientConnectionTimeout);
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

  String get defaultTenantId => '';

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
    final tenantId = defaultTenantId;

    if (coreUrl != null) {
      emit(state.copyWith(
        status: LoginStatus.processing,
      ));
      try {
        final client = createWebtritApiClient(coreUrl, tenantId);
        await _checkSystemInfo(client);
        emit(state.copyWith(
          status: LoginStatus.ok,
          coreUrl: coreUrl,
          tenantId: tenantId,
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
    final tenantId = defaultTenantId;
    try {
      final client = createWebtritApiClient(coreUrlInputValue, tenantId);
      await _checkSystemInfo(client);
      emit(state.copyWith(
        status: LoginStatus.ok,
        coreUrl: coreUrlInputValue,
        tenantId: tenantId,
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
      final SessionResult result;
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      if (state.demo) {
        result = await _createUserRequest(client, state.emailInput.value);
      } else {
        result = await _sessionOtpRequest(client, state.phoneInput.value);
      }
      if (result is SessionOtpProvisional) {
        emit(state.copyWith(
          status: LoginStatus.ok,
          sessionOtpProvisional: result,
        ));
      } else if (result is SessionToken) {
        // TODO: Add logic for navigate authorized user
        throw UnimplementedError();
      } else {
        // TODO: Add logic for navigate to undefine page
        throw UnimplementedError();
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
      tenantId: null,
      emailInput: const EmailInput.pure(),
      phoneInput: const PhoneInput.pure(),
    ));
  }

  // LoginPasswordRequestTab

  void loginCredentialRequestLoginInputChanged(String value) {
    emit(state.copyWith(
      loginInput: LoginInput.dirty(value),
    ));
  }

  void loginCredentialRequestPasswordInputChanged(String value) {
    emit(state.copyWith(
      passwordInput: PasswordInput.dirty(value),
    ));
  }

  void loginPasswordRequestSubmitted() async {
    emit(state.copyWith(
      status: LoginStatus.processing,
    ));

    try {
      var sessionToken = await createWebtritApiClient(
        demoCoreUrlFromEnvironment!,
        EnvironmentConfig.DEFAULT_PASSWORD_TYPE_LOGIN_TENANT,
      ).createSession(
        SessionLoginCredential(
          bundleId: PackageInfo().packageName,
          type: PlatformInfo().appType,
          identifier: AppInfo().identifier,
          login: state.loginInput.value,
          password: state.passwordInput.value,
        ),
      );

      emit(state.copyWith(
        tenantId: EnvironmentConfig.DEFAULT_PASSWORD_TYPE_LOGIN_TENANT,
        token: sessionToken.token,
        status: LoginStatus.ok,
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
    if (state.status != LoginStatus.input || !state.codeInput.isValid) {
      return;
    }

    emit(state.copyWith(
      status: LoginStatus.processing,
    ));
    try {
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      final sessionToken = await _sessionOtpVerify(client, state.sessionOtpProvisional!, state.codeInput.value);

      emit(state.copyWith(
        status: LoginStatus.ok,
        tenantId: sessionToken.tenantId ?? state.tenantId!,
        token: sessionToken.token,
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
      sessionOtpProvisional: null,
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
      final SessionResult result;
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      if (state.demo) {
        result = await _createUserRequest(client, state.emailInput.value);
      } else {
        result = await _sessionOtpRequest(client, state.phoneInput.value);
      }
      if (result is SessionOtpProvisional) {
        emit(state.copyWith(
          status: LoginStatus.input,
          sessionOtpProvisional: result,
        ));
      } else if (result is SessionToken) {
        // TODO: Add logic for navigate authorized user
        throw UnimplementedError();
      } else {
        // TODO: Add logic for navigate to undefine page
        throw UnimplementedError();
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.input,
        error: e,
      ));
    }
  }

  Future<void> _checkSystemInfo(
    WebtritApiClient webtritApiClient,
  ) async {
    final systemInfo = await webtritApiClient.getSystemInfo();

    final actualCoreVersion = systemInfo.core.version;
    CoreVersion.supported().verify(actualCoreVersion);

    final adapterSupportedLogin = systemInfo.adapter!.supported;
    final phoneSupportedLogin = adapterSupportedLogin
        .map((type) {
          if (type == LoginType.otpSignin) {
            return SupportedLogin.otpSignIn;
          } else if (type == LoginType.passwordSignin) {
            return SupportedLogin.passwordSignIn;
          }
        })
        .nonNulls
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    emit(state.copyWith(supportedLogin: phoneSupportedLogin));
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
