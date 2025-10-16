// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Session _$SessionFromJson(Map<String, dynamic> json) => _Session(
      coreUrl: json['coreUrl'] as String?,
      token: json['token'] as String?,
      tenantId: json['tenantId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
    );

Map<String, dynamic> _$SessionToJson(_Session instance) => <String, dynamic>{
      'coreUrl': instance.coreUrl,
      'token': instance.token,
      'tenantId': instance.tenantId,
      'userId': instance.userId,
    };
