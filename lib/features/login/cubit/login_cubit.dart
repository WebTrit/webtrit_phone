import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/core_version.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../login.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
    required this.notificationsBloc,
  }) : super(const LoginState());

  final WebtritApiClientFactory createWebtritApiClient;
  final NotificationsBloc notificationsBloc;

  String? get coreUrlFromEnvironment => EnvironmentConfig.CORE_URL;

  String? get credentialsRequestUrl => EnvironmentConfig.APP_CREDENTIALS_REQUEST_URL;

  String? get demoCoreUrlFromEnvironment => EnvironmentConfig.DEMO_CORE_URL;

  String get defaultTenantId => '';

  bool get isDemoModeEnabled => coreUrlFromEnvironment == null;

  bool get isCredentialsRequestUrlEnabled => credentialsRequestUrl != null;

  void launchLinkableElement(LinkableElement link) async {
    final url = Uri.parse(link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _verifyCoreVersionAndRetrieveSupportedLoginTypesSubmitted(String coreUrl, String tenantId,
      [bool demo = false]) async {
    emit(state.copyWith(
      processing: true,
    ));

    try {
      final client = createWebtritApiClient(coreUrl, tenantId);
      final supportedLoginTypes = await _verifyCoreVersionAndRetrieveSupportedLoginTypes(client);
      if (demo) {
        supportedLoginTypes?.removeWhere((loginType) => loginType != LoginType.signup);
      }
      if (supportedLoginTypes != null && supportedLoginTypes.isNotEmpty) {
        emit(state.copyWith(
          processing: false,
          coreUrl: coreUrl,
          tenantId: tenantId,
          supportedLoginTypes: supportedLoginTypes,
        ));
      } else {
        notificationsBloc.add(const NotificationsSubmitted(SupportedLoginTypeMissedErrorNotification()));

        emit(state.copyWith(processing: false));
      }
    } on CoreVersionUnsupportedException catch (e) {
      notificationsBloc.add(NotificationsSubmitted(CoreVersionUnsupportedErrorNotification(
        e.actual.toString(),
        e.supportedConstraint.toString(),
      )));

      emit(state.copyWith(processing: false));
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
  }

  // LoginModeSelect

  void loginModeSelectSubmitted(LoginMode mode) async {
    emit(state.copyWith(
      mode: mode,
    ));

    final demo = mode == LoginMode.demoCore;
    final coreUrl = demo ? demoCoreUrlFromEnvironment : coreUrlFromEnvironment;

    if (mode == LoginMode.customSignIn) {
      emit(state.copyWith(coreUrl: coreUrl));
    } else if (coreUrl != null && mode != LoginMode.credentialsRequest) {
      await _verifyCoreVersionAndRetrieveSupportedLoginTypesSubmitted(coreUrl, defaultTenantId, demo);
    }
  }

  // LoginCoreUrlAssign

  void coreUrlInputChanged(String value) {
    emit(state.copyWith(
      coreUrlInput: UrlInput.dirty(value),
    ));
  }

  void loginCoreUrlAssignSubmitted() async {
    if (state.processing || !state.coreUrlInput.isValid) {
      return;
    }

    var coreUrlInputValue = state.coreUrlInput.value;
    if (!coreUrlInputValue.startsWith(RegExp(r'(https|http)://'))) {
      coreUrlInputValue = 'https://$coreUrlInputValue';
    }

    await _verifyCoreVersionAndRetrieveSupportedLoginTypesSubmitted(coreUrlInputValue, defaultTenantId);
  }

  void loginCoreUrlAssignBack() async {
    emit(state.copyWith(
      mode: null,
      coreUrlInput: const UrlInput.pure(),
    ));
  }

  void credentialsRequestUrlAssignBack() async {
    emit(state.copyWith(
      mode: null,
    ));
  }

  void customSigninAssignBack() async {
    emit(state.copyWith(
      mode: null,
    ));
  }

  // LoginSwitch

  void loginSwitchBack() async {
    emit(state.copyWith(
      mode: state.mode == LoginMode.customCore ? state.mode : null,
      coreUrl: null,
      tenantId: null,
      supportedLoginTypes: null,
      otpSigninSessionOtpProvisionalWithDateTime: null,
      passwordSigninPasswordInputObscureText: true,
      signupSessionOtpProvisionalWithDateTime: null,
      otpSigninUserRefInput: const UserRefInput.pure(),
      otpSigninCodeInput: const CodeInput.pure(),
      passwordSigninUserRefInput: const UserRefInput.pure(),
      passwordSigninPasswordInput: const PasswordInput.pure(),
      signupEmailInput: const EmailInput.pure(),
      signupCodeInput: const CodeInput.pure(),
    ));
  }

  // LoginOtpSigninRequest

  void otpSigninUserRefInputChanged(String value) {
    emit(state.copyWith(
      otpSigninUserRefInput: UserRefInput.dirty(value),
    ));
  }

  void loginOptSigninRequestSubmitted() async {
    if (state.processing || !state.otpSigninUserRefInput.isValid) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));

    try {
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      final sessionOtpProvisional = await _createSessionOtp(client, state.otpSigninUserRefInput.value);

      emit(state.copyWith(
        processing: false,
        otpSigninSessionOtpProvisionalWithDateTime: (sessionOtpProvisional, DateTime.now()),
      ));
    } catch (e) {
      emit(state.copyWith(processing: false));

      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }

  // LoginOtpSigninVerify

  void otpSigninCodeInputChanged(String value) {
    emit(state.copyWith(
      otpSigninCodeInput: CodeInput.dirty(value),
    ));
  }

  void loginOptSigninVerifySubmitted() async {
    if (state.processing || !state.otpSigninCodeInput.isValid) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));
    try {
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      final sessionToken = await _verifySessionOtp(
          client, state.otpSigninSessionOtpProvisionalWithDateTime!.$1, state.otpSigninCodeInput.value);

      // does not set processing to false to hold processing widgets state during navigation
      emit(state.copyWith(
        tenantId: sessionToken.tenantId ?? state.tenantId!,
        token: sessionToken.token,
      ));
    } catch (e) {
      emit(state.copyWith(processing: false));

      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }

  void loginOptSigninVerifyBack() async {
    emit(state.copyWith(
      otpSigninSessionOtpProvisionalWithDateTime: null,
      otpSigninCodeInput: const CodeInput.pure(),
    ));
  }

  void loginOptSigninVerifyRepeat() {
    loginOptSigninRequestSubmitted();
  }

  // LoginPasswordSignin

  void passwordSigninUserRefInputChanged(String value) {
    emit(state.copyWith(
      passwordSigninUserRefInput: UserRefInput.dirty(value),
    ));
  }

  void passwordSigninPasswordInputChanged(String value) {
    emit(state.copyWith(
      passwordSigninPasswordInput: PasswordInput.dirty(value),
    ));
  }

  void passwordSigninPasswordInputObscureTextToggled() {
    emit(state.copyWith(
      passwordSigninPasswordInputObscureText: !state.passwordSigninPasswordInputObscureText,
    ));
  }

  void loginPasswordSigninSubmitted() async {
    if (state.processing || !state.passwordSigninUserRefInput.isValid || !state.passwordSigninPasswordInput.isValid) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));

    try {
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      final sessionToken = await _createSessionRequest(
          client, state.passwordSigninUserRefInput.value, state.passwordSigninPasswordInput.value);

      // does not set processing to false to hold processing widgets state during navigation
      loginSigninSubmitted(sessionToken);
    } catch (e) {
      emit(state.copyWith(processing: false));

      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }

  void loginSigninSubmitted(SessionToken token) async {
    emit(state.copyWith(
      tenantId: token.tenantId ?? state.tenantId ?? defaultTenantId,
      token: token.token,
    ));
  }

  void loginPasswordSigninBack() async {
    emit(state.copyWith(
      passwordSigninUserRefInput: const UserRefInput.pure(),
      passwordSigninPasswordInput: const PasswordInput.pure(),
    ));
  }

  // LoginSignupRequest

  void signupEmailInputChanged(String value) {
    emit(state.copyWith(
      signupEmailInput: EmailInput.dirty(value),
    ));
  }

  void loginSignupRequestSubmitted() async {
    if (state.processing || !state.signupEmailInput.isValid) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));

    try {
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      final result = await _createUserRequest(client, state.signupEmailInput.value);

      if (result is SessionOtpProvisional) {
        emit(state.copyWith(
          processing: false,
          signupSessionOtpProvisionalWithDateTime: (result, DateTime.now()),
        ));
      } else if (result is SessionToken) {
        // does not set processing to false to hold processing widgets state during navigation
        emit(state.copyWith(
          tenantId: result.tenantId ?? state.tenantId!,
          token: result.token,
        ));
      } else {
        throw UnimplementedError();
      }
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
  }

  // LoginSignupVerify

  void signupCodeInputChanged(String value) {
    emit(state.copyWith(
      signupCodeInput: CodeInput.dirty(value),
    ));
  }

  void loginSignupVerifySubmitted() async {
    if (state.processing || !state.signupCodeInput.isValid) {
      return;
    }

    emit(state.copyWith(
      processing: true,
    ));

    try {
      final client = createWebtritApiClient(state.coreUrl!, state.tenantId!);
      final sessionToken = await _verifySessionOtp(
          client, state.signupSessionOtpProvisionalWithDateTime!.$1, state.signupCodeInput.value);

      // does not set processing to false to hold processing widgets state during navigation
      emit(state.copyWith(
        tenantId: sessionToken.tenantId ?? state.tenantId!,
        token: sessionToken.token,
      ));
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
  }

  void loginSignupVerifyBack() async {
    emit(state.copyWith(
      signupSessionOtpProvisionalWithDateTime: null,
      signupCodeInput: const CodeInput.pure(),
    ));
  }

  void loginSignupVerifyRepeat() {
    loginSignupRequestSubmitted();
  }
}

Future<List<LoginType>?> _verifyCoreVersionAndRetrieveSupportedLoginTypes(
  WebtritApiClient webtritApiClient,
) async {
  final systemInfo = await webtritApiClient.getSystemInfo();

  CoreVersion.supported().verify(systemInfo.core.version);

  final supportedLoginTypeNames = Set.from(LoginType.values.map((e) => e.name));
  return systemInfo.adapter?.supported
      ?.where((supportedName) => supportedLoginTypeNames.contains(supportedName))
      .map((supportedLoginTypeName) => LoginType.values.byName(supportedLoginTypeName))
      .toList();
}

Future<SessionOtpProvisional> _createSessionOtp(
  WebtritApiClient webtritApiClient,
  String userRef,
) async {
  return await webtritApiClient.createSessionOtp(SessionOtpCredential(
    bundleId: PackageInfo().packageName,
    type: PlatformInfo().appType,
    identifier: AppInfo().identifier,
    userRef: userRef,
  ));
}

Future<SessionToken> _verifySessionOtp(
  WebtritApiClient webtritApiClient,
  SessionOtpProvisional sessionOtpProvisional,
  String code,
) async {
  return await webtritApiClient.verifySessionOtp(sessionOtpProvisional, code);
}

Future<SessionToken> _createSessionRequest(
  WebtritApiClient webtritApiClient,
  String userRef,
  String password,
) async {
  return await webtritApiClient.createSession(SessionLoginCredential(
    bundleId: PackageInfo().packageName,
    type: PlatformInfo().appType,
    identifier: AppInfo().identifier,
    login: userRef,
    password: password,
  ));
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
