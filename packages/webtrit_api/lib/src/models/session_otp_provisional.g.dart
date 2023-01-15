// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_otp_provisional.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionOtpProvisional _$$_SessionOtpProvisionalFromJson(
        Map<String, dynamic> json) =>
    _$_SessionOtpProvisional(
      otpId: json['otp_id'] as String,
      notificationType: $enumDecodeNullable(
          _$OtpNotificationTypeEnumMap, json['notification_type']),
      fromEmail: json['from_email'] as String?,
    );

Map<String, dynamic> _$$_SessionOtpProvisionalToJson(
        _$_SessionOtpProvisional instance) =>
    <String, dynamic>{
      'otp_id': instance.otpId,
      'notification_type':
          _$OtpNotificationTypeEnumMap[instance.notificationType],
      'from_email': instance.fromEmail,
    };

const _$OtpNotificationTypeEnumMap = {
  OtpNotificationType.email: 'email',
};
