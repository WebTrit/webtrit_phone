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
    SessionOtpProvisional? otpProvisional,
    String? token,
    @Default(UrlInput.pure()) UrlInput coreUrlInput,
    @Default(EmailInput.pure()) EmailInput emailInput,
    @Default(PhoneInput.pure()) PhoneInput phoneInput,
    @Default(CodeInput.pure()) CodeInput codeInput,
  }) = _LoginState;
}
