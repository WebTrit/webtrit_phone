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
    required String defaultTenantId,
    @Default(UrlInput.pure()) UrlInput coreUrlInput,
    @Default([]) List<SupportedLoginType> supportedLogin,
    Exception? error,
  }) = _LoginCoreUrlAssignState;

  bool get isProcessing => status == LoginCoreStatus.processing;

  String get normalizeUrl {
    var coreUrlInputValue = coreUrlInput.value;

    if (!coreUrlInputValue.startsWith(RegExp(r'(https|http)://'))) {
      coreUrlInputValue = 'https://$coreUrlInputValue';
    }
    return coreUrlInputValue;
  }
}
