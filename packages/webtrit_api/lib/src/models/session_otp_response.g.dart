// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionOtpResponse _$$_SessionOtpResponseFromJson(
        Map<String, dynamic> json) =>
    _$_SessionOtpResponse(
      otpId: json['otp_id'] as String,
      notificationType: $enumDecodeNullable(
          _$OtpNotificationTypeEnumMap, json['notification_type']),
      fromEmail: json['from_email'] as String?,
      tenantId: json['tenant_id'] as String?,
    );

Map<String, dynamic> _$$_SessionOtpResponseToJson(
        _$_SessionOtpResponse instance) =>
    <String, dynamic>{
      'otp_id': instance.otpId,
      'notification_type':
          _$OtpNotificationTypeEnumMap[instance.notificationType],
      'from_email': instance.fromEmail,
      'tenant_id': instance.tenantId,
    };

const _$OtpNotificationTypeEnumMap = {
  OtpNotificationType.email: 'email',
};
