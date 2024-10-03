// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionOtpProvisionalImpl _$$SessionOtpProvisionalImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionOtpProvisionalImpl(
      otpId: json['otp_id'] as String,
      notificationType: $enumDecodeNullable(
          _$OtpNotificationTypeEnumMap, json['notification_type']),
      fromEmail: json['from_email'] as String?,
      tenantId: json['tenant_id'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SessionOtpProvisionalImplToJson(
        _$SessionOtpProvisionalImpl instance) =>
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

_$SessionTokenImpl _$$SessionTokenImplFromJson(Map<String, dynamic> json) =>
    _$SessionTokenImpl(
      token: json['token'] as String,
      userId: json['user_id'] as String,
      tenantId: json['tenant_id'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SessionTokenImplToJson(_$SessionTokenImpl instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user_id': instance.userId,
      'tenant_id': instance.tenantId,
      'runtimeType': instance.$type,
    };

_$SessionDataImpl _$$SessionDataImplFromJson(Map<String, dynamic> json) =>
    _$SessionDataImpl(
      data: json['data'] as Map<String, dynamic>,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SessionDataImplToJson(_$SessionDataImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
      'runtimeType': instance.$type,
    };
