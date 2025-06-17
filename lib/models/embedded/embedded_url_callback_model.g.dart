// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'embedded_url_callback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmbeddedUrlCallbackModelImpl _$$EmbeddedUrlCallbackModelImplFromJson(
        Map<String, dynamic> json) =>
    _$EmbeddedUrlCallbackModelImpl(
      method: json['method'] as String,
      url: json['url'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$EmbeddedUrlCallbackModelImplToJson(
        _$EmbeddedUrlCallbackModelImpl instance) =>
    <String, dynamic>{
      'method': instance.method,
      'url': instance.url,
      'headers': instance.headers,
      'data': instance.data,
    };
