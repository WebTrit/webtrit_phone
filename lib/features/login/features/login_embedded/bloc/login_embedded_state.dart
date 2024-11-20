part of 'login_embedded_cubit.dart';

@freezed
class LoginEmbeddedState with _$LoginEmbeddedState {
  const factory LoginEmbeddedState({
    SessionResult? result,
    String? tenantId,
    String? token,
    String? userId,
    SessionOtpProvisionalWithDateTime? signupSessionOtpProvisionalWithDateTime,
  }) = _LoginCustomSigninState;
}
