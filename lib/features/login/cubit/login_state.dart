part of 'login_cubit.dart';

typedef SessionOtpProvisionalWithDateTime = (SessionOtpProvisional, DateTime);

@freezed
class LoginState with _$LoginState {
  const LoginState({
    this.processing = false,
    this.mode,
    this.coreUrl,
    this.tenantId,
    this.systemInfo,
    this.supportedLoginTypes,
    this.otpSigninSessionOtpProvisionalWithDateTime,
    this.passwordSigninPasswordInputObscureText = true,
    this.signupSessionOtpProvisionalWithDateTime,
    this.token,
    this.userId,
    // Used to represent an embedded launch page or a login type within tabbed navigation
    this.embedded,
    // Extras and callback data that returned from the embedded page
    this.embeddedExtras,
    this.embeddedCallbackData,
    this.embeddedRequestError,
    this.coreUrlInput = const UrlInput.pure(),
    this.otpSigninUserRefInput = const UserRefInput.pure(),
    this.otpSigninCodeInput = const CodeInput.pure(),
    this.passwordSigninUserRefInput = const UserRefInput.pure(),
    this.passwordSigninPasswordInput = const PasswordInput.pure(),
    this.signupEmailInput = const EmailInput.pure(),
    this.signupCodeInput = const CodeInput.pure(),
  });

  @override
  final bool processing;

  @override
  final LoginMode? mode;

  @override
  final String? coreUrl;

  @override
  final String? tenantId;

  @override
  final WebtritSystemInfo? systemInfo;

  @override
  final List<LoginType>? supportedLoginTypes;

  @override
  final SessionOtpProvisionalWithDateTime? otpSigninSessionOtpProvisionalWithDateTime;

  @override
  final bool passwordSigninPasswordInputObscureText;

  @override
  final SessionOtpProvisionalWithDateTime? signupSessionOtpProvisionalWithDateTime;

  @override
  final String? token;

  @override
  final String? userId;

  @override
  final EmbeddedData? embedded;

  @override
  final Map<String, dynamic>? embeddedExtras;

  @override
  final Map<String, dynamic>? embeddedCallbackData;

  @override
  final Object? embeddedRequestError;

  @override
  final UrlInput coreUrlInput;

  @override
  final UserRefInput otpSigninUserRefInput;

  @override
  final CodeInput otpSigninCodeInput;

  @override
  final UserRefInput passwordSigninUserRefInput;

  @override
  final PasswordInput passwordSigninPasswordInput;

  @override
  final EmailInput signupEmailInput;

  @override
  final CodeInput signupCodeInput;

  bool get hasValidSession =>
      coreUrl != null && tenantId != null && token != null && userId != null && systemInfo != null;
}
