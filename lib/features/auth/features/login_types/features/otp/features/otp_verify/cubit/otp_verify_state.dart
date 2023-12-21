part of 'otp_verify_cubit.dart';

enum OtpVerifyStatus {
  processing,
  error,
  ok,
}

@freezed
class OtpVerifyState with _$OtpVerifyState {
  const OtpVerifyState._();

  const factory OtpVerifyState({
    OtpVerifyStatus? status,
    Exception? error,
    String? coreUrl,
    String? tenantId,
    @Default('') String phone,
    @Default('') String email,
    SessionOtpProvisional? sessionOtpProvisional,
    String? token,
    @Default(CodeInput.pure()) CodeInput codeInput,
  }) = _OtpVerifyState;

  bool get isProcessing => status == OtpVerifyStatus.processing;
}
