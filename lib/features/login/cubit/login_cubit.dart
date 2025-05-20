import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/mappers/mappers.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../login.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with SystemInfoApiMapper {
  LoginCubit({
    @visibleForTesting this.createWebtritApiClient = defaultCreateWebtritApiClient,
    required this.notificationsBloc,
    required this.packageInfo,
    required this.appInfo,
    required this.platformInfo,
  }) : super(const LoginState());

  final WebtritApiClientFactory createWebtritApiClient;
  final NotificationsBloc notificationsBloc;
  final PlatformInfo platformInfo;
  final PackageInfo packageInfo;
  final AppInfo appInfo;

  String get appBundleId => packageInfo.packageName;

  AppType get appType => platformInfo.appType;

  String get appIdentifier => appInfo.identifier;

  String? get coreUrlFromEnvironment => EnvironmentConfig.CORE_URL;

  String? get credentialsRequestUrl => EnvironmentConfig.APP_CREDENTIALS_REQUEST_URL;

  String? get demoCoreUrlFromEnvironment => EnvironmentConfig.DEMO_CORE_URL;

  String get coreVersionConstraint => EnvironmentConfig.CORE_VERSION_CONSTRAINT;

  String get defaultTenantId => '';

  bool get isDemoModeEnabled => coreUrlFromEnvironment == null;

  bool get isCredentialsRequestUrlEnabled => credentialsRequestUrl != null;

  void launchLinkableElement(LinkableElement link) async {
    final url = Uri.parse(link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _processSystemInfo(String coreUrl, String tenantId, [bool demo = false]) async {
    emit(state.copyWith(processing: true));

    try {
      final systemInfo = await _loadAndValidateSystemInfo(coreUrl, tenantId, demo);
      if (systemInfo == null) {
        emit(state.copyWith(processing: false));
        return;
      }

      final supportedFeatures = systemInfo.adapter?.supported ?? [];
      final supportedLoginTypes = supportedFeatures
          .where((f) => LoginType.values.map((e) => e.name).contains(f))
          .map((f) => LoginType.values.byName(f))
          .toList();
      if (demo) supportedLoginTypes.removeWhere((loginType) => loginType != LoginType.signup);

      if (supportedLoginTypes.isEmpty) {
        notificationsBloc.add(const NotificationsSubmitted(SupportedLoginTypeMissedErrorNotification()));
        emit(state.copyWith(processing: false));
        return;
      }

      emit(state.copyWith(
        processing: false,
        coreUrl: coreUrl,
        tenantId: tenantId,
        supportedLoginTypes: supportedLoginTypes,
        systemInfo: systemInfo,
      ));
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
  }

  Future<WebtritSystemInfo?> _loadAndValidateSystemInfo(String coreUrl, String tenantId, bool demo) async {
    final client = createWebtritApiClient(coreUrl, tenantId);
    final systemInfo = await _retrieveSystemInfo(client);

    final coreInfo = systemInfo.core;
    final isCoreSupported = coreInfo.verifyVersionStr(coreVersionConstraint);

    if (!isCoreSupported) {
      final notification = CoreVersionUnsupportedErrorNotification(
        coreInfo.version.toString(),
        coreVersionConstraint,
      );
      notificationsBloc.add(NotificationsSubmitted(notification));
      return null;
    }

    return systemInfo;
  }

  // LoginModeSelect

  void loginModeSelectSubmitted(LoginMode mode) async {
    emit(state.copyWith(
      mode: mode,
    ));

    final demo = mode == LoginMode.demoCore;
    final coreUrl = demo ? demoCoreUrlFromEnvironment : coreUrlFromEnvironment;

    if (coreUrl != null) await _processSystemInfo(coreUrl, defaultTenantId, demo);
  }

  void setEmbedded(LoginEmbedded embedded) {
    emit(state.copyWith(
      embedded: embedded,
      coreUrl: isDemoModeEnabled ? demoCoreUrlFromEnvironment : coreUrlFromEnvironment,
    ));
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

    await _processSystemInfo(coreUrlInputValue, defaultTenantId);
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

  void embeddedPageAssignBack() async {
    emit(state.copyWith(
      embedded: null,
    ));
  }

  // LoginSwitch

  void loginSwitchBack() async {
    emit(state.copyWith(
      mode: state.mode == LoginMode.customCore ? state.mode : null,
      coreUrl: null,
      tenantId: null,
      supportedLoginTypes: null,
      embedded: null,
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
        // Use an empty user ID as a fallback for outdated core versions that do not support this field.
        userId: sessionToken.userId ?? '',
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
      // Use an empty user ID as a fallback for outdated core versions that do not support this field.
      userId: token.userId ?? '',
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

  void loginCustomSignupRequest(Map<String, dynamic>? extras) async {
    emit(state.copyWith(
      processing: true,
    ));

    try {
      final tenantId = extras?['tenant_id'] ?? state.tenantId ?? defaultTenantId;
      final client = createWebtritApiClient(state.coreUrl!, tenantId);
      final result = await _createUserRequest(client: client, extraPayload: extras);

      // In cases where the embedded page acts as the launch welcome screen,
      // the systemInfo might not be loaded yet. Perform an additional check
      // and attempt to load it if necessary.
      if (state.systemInfo == null) {
        emit(state.copyWith(processing: true));
        final systemInfo = await _loadAndValidateSystemInfo(state.coreUrl!, tenantId, isDemoModeEnabled);
        emit(state.copyWith(systemInfo: systemInfo, processing: false));
      }

      _handleLoginResult(result);
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
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
      final result = await _createUserRequest(client: client, email: state.signupEmailInput.value);

      _handleLoginResult(result);
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
  }

  void _handleLoginResult(SessionResult result) {
    if (result is SessionOtpProvisional) {
      emit(state.copyWith(
        processing: false,
        signupSessionOtpProvisionalWithDateTime: (result, DateTime.now()),
      ));
    } else if (result is SessionToken) {
      // Maintain processing state during navigation
      emit(state.copyWith(
        tenantId: result.tenantId ?? state.tenantId ?? defaultTenantId,
        token: result.token,
        userId: result.userId ?? '', // Fallback for outdated core versions
      ));
    } else {
      throw UnimplementedError('Unexpected login result type');
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
        client,
        state.signupSessionOtpProvisionalWithDateTime!.$1,
        state.signupCodeInput.value,
      );

      // does not set processing to false to hold processing widgets state during navigation
      emit(state.copyWith(
        tenantId: sessionToken.tenantId ?? state.tenantId!,
        token: sessionToken.token,
        // Use an empty user ID as a fallback for outdated core versions that do not support this field.
        userId: sessionToken.userId ?? '',
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

  Future<WebtritSystemInfo> _retrieveSystemInfo(WebtritApiClient webtritApiClient) async {
    final apiSystemInfo = await webtritApiClient.getSystemInfo();
    final systemInfo = systemInfoFromApi(apiSystemInfo);
    return systemInfo;
  }

  Future<SessionOtpProvisional> _createSessionOtp(
    WebtritApiClient webtritApiClient,
    String userRef,
  ) async {
    return await webtritApiClient.createSessionOtp(SessionOtpCredential(
      bundleId: appBundleId,
      type: appType,
      identifier: appIdentifier,
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
      bundleId: appBundleId,
      type: appType,
      identifier: appIdentifier,
      login: userRef,
      password: password,
    ));
  }

  Future<SessionResult> _createUserRequest({
    required WebtritApiClient client,
    String? email,
    Map<String, dynamic>? extraPayload,
  }) async {
    return await client.createUser(
      SessionUserCredential(
        bundleId: appBundleId,
        type: appType,
        identifier: appIdentifier,
        email: email,
      ),
      extraPayload: extraPayload,
    );
  }
}
