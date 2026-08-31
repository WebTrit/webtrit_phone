// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomColor _$CustomColorFromJson(Map<String, dynamic> json) =>
    CustomColor(color: json['color'] as String, blend: json['blend'] as bool? ?? true);

Map<String, dynamic> _$CustomColorToJson(CustomColor instance) => <String, dynamic>{
  'color': instance.color,
  'blend': instance.blend,
};

const _$CustomColorJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'color': {'type': 'string', 'description': 'The base color in hex format (e.g., `#FF0000`).'},
    'blend': {
      'type': 'boolean',
      'description': 'Whether this color should blend with the theme seed.',
      'default': true,
    },
  },
  'required': ['color'],
};
