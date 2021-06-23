import 'package:json_annotation/json_annotation.dart';

import 'app_type.dart';

part 'session_otp_request.g.dart';

@JsonSerializable(createFactory: false)
class SessionOtpRequestRequest {
  const SessionOtpRequestRequest({
    required this.type,
    required this.identifier,
    required this.phone,
  });

  Map<String, dynamic> toJson() => _$SessionOtpRequestRequestToJson(this);

  final AppType type;
  final String identifier;
  final String phone;
}

@JsonSerializable(createToJson: false)
class SessionOtpRequestResponse {
  const SessionOtpRequestResponse({
    required this.otpId,
  });

  factory SessionOtpRequestResponse.fromJson(Map<String, dynamic> json) => _$SessionOtpRequestResponseFromJson(json);

  final String otpId;
}
