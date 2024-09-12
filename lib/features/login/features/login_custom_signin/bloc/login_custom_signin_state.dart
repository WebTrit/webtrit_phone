part of 'login_custom_signin_cubit.dart';

@freezed
class LoginCustomSigninState with _$LoginCustomSigninState {
  const factory LoginCustomSigninState({
    SessionToken? sessionToken,
  }) = _LoginCustomSigninState;
}
