import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_api/webtrit_api.dart';

import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../login.dart';

part 'login_cubit.freezed.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.authRepository,
    required this.notificationsBloc,
    required this.sessionRepository,
    required this.systemInfoRepository,
  }) : super(const LoginState());

  final AuthRepository authRepository;

  final SystemInfoRepository systemInfoRepository;

  final SessionRepository sessionRepository;

  final NotificationsBloc notificationsBloc;

  // Environment getters
  String? get coreUrlFromEnvironment => EnvironmentConfig.CORE_URL;

  String? get credentialsRequestUrl => EnvironmentConfig.APP_CREDENTIALS_REQUEST_URL;

  String? get demoCoreUrlFromEnvironment => EnvironmentConfig.DEMO_CORE_URL;

  String get coreVersionConstraint => EnvironmentConfig.CORE_VERSION_CONSTRAINT;

  String get defaultTenantId => '';

  bool get isDemoModeEnabled => coreUrlFromEnvironment == null;

  bool get isCredentialsRequestUrlEnabled => credentialsRequestUrl != null;

  @override
  void onChange(Change<LoginState> change) {
    if (change.nextState.hasValidSession) {
      _saveSession(change.nextState);
    }

    super.onChange(change);
  }

  /// Finalizes the authentication flow by persisting the session.
  ///
  /// First, this hydrates the [SystemInfoRepository] with the fresh [WebtritSystemInfo]
  /// captured during login. This ensures the data is immediately available on the main screen,
  /// preventing redundant network requests.
  ///
  /// Then, it saves the [Session] via [SessionRepository]. This state change is observed
  /// by [AppBloc], effectively triggering navigation to the application's main screen.
  void _saveSession(LoginState state) {
    systemInfoRepository.preload(state.systemInfo!);
    sessionRepository.save(
      Session(coreUrl: state.coreUrl!, tenantId: state.tenantId!, token: state.token!, userId: state.userId!),
    );
  }

  void launchLinkableElement(LinkableElement link) async {
    final url = Uri.parse(link.url);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _processSystemInfo(String coreUrl, String tenantId, [bool demo = false]) async {
    emit(state.copyWith(processing: true));

    try {
      final systemInfo = await _loadAndValidateSystemInfo(coreUrl, tenantId);
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

      emit(
        state.copyWith(
          processing: false,
          coreUrl: coreUrl,
          tenantId: tenantId,
          supportedLoginTypes: supportedLoginTypes,
          systemInfo: systemInfo,
        ),
      );
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
      emit(state.copyWith(processing: false));
    }
  }

  Future<WebtritSystemInfo?> _loadAndValidateSystemInfo(String coreUrl, String tenantId) async {
    final systemInfo = await authRepository.getSystemInfo(coreUrl, tenantId);

    final coreInfo = systemInfo.core;
    final isCoreSupported = coreInfo.verifyVersionStr(coreVersionConstraint);

    if (!isCoreSupported) {
      final notification = CoreVersionUnsupportedErrorNotification(coreInfo.version.toString(), coreVersionConstraint);
      notificationsBloc.add(NotificationsSubmitted(notification));
      return null;
    }

    return systemInfo;
  }

  // LoginModeSelect

  void loginModeSelectSubmitted(LoginMode mode) async {
    emit(state.copyWith(mode: mode));

    final demo = mode == LoginMode.demoCore;
    final coreUrl = demo ? demoCoreUrlFromEnvironment : coreUrlFromEnvironment;

    if (coreUrl != null) await _processSystemInfo(coreUrl, defaultTenantId, demo);
  }

  void setEmbedded(EmbeddedData embedded) {
    emit(
      state.copyWith(
        embedded: embedded,
        coreUrl: isDemoModeEnabled ? demoCoreUrlFromEnvironment : coreUrlFromEnvironment,
      ),
    );
  }

  // LoginCoreUrlAssign

  void coreUrlInputChanged(String value) {
    emit(state.copyWith(coreUrlInput: UrlInput.dirty(value)));
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
    emit(state.copyWith(mode: null, coreUrlInput: const UrlInput.pure()));
  }

  void credentialsRequestUrlAssignBack() async {
    emit(state.copyWith(mode: null));
  }

  void embeddedPageAssignBack() async {
    emit(state.copyWith(embedded: null));
  }

  // LoginSwitch

  void loginSwitchBack() async {
    emit(
      state.copyWith(
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
      ),
    );
  }

  // LoginOtpSigninRequest

  void otpSigninUserRefInputChanged(String value) {
    emit(state.copyWith(otpSigninUserRefInput: UserRefInput.dirty(value)));
  }

  void loginOptSigninRequestSubmitted() async {
    if (state.processing || !state.otpSigninUserRefInput.isValid) {
      return;
    }

    emit(state.copyWith(processing: true));

    try {
      final sessionOtpProvisional = await authRepository.requestOtp(
        coreUrl: state.coreUrl!,
        tenantId: state.tenantId!,
        userRef: state.otpSigninUserRefInput.value,
      );

      emit(
        state.copyWith(
          processing: false,
          otpSigninSessionOtpProvisionalWithDateTime: (sessionOtpProvisional, DateTime.now()),
        ),
      );
    } catch (e) {
      emit(state.copyWith(processing: false));

      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }

  // LoginOtpSigninVerify

  void otpSigninCodeInputChanged(String value) {
    emit(state.copyWith(otpSigninCodeInput: CodeInput.dirty(value)));
  }

  void loginOptSigninVerifySubmitted() async {
    if (state.processing || !state.otpSigninCodeInput.isValid) {
      return;
    }

    emit(state.copyWith(processing: true));
    try {
      final sessionToken = await authRepository.verifyOtp(
        coreUrl: state.coreUrl!,
        tenantId: state.tenantId!,
        sessionOtpProvisional: state.otpSigninSessionOtpProvisionalWithDateTime!.$1,
        code: state.otpSigninCodeInput.value,
      );

      // does not set processing to false to hold processing widgets state during navigation
      emit(
        state.copyWith(
          tenantId: sessionToken.tenantId ?? state.tenantId!,
          token: sessionToken.token,
          // Use an empty user ID as a fallback for outdated core versions that do not support this field.
          userId: sessionToken.userId ?? '',
        ),
      );
    } catch (e) {
      emit(state.copyWith(processing: false));

      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }

  void loginOptSigninVerifyBack() async {
    emit(state.copyWith(otpSigninSessionOtpProvisionalWithDateTime: null, otpSigninCodeInput: const CodeInput.pure()));
  }

  void loginOptSigninVerifyRepeat() {
    loginOptSigninRequestSubmitted();
  }

  // LoginPasswordSignin

  void passwordSigninUserRefInputChanged(String value) {
    emit(state.copyWith(passwordSigninUserRefInput: UserRefInput.dirty(value)));
  }

  void passwordSigninPasswordInputChanged(String value) {
    emit(state.copyWith(passwordSigninPasswordInput: PasswordInput.dirty(value)));
  }

  void passwordSigninPasswordInputObscureTextToggled() {
    emit(state.copyWith(passwordSigninPasswordInputObscureText: !state.passwordSigninPasswordInputObscureText));
  }

  void loginPasswordSigninSubmitted() async {
    if (state.processing || !state.passwordSigninUserRefInput.isValid || !state.passwordSigninPasswordInput.isValid) {
      return;
    }

    emit(state.copyWith(processing: true));

    try {
      final sessionToken = await authRepository.login(
        coreUrl: state.coreUrl!,
        tenantId: state.tenantId!,
        userRef: state.passwordSigninUserRefInput.value,
        password: state.passwordSigninPasswordInput.value,
      );

      // does not set processing to false to hold processing widgets state during navigation
      loginSigninSubmitted(sessionToken);
    } catch (e) {
      emit(state.copyWith(processing: false));

      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));
    }
  }

  void loginSigninSubmitted(SessionToken token) async {
    emit(
      state.copyWith(
        tenantId: token.tenantId ?? state.tenantId ?? defaultTenantId,
        token: token.token,
        // Use an empty user ID as a fallback for outdated core versions that do not support this field.
        userId: token.userId ?? '',
      ),
    );
  }

  void loginPasswordSigninBack() async {
    emit(
      state.copyWith(
        passwordSigninUserRefInput: const UserRefInput.pure(),
        passwordSigninPasswordInput: const PasswordInput.pure(),
      ),
    );
  }

  // LoginSignupRequest

  void signupEmailInputChanged(String value) {
    emit(state.copyWith(signupEmailInput: EmailInput.dirty(value)));
  }

  /// Performs a custom signup flow initiated from an embedded page.
  ///
  /// Derives the tenant once (from extras -> state -> default) and reuses it for:
  ///   - `POST /user` request
  ///   - systemInfo loading (if required)
  ///   - OTP verification via `_applyLoginResult`
  ///
  /// Guarantees that all signup-related requests share the same tenant context.
  /// This avoids OTP verification mismatches across tenants.
  Future<void> loginCustomSignupRequest(
    Map<String, dynamic>? extras,
    Map<String, dynamic>? embeddedCallbackData,
  ) async {
    emit(
      state.copyWith(
        processing: true,
        embeddedExtras: extras,
        embeddedCallbackData: embeddedCallbackData,
        embeddedRequestError: null,
      ),
    );

    try {
      final tenantId = extras?['tenant_id'] ?? state.tenantId ?? defaultTenantId;

      // In cases where the embedded page acts as the launch welcome screen,
      // the systemInfo might not be loaded yet. Perform an additional check
      // and attempt to load it if necessary.
      final result = await authRepository.signup(coreUrl: state.coreUrl!, tenantId: tenantId, extraPayload: extras);

      if (state.systemInfo == null) {
        emit(state.copyWith(processing: true));
        final systemInfo = await _loadAndValidateSystemInfo(state.coreUrl!, tenantId);
        emit(state.copyWith(systemInfo: systemInfo, processing: false));
      }

      // Executes optional post-login callback request if provided by embedded flow.
      if (result is SessionToken) {
        final postRequest = embeddedCallbackData != null ? RawHttpRequest.fromJson(embeddedCallbackData) : null;
        await authRepository.executePostLoginHttpRequest(postRequest);
      }

      // Applies login result and ensures tenant consistency.
      _applyLoginResult(result, propagatedTenantId: tenantId);
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false, embeddedRequestError: e));
    }
  }

  void clearEmbeddedRequestError() {
    emit(state.copyWith(embeddedRequestError: null));
  }

  /// Handles standard (non-embedded) signup flow.
  ///
  /// Ensures tenant consistency by reusing the tenant stored in `state` for:
  /// - `POST /user`
  /// - subsequent OTP verification (propagated via `_applyLoginResult`)
  ///
  /// Early-exits if already processing or email is invalid. Emits errors and
  /// resets `processing` on failure.
  void loginSignupRequestSubmitted() async {
    if (state.processing || !state.signupEmailInput.isValid) {
      return;
    }

    emit(state.copyWith(processing: true));

    try {
      final result = await authRepository.signup(
        coreUrl: state.coreUrl!,
        tenantId: state.tenantId!,
        email: state.signupEmailInput.value,
      );

      _applyLoginResult(result, propagatedTenantId: state.tenantId);
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
  }

  /// Applies the login result while maintaining tenant consistency across the OTP flow.
  ///
  /// Ensures that both `POST /user` and `otp-verify` use the same tenant context.
  /// In embedded flows, the tenant may come from the embedded extras.
  /// Fallback order:
  ///   1. Explicit tenantId argument (propagated from POST /user request)
  ///   2. Tenant from the result object
  ///   3. Default tenant
  ///
  /// This prevents OTP verification issues when the backend stores OTPs under
  /// a default tenant ("") if tenantId was not provided during creation.
  void _applyLoginResult(SessionResult result, {String? propagatedTenantId}) {
    if (result is SessionOtpProvisional) {
      emit(
        state.copyWith(
          processing: false,
          signupSessionOtpProvisionalWithDateTime: (result, DateTime.now()),
          // Uses the same tenant as POST /user when provided; falls back safely otherwise.
          tenantId: propagatedTenantId ?? result.tenantId ?? defaultTenantId,
        ),
      );
    } else if (result is SessionToken) {
      // Maintain processing state during navigation
      emit(
        state.copyWith(
          // For a successful session, the tenant from the result is the ultimate source of truth.
          // It takes precedence because this token signifies the final authenticated state,
          // and no higher-level entity links the requests.
          tenantId: result.tenantId ?? propagatedTenantId ?? defaultTenantId,
          token: result.token,
          userId: result.userId ?? '', // Fallback for outdated core versions
        ),
      );
    } else {
      throw UnimplementedError('Unexpected login result type');
    }
  }

  // LoginSignupVerify

  void signupCodeInputChanged(String value) {
    emit(state.copyWith(signupCodeInput: CodeInput.dirty(value)));
  }

  void loginSignupVerifySubmitted() async {
    if (state.processing || !state.signupCodeInput.isValid) {
      return;
    }

    emit(state.copyWith(processing: true));

    try {
      final sessionToken = await authRepository.verifyOtp(
        coreUrl: state.coreUrl!,
        tenantId: state.tenantId!,
        sessionOtpProvisional: state.signupSessionOtpProvisionalWithDateTime!.$1,
        code: state.signupCodeInput.value,
      );

      // does not set processing to false to hold processing widgets state during navigation
      emit(
        state.copyWith(
          tenantId: sessionToken.tenantId ?? state.tenantId!,
          token: sessionToken.token,
          // Use an empty user ID as a fallback for outdated core versions that do not support this field.
          userId: sessionToken.userId ?? '',
        ),
      );
    } catch (e) {
      notificationsBloc.add(NotificationsSubmitted(LoginErrorNotification(e)));

      emit(state.copyWith(processing: false));
    }
  }

  void loginSignupVerifyBack() async {
    emit(state.copyWith(signupSessionOtpProvisionalWithDateTime: null, signupCodeInput: const CodeInput.pure()));
  }

  void loginSignupVerifyRepeat() {
    loginSignupRequestSubmitted();
  }
}
