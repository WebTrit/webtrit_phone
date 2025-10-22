// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
  coreUrl: json['coreUrl'] as String?,
  token: json['token'] as String?,
  tenantId: json['tenantId'] as String? ?? '',
  userId: json['userId'] as String? ?? '',
);

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
  'coreUrl': instance.coreUrl,
  'token': instance.token,
  'tenantId': instance.tenantId,
  'userId': instance.userId,
};
