part of 'login_cubit.dart';

typedef SessionOtpProvisionalWithDateTime = (SessionOtpProvisional, DateTime);

@freezed
abstract class LoginState with _$LoginState {
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
    // Used to represent an embedded launch page or a login type within tabbed navigation
    EmbeddedData? embedded,
    // Extras and callback data that returned from the embedded page
    Map<String, dynamic>? embeddedExtras,
    Map<String, dynamic>? embeddedCallbackData,
    Object? embeddedRequestError,
    @Default(UrlInput.pure()) UrlInput coreUrlInput,
    @Default(UserRefInput.pure()) UserRefInput otpSigninUserRefInput,
    @Default(CodeInput.pure()) CodeInput otpSigninCodeInput,
    @Default(UserRefInput.pure()) UserRefInput passwordSigninUserRefInput,
    @Default(PasswordInput.pure()) PasswordInput passwordSigninPasswordInput,
    @Default(EmailInput.pure()) EmailInput signupEmailInput,
    @Default(CodeInput.pure()) CodeInput signupCodeInput,
  }) = _LoginState;
}
