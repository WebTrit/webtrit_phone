// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'otp_notification_type.dart';

part 'session_otp_provisional.freezed.dart';

part 'session_otp_provisional.g.dart';

@freezed
class SessionOtpProvisional with _$SessionOtpProvisional {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SessionOtpProvisional({
    required String otpId,
    OtpNotificationType? notificationType,
    String? fromEmail,
  }) = _SessionOtpProvisional;

  factory SessionOtpProvisional.fromJson(Map<String, dynamic> json) => _$SessionOtpProvisionalFromJson(json);
}
