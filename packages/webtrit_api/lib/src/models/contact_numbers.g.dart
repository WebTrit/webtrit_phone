// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_numbers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ContactNumbers _$$_ContactNumbersFromJson(Map<String, dynamic> json) =>
    _$_ContactNumbers(
      additional: (json['additional'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      ext: json['ext'] as String?,
      main: json['main'] as String?,
    );

Map<String, dynamic> _$$_ContactNumbersToJson(_$_ContactNumbers instance) =>
    <String, dynamic>{
      'additional': instance.additional,
      'ext': instance.ext,
      'main': instance.main,
    };
