// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ErrorResponseImpl _$$ErrorResponseImplFromJson(Map<String, dynamic> json) =>
    _$ErrorResponseImpl(
      code: json['code'] as String?,
      message: json['message'] as String?,
      details: json['details'] == null
          ? null
          : ErrorDetail.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ErrorResponseImplToJson(_$ErrorResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'details': instance.details,
    };

_$ErrorDetailImpl _$$ErrorDetailImplFromJson(Map<String, dynamic> json) =>
    _$ErrorDetailImpl(
      path: json['path'] as String?,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$ErrorDetailImplToJson(_$ErrorDetailImpl instance) =>
    <String, dynamic>{
      'path': instance.path,
      'reason': instance.reason,
    };
