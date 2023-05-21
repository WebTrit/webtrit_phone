// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ApplicationDTO _$$_ApplicationDTOFromJson(Map<String, dynamic> json) =>
    _$_ApplicationDTO(
      id: json['id'] as String?,
      name: json['name'] as String?,
      platformIdentifier: json['platformIdentifier'] as String?,
      theme: json['theme'] as String?,
      version: json['version'] as int?,
    );

Map<String, dynamic> _$$_ApplicationDTOToJson(_$_ApplicationDTO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('platformIdentifier', instance.platformIdentifier);
  writeNotNull('theme', instance.theme);
  writeNotNull('version', instance.version);
  return val;
}
