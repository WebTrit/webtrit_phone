part of 'login_cubit.dart';

enum LoginStatus {
  input,
  processing,
  ok,
  back,
}

extension LoginStatusX on LoginStatus {
  bool get isInput => this == LoginStatus.input;

  bool get isProcessing => this == LoginStatus.processing;

  bool get isOk => this == LoginStatus.ok;

  bool get isBack => this == LoginStatus.back;
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required LoginStep step,
    @Default(LoginStatus.input) LoginStatus status,
    Object? error,
    @Default(false) bool demo,
    String? coreUrl,
    String? tenantId,
    SessionOtpProvisional? sessionOtpProvisional,
    String? token,
    @Default([SupportedLogin.otpSignIn]) List<SupportedLogin> supportedLogin,
    @Default(UrlInput.pure()) UrlInput coreUrlInput,
    @Default(EmailInput.pure()) EmailInput emailInput,
    @Default(PhoneInput.pure()) PhoneInput phoneInput,
    @Default(CodeInput.pure()) CodeInput codeInput,
    @Default(LoginInput.pure()) LoginInput loginInput,
    @Default(PasswordInput.pure()) PasswordInput passwordInput,
  }) = _LoginState;
}
