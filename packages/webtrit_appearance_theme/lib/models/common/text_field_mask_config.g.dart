// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_field_mask_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaskConfig _$MaskConfigFromJson(Map<String, dynamic> json) => MaskConfig(
  pattern: json['pattern'] as String?,
  filter: (json['filter'] as Map<String, dynamic>?)?.map((k, e) => MapEntry(k, e as String)),
);

Map<String, dynamic> _$MaskConfigToJson(MaskConfig instance) => <String, dynamic>{
  'pattern': instance.pattern,
  'filter': instance.filter,
};

const _$MaskConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'pattern': {'type': 'string', 'description': 'The mask pattern, e.g. "+380 (##) ###-##-##"'},
    'filter': {
      'type': 'object',
      'additionalProperties': {'type': 'string'},
      'description':
          'Regex filter map, e.g. {"#": "[0-9]"}\nNote: Values are regex strings, need to be converted to RegExp in UI code.',
    },
  },
};
