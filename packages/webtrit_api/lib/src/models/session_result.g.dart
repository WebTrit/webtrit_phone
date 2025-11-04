// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionOtpProvisional _$SessionOtpProvisionalFromJson(
  Map<String, dynamic> json,
) => SessionOtpProvisional(
  otpId: json['otp_id'] as String,
  notificationType: $enumDecodeNullable(
    _$OtpNotificationTypeEnumMap,
    json['notification_type'],
  ),
  fromEmail: json['from_email'] as String?,
  tenantId: json['tenant_id'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SessionOtpProvisionalToJson(
  SessionOtpProvisional instance,
) => <String, dynamic>{
  'otp_id': instance.otpId,
  'notification_type': _$OtpNotificationTypeEnumMap[instance.notificationType],
  'from_email': instance.fromEmail,
  'tenant_id': instance.tenantId,
  'runtimeType': instance.$type,
};

const _$OtpNotificationTypeEnumMap = {OtpNotificationType.email: 'email'};

SessionToken _$SessionTokenFromJson(Map<String, dynamic> json) => SessionToken(
  token: json['token'] as String,
  userId: json['user_id'] as String?,
  tenantId: json['tenant_id'] as String?,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SessionTokenToJson(SessionToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user_id': instance.userId,
      'tenant_id': instance.tenantId,
      'runtimeType': instance.$type,
    };

SessionData _$SessionDataFromJson(Map<String, dynamic> json) => SessionData(
  data: json['data'] as Map<String, dynamic>,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$SessionDataToJson(SessionData instance) =>
    <String, dynamic>{'data': instance.data, 'runtimeType': instance.$type};
