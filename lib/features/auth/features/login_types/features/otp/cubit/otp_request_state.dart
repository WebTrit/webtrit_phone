part of 'otp_request_cubit.dart';

enum OtpRequestStatus {
  processing,
  error,
  ok,
}

@freezed
class OtpRequestState with _$OtpRequestState {
  const OtpRequestState._();

  const factory OtpRequestState({
    OtpRequestStatus? status,
    required bool demo,
    @Default(EmailInput.pure()) EmailInput emailInput,
    @Default(PhoneInput.pure()) PhoneInput phoneInput,
  }) = _OtpRequestState;

}
