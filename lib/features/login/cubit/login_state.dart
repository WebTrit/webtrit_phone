part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool processing,
    Object? error,
    bool? demo,
    String? coreUrl,
    String? tenantId,
    SessionOtpProvisional? sessionOtpProvisional,
    String? token,
    @Default(UrlInput.pure()) UrlInput coreUrlInput,
    @Default(EmailInput.pure()) EmailInput emailInput,
    @Default(PhoneInput.pure()) PhoneInput phoneInput,
    @Default(CodeInput.pure()) CodeInput codeInput,
  }) = _LoginState;
}
