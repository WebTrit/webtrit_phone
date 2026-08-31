// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_data_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconDataConfig _$IconDataConfigFromJson(Map<String, dynamic> json) =>
    IconDataConfig(
      codePoint: const HexCodePointConverter().fromJson(
        json['codePoint'] as String,
      ),
      fontFamily: json['fontFamily'] as String? ?? 'MaterialIcons',
      matchTextDirection: json['matchTextDirection'] as bool? ?? false,
    );

Map<String, dynamic> _$IconDataConfigToJson(IconDataConfig instance) =>
    <String, dynamic>{
      'codePoint': const HexCodePointConverter().toJson(instance.codePoint),
      'fontFamily': instance.fontFamily,
      'matchTextDirection': instance.matchTextDirection,
    };

const _$IconDataConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'codePoint': {'type': 'integer'},
    'fontFamily': {'type': 'string', 'default': 'MaterialIcons'},
    'matchTextDirection': {'type': 'boolean', 'default': false},
  },
  'required': ['codePoint'],
};
