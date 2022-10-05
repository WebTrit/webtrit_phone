import 'package:json_annotation/json_annotation.dart';

import 'app_type.dart';

part 'session_otp_request_demo.g.dart';

@JsonSerializable(createFactory: false)
class SessionOtpRequestDemoRequest {
  const SessionOtpRequestDemoRequest({
    required this.type,
    required this.identifier,
    required this.email,
  });

  Map<String, dynamic> toJson() => _$SessionOtpRequestDemoRequestToJson(this);

  final AppType type;
  final String identifier;
  final String email;
}

@JsonSerializable(createToJson: false)
class SessionOtpRequestDemoResponse {
  const SessionOtpRequestDemoResponse({
    required this.otpId,
  });

  factory SessionOtpRequestDemoResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionOtpRequestDemoResponseFromJson(json);

  final String otpId;
}
