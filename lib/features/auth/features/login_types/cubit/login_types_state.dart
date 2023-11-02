part of 'login_types_cubit.dart';

@freezed
class LoginTypesState with _$LoginTypesState {
  const factory LoginTypesState({
    @Default([]) List<SupportedLoginType> supportedLogin,
  }) = _LoginTypesState;
}
