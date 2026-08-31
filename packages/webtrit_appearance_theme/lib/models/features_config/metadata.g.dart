// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Metadata _$MetadataFromJson(Map<String, dynamic> json) =>
    Metadata(attributes: json['attributes'] as Map<String, dynamic>? ?? const {});

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{'attributes': instance.attributes};

const _$MetadataJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'attributes': {
      'type': 'object',
      'additionalProperties': {'type': 'object'},
      'description': 'A map storing arbitrary key-value pairs for contextual or configuration data.',
      'default': {},
    },
  },
};
