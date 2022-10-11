import 'package:json_annotation/json_annotation.dart';

import 'app_type.dart';
import 'otp_notification_type.dart';

part 'session_otp_request.g.dart';

class SessionOtpRequestResult {
  const SessionOtpRequestResult({
    required this.otpId,
    required this.notificationType,
    this.fromEmail,
  });

  final String otpId;
  final OtpNotificationType notificationType;
  final String? fromEmail;
}

@JsonSerializable(
  createFactory: false,
  fieldRename: FieldRename.snake,
)
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

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class SessionOtpRequestResponse extends SessionOtpRequestResult {
  const SessionOtpRequestResponse({
    required String otpId,
    required OtpNotificationType notificationType,
    String? fromEmail,
  }) : super(
          otpId: otpId,
          notificationType: notificationType,
          fromEmail: fromEmail,
        );

  factory SessionOtpRequestResponse.fromJson(Map<String, dynamic> json) => _$SessionOtpRequestResponseFromJson(json);
}

@JsonSerializable(
  createFactory: false,
  fieldRename: FieldRename.snake,
)
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

@JsonSerializable(
  createToJson: false,
  fieldRename: FieldRename.snake,
)
class SessionOtpRequestDemoResponse extends SessionOtpRequestResult {
  const SessionOtpRequestDemoResponse({
    required String otpId,
    required OtpNotificationType notificationType,
    String? fromEmail,
  }) : super(
          otpId: otpId,
          notificationType: notificationType,
          fromEmail: fromEmail,
        );

  factory SessionOtpRequestDemoResponse.fromJson(Map<String, dynamic> json) =>
      _$SessionOtpRequestDemoResponseFromJson(json);
}
