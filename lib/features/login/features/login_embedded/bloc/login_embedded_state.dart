part of 'login_embedded_cubit.dart';

@freezed
class LoginEmbeddedState with _$LoginEmbeddedState {
  const factory LoginEmbeddedState({
    @Default(false) bool processing,
    String? coreUrl,
    SessionResult? result,
    String? tenantId,
    String? token,
    String? userId,
    SessionOtpProvisionalWithDateTime? signupSessionOtpProvisionalWithDateTime,
  }) = _LoginCustomSigninState;
}
