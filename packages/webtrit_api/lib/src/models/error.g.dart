// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ErrorResponse _$$_ErrorResponseFromJson(Map<String, dynamic> json) =>
    _$_ErrorResponse(
      code: json['code'] as String,
      refining: (json['refining'] as List<dynamic>?)
          ?.map((e) => ErrorRefining.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ErrorResponseToJson(_$_ErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'refining': instance.refining,
    };

_$_ErrorRefining _$$_ErrorRefiningFromJson(Map<String, dynamic> json) =>
    _$_ErrorRefining(
      path: json['path'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$$_ErrorRefiningToJson(_$_ErrorRefining instance) =>
    <String, dynamic>{
      'path': instance.path,
      'reason': instance.reason,
    };
