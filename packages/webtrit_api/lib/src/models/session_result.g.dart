// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionOtpProvisional _$$SessionOtpProvisionalFromJson(
        Map<String, dynamic> json) =>
    _$SessionOtpProvisional(
      otpId: json['otp_id'] as String,
      notificationType: $enumDecodeNullable(
          _$OtpNotificationTypeEnumMap, json['notification_type']),
      fromEmail: json['from_email'] as String?,
      tenantId: json['tenant_id'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SessionOtpProvisionalToJson(
        _$SessionOtpProvisional instance) =>
    <String, dynamic>{
      'otp_id': instance.otpId,
      'notification_type':
          _$OtpNotificationTypeEnumMap[instance.notificationType],
      'from_email': instance.fromEmail,
      'tenant_id': instance.tenantId,
      'runtimeType': instance.$type,
    };

const _$OtpNotificationTypeEnumMap = {
  OtpNotificationType.email: 'email',
};

_$SessionToken _$$SessionTokenFromJson(Map<String, dynamic> json) =>
    _$SessionToken(
      token: json['token'] as String,
      tenantId: json['tenant_id'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SessionTokenToJson(_$SessionToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'tenant_id': instance.tenantId,
      'runtimeType': instance.$type,
    };

_$SessionData _$$SessionDataFromJson(Map<String, dynamic> json) =>
    _$SessionData(
      data: json['data'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SessionDataToJson(_$SessionData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'runtimeType': instance.$type,
    };
