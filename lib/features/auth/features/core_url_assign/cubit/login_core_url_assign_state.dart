part of 'login_core_url_assign_cubit.dart';

enum LoginCoreStatus {
  processing,
  error,
  ok,
}

@freezed
class LoginCoreUrlAssignState with _$LoginCoreUrlAssignState {
  const LoginCoreUrlAssignState._();

  const factory LoginCoreUrlAssignState({
    LoginCoreStatus? status,
    Exception? error,
    @Default(UrlInput.pure()) UrlInput coreUrlInput,
  }) = _LoginCoreUrlAssignState;

  bool get isProcessing => status == LoginCoreStatus.processing;
}
