// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'raw_http_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RawHttpRequest _$RawHttpRequestFromJson(Map<String, dynamic> json) =>
    _RawHttpRequest(
      method: json['method'] as String,
      url: json['url'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RawHttpRequestToJson(_RawHttpRequest instance) =>
    <String, dynamic>{
      'method': instance.method,
      'url': instance.url,
      'headers': instance.headers,
      'data': instance.data,
    };
