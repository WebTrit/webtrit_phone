// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ErrorResponse _$$_ErrorResponseFromJson(Map<String, dynamic> json) =>
    _$_ErrorResponse(
      code: json['code'] as String,
      details: (json['details'] as List<dynamic>?)
          ?.map((e) => ErrorDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ErrorResponseToJson(_$_ErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'details': instance.details,
    };

_$_ErrorDetail _$$_ErrorDetailFromJson(Map<String, dynamic> json) =>
    _$_ErrorDetail(
      path: json['path'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$_ErrorDetailToJson(_$_ErrorDetail instance) =>
    <String, dynamic>{
      'path': instance.path,
      'reason': instance.reason,
    };
