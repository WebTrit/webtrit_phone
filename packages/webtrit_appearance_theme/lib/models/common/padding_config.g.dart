// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'padding_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaddingConfig _$PaddingConfigFromJson(Map<String, dynamic> json) => PaddingConfig(
  left: (json['left'] as num?)?.toDouble() ?? 0.0,
  top: (json['top'] as num?)?.toDouble() ?? 0.0,
  right: (json['right'] as num?)?.toDouble() ?? 0.0,
  bottom: (json['bottom'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$PaddingConfigToJson(PaddingConfig instance) => <String, dynamic>{
  'left': instance.left,
  'top': instance.top,
  'right': instance.right,
  'bottom': instance.bottom,
};

const _$PaddingConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'left': {'type': 'number', 'description': 'Left padding value.', 'default': 0.0},
    'top': {'type': 'number', 'description': 'Top padding value.', 'default': 0.0},
    'right': {'type': 'number', 'description': 'Right padding value.', 'default': 0.0},
    'bottom': {'type': 'number', 'description': 'Bottom padding value.', 'default': 0.0},
  },
};
