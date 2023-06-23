// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_authorized_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SessionAuthorizedResponse _$$_SessionAuthorizedResponseFromJson(
        Map<String, dynamic> json) =>
    _$_SessionAuthorizedResponse(
      token: json['token'] as String,
      expiresAt: json['expires_at'] as String,
      tenantId: json['tenant_id'] as String?,
    );

Map<String, dynamic> _$$_SessionAuthorizedResponseToJson(
        _$_SessionAuthorizedResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'expires_at': instance.expiresAt,
      'tenant_id': instance.tenantId,
    };
