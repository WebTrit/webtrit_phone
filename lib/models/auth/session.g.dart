// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionImpl _$$SessionImplFromJson(Map<String, dynamic> json) =>
    _$SessionImpl(
      coreUrl: json['coreUrl'] as String?,
      token: json['token'] as String?,
      tenantId: json['tenantId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
    );

Map<String, dynamic> _$$SessionImplToJson(_$SessionImpl instance) =>
    <String, dynamic>{
      'coreUrl': instance.coreUrl,
      'token': instance.token,
      'tenantId': instance.tenantId,
      'userId': instance.userId,
    };
