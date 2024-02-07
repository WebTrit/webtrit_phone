part of 'otp_cubit.dart';

enum OtpStatus {
  processing,
  error,
  ok,
}

@freezed
class OtpState with _$OtpState {
  const OtpState._();

  const factory OtpState({
    OtpStatus? status,
    required bool demo,
    Exception? error,
    String? coreUrl,
    required String tenantId,
    SessionOtpProvisional? sessionOtpProvisional,
    String? token,
    @Default(EmailInput.pure()) EmailInput emailInput,
    @Default(PhoneInput.pure()) PhoneInput phoneInput,
    @Default(CodeInput.pure()) CodeInput codeInput,
  }) = _OtpRequestState;

  String get email => emailInput.value;

  String get phone => phoneInput.value;

  bool get isProcessing => status == OtpStatus.processing;
}
