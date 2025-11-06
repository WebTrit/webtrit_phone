// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'otp_notification_type.dart';

part 'session_result.freezed.dart';

part 'session_result.g.dart';

@Freezed(fromJson: true)
class SessionResult with _$SessionResult {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionResult.otpProvisional({
    required String otpId,
    OtpNotificationType? notificationType,
    String? fromEmail,
    String? tenantId,
  }) = SessionOtpProvisional;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionResult.token({
    required String token,
    // Maintain backward compatibility by providing a default null value for userId, as older core versions do not utilize this field.
    String? userId,
    String? tenantId,
  }) = SessionToken;

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionResult.data({required Map<String, dynamic> data}) = SessionData;

  factory SessionResult.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('otp_id')) {
      return SessionOtpProvisional.fromJson(json);
    } else if (json.containsKey('token')) {
      return SessionToken.fromJson(json);
    } else {
      return SessionData.fromJson({'data': json}); // a bit hacky way to wrap response data for proper fromJson call
    }
  }
}
