// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSource _$ImageSourceFromJson(Map<String, dynamic> json) => ImageSource(
  id: json['id'] as String?,
  uri: json['uri'] as String?,
  refType: json['refType'] as String? ?? 'asset',
  render: json['render'] == null ? null : ImageRenderSpec.fromJson(json['render'] as Map<String, dynamic>),
  metadata: json['metadata'] == null ? const Metadata() : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ImageSourceToJson(ImageSource instance) => <String, dynamic>{
  'id': instance.id,
  'uri': instance.uri,
  'refType': instance.refType,
  'render': instance.render?.toJson(),
  'metadata': instance.metadata.toJson(),
};

const _$ImageSourceJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'id': {'type': 'string', 'description': 'Backend asset ID (unique identifier in storage).'},
    'uri': {'type': 'string', 'description': 'Unified URI pointing to the resource.'},
    'refType': {'type': 'string', 'description': 'Semantic type of reference (default = "asset").', 'default': 'asset'},
    'render': {r'$ref': r'#/$defs/ImageRenderSpec', 'description': 'Rendering specification (scale, padding, etc.).'},
    'metadata': {r'$ref': r'#/$defs/Metadata', 'description': 'Freeform metadata for CLI or pipeline tools.'},
  },
  r'$defs': {
    'PaddingConfig': {
      'type': 'object',
      'properties': {
        'left': {'type': 'number', 'description': 'Left padding value.', 'default': 0.0},
        'top': {'type': 'number', 'description': 'Top padding value.', 'default': 0.0},
        'right': {'type': 'number', 'description': 'Right padding value.', 'default': 0.0},
        'bottom': {'type': 'number', 'description': 'Bottom padding value.', 'default': 0.0},
      },
    },
    'ImageRenderSpec': {
      'type': 'object',
      'properties': {
        'scale': {'type': 'number'},
        'padding': {r'$ref': r'#/$defs/PaddingConfig'},
        'alignment': {
          'enum': [
            'topLeft',
            'topCenter',
            'topRight',
            'centerLeft',
            'center',
            'centerRight',
            'bottomLeft',
            'bottomCenter',
            'bottomRight',
          ],
        },
        'fit': {
          'enum': ['fill', 'contain', 'cover', 'fitWidth', 'fitHeight', 'none', 'scaleDown'],
        },
      },
    },
    'Metadata': {
      'type': 'object',
      'properties': {
        'attributes': {
          'type': 'object',
          'additionalProperties': {'type': 'object'},
          'description': 'A map storing arbitrary key-value pairs for contextual or configuration data.',
          'default': {},
        },
      },
    },
  },
};

ImageRenderSpec _$ImageRenderSpecFromJson(Map<String, dynamic> json) => ImageRenderSpec(
  scale: (json['scale'] as num?)?.toDouble(),
  padding: json['padding'] == null ? null : PaddingConfig.fromJson(json['padding'] as Map<String, dynamic>),
  alignment: $enumDecodeNullable(
    _$AlignmentConfigEnumMap,
    json['alignment'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  fit: $enumDecodeNullable(_$BoxFitConfigEnumMap, json['fit'], unknownValue: JsonKey.nullForUndefinedEnumValue),
);

Map<String, dynamic> _$ImageRenderSpecToJson(ImageRenderSpec instance) => <String, dynamic>{
  'scale': instance.scale,
  'padding': instance.padding?.toJson(),
  'alignment': _$AlignmentConfigEnumMap[instance.alignment],
  'fit': _$BoxFitConfigEnumMap[instance.fit],
};

const _$ImageRenderSpecJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'scale': {'type': 'number'},
    'padding': {r'$ref': r'#/$defs/PaddingConfig'},
    'alignment': {
      'enum': [
        'topLeft',
        'topCenter',
        'topRight',
        'centerLeft',
        'center',
        'centerRight',
        'bottomLeft',
        'bottomCenter',
        'bottomRight',
      ],
    },
    'fit': {
      'enum': ['fill', 'contain', 'cover', 'fitWidth', 'fitHeight', 'none', 'scaleDown'],
    },
  },
  r'$defs': {
    'PaddingConfig': {
      'type': 'object',
      'properties': {
        'left': {'type': 'number', 'description': 'Left padding value.', 'default': 0.0},
        'top': {'type': 'number', 'description': 'Top padding value.', 'default': 0.0},
        'right': {'type': 'number', 'description': 'Right padding value.', 'default': 0.0},
        'bottom': {'type': 'number', 'description': 'Bottom padding value.', 'default': 0.0},
      },
    },
  },
};

const _$AlignmentConfigEnumMap = {
  AlignmentConfig.topLeft: 'topLeft',
  AlignmentConfig.topCenter: 'topCenter',
  AlignmentConfig.topRight: 'topRight',
  AlignmentConfig.centerLeft: 'centerLeft',
  AlignmentConfig.center: 'center',
  AlignmentConfig.centerRight: 'centerRight',
  AlignmentConfig.bottomLeft: 'bottomLeft',
  AlignmentConfig.bottomCenter: 'bottomCenter',
  AlignmentConfig.bottomRight: 'bottomRight',
};

const _$BoxFitConfigEnumMap = {
  BoxFitConfig.fill: 'fill',
  BoxFitConfig.contain: 'contain',
  BoxFitConfig.cover: 'cover',
  BoxFitConfig.fitWidth: 'fitWidth',
  BoxFitConfig.fitHeight: 'fitHeight',
  BoxFitConfig.none: 'none',
  BoxFitConfig.scaleDown: 'scaleDown',
};
