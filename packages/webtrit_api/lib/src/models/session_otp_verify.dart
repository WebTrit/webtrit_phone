import 'package:json_annotation/json_annotation.dart';

part 'session_otp_verify.g.dart';

@JsonSerializable(createFactory: false)
class SessionOtpVerifyRequest {
  const SessionOtpVerifyRequest({
    required this.otpId,
    required this.code,
  });

  Map<String, dynamic> toJson() => _$SessionOtpVerifyRequestToJson(this);

  final String otpId;
  final String code;
}

@JsonSerializable(createToJson: false)
class SessionOtpVerifyResponse {
  const SessionOtpVerifyResponse({
    required this.token,
  });

  factory SessionOtpVerifyResponse.fromJson(Map<String, dynamic> json) => _$SessionOtpVerifyResponseFromJson(json);

  final String token;
}
