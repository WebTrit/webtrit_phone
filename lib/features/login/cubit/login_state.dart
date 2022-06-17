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
    @Default(0) int tabIndex,
    @Default(LoginStatus.input) LoginStatus status,
    Object? error,
    @Default(false) bool demo,
    String? otpId,
    String? token,
    @Default(UrlInput.pure()) UrlInput coreUrlInput,
    @Default(PhoneInput.pure()) PhoneInput phoneInput,
    @Default(CodeInput.pure()) CodeInput codeInput,
  }) = _LoginState;
}
