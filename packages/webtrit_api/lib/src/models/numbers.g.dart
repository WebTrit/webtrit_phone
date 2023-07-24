// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Numbers _$$_NumbersFromJson(Map<String, dynamic> json) => _$_Numbers(
      main: json['main'] as String,
      additional: (json['additional'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ext: json['ext'] as String?,
    );

Map<String, dynamic> _$$_NumbersToJson(_$_Numbers instance) =>
    <String, dynamic>{
      'main': instance.main,
      'additional': instance.additional,
      'ext': instance.ext,
    };
