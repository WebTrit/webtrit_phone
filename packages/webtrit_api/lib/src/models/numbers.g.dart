// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'numbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Numbers _$$_NumbersFromJson(Map<String, dynamic> json) => _$_Numbers(
      additional: (json['additional'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ext: json['ext'] as String?,
      main: json['main'] as String?,
    );

Map<String, dynamic> _$$_NumbersToJson(_$_Numbers instance) =>
    <String, dynamic>{
      'additional': instance.additional,
      'ext': instance.ext,
      'main': instance.main,
    };
