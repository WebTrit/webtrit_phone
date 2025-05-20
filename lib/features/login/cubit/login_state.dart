part of 'login_cubit.dart';

typedef SessionOtpProvisionalWithDateTime = (SessionOtpProvisional, DateTime);

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool processing,
    LoginMode? mode,
    String? coreUrl,
    String? tenantId,
    WebtritSystemInfo? systemInfo,
    List<LoginType>? supportedLoginTypes,
    SessionOtpProvisionalWithDateTime? otpSigninSessionOtpProvisionalWithDateTime,
    @Default(true) bool passwordSigninPasswordInputObscureText,
    SessionOtpProvisionalWithDateTime? signupSessionOtpProvisionalWithDateTime,
    String? token,
    String? userId,
    // If provided, this parameter will be used to build the launch screen instead of the native welcome screen
    LoginEmbedded? launchEmbedded,
    // If provided, this parameter will determine the active login tab or fallback to a single login type if others are disabled
    LoginEmbedded? switchEmbedded,
    @Default(UrlInput.pure()) UrlInput coreUrlInput,
    @Default(UserRefInput.pure()) UserRefInput otpSigninUserRefInput,
    @Default(CodeInput.pure()) CodeInput otpSigninCodeInput,
    @Default(UserRefInput.pure()) UserRefInput passwordSigninUserRefInput,
    @Default(PasswordInput.pure()) PasswordInput passwordSigninPasswordInput,
    @Default(EmailInput.pure()) EmailInput signupEmailInput,
    @Default(CodeInput.pure()) CodeInput signupCodeInput,
  }) = _LoginState;
}
