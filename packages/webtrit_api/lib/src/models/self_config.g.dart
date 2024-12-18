// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SelfConfigResponseImpl _$$SelfConfigResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SelfConfigResponseImpl(
      url: Uri.parse(json['url'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
    );

Map<String, dynamic> _$$SelfConfigResponseImplToJson(
        _$SelfConfigResponseImpl instance) =>
    <String, dynamic>{
      'url': instance.url.toString(),
      'expires_at': instance.expiresAt.toIso8601String(),
    };
