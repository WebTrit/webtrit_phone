// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SelfConfigResponse _$SelfConfigResponseFromJson(Map<String, dynamic> json) =>
    SelfConfigResponse(url: Uri.parse(json['url'] as String), expiresAt: DateTime.parse(json['expires_at'] as String));

Map<String, dynamic> _$SelfConfigResponseToJson(SelfConfigResponse instance) => <String, dynamic>{
  'url': instance.url.toString(),
  'expires_at': instance.expiresAt.toIso8601String(),
};
