part of 'password_request_cubit.dart';

enum PasswordRequestStatus {
  processing,
  error,
  ok,
}

@freezed
class PasswordRequestState with _$PasswordRequestState {
  const PasswordRequestState._();

  const factory PasswordRequestState({
    PasswordRequestStatus? status,
    Exception? error,
    required String coreUrl,
    required String tenantId,
    String? token,
    @Default(LoginInput.pure()) LoginInput loginInput,
    @Default(PasswordInput.pure()) PasswordInput passwordInput,
  }) = _PasswordRequestState;

  bool get isProcessing => status == PasswordRequestStatus.processing;

  bool get isInputValid => loginInput.isValid && passwordInput.isValid;
}
