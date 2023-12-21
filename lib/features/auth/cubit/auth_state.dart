part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    String? url,
    @Default(false) bool demo,
  }) = _AuthState;
}
