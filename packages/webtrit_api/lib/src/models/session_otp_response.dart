// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'session_response.dart';
import 'otp_notification_type.dart';

part 'session_otp_response.freezed.dart';

part 'session_otp_response.g.dart';

@freezed
class SessionOtpResponse with _$SessionOtpResponse implements BaseSessionResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionOtpResponse({
    required String otpId,
    OtpNotificationType? notificationType,
    String? fromEmail,
    String? tenantId,
  }) = _SessionOtpResponse;

  factory SessionOtpResponse.fromJson(Map<String, dynamic> json) => _$SessionOtpResponseFromJson(json);
}
