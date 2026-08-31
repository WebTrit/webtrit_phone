// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blurred_surface_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlurredSurfaceConfig _$BlurredSurfaceConfigFromJson(Map<String, dynamic> json) => BlurredSurfaceConfig(
  color: json['color'] as String?,
  sigmaX: (json['sigmaX'] as num?)?.toDouble(),
  sigmaY: (json['sigmaY'] as num?)?.toDouble(),
);

Map<String, dynamic> _$BlurredSurfaceConfigToJson(BlurredSurfaceConfig instance) => <String, dynamic>{
  'color': instance.color,
  'sigmaX': instance.sigmaX,
  'sigmaY': instance.sigmaY,
};

const _$BlurredSurfaceConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'color': {'type': 'string', 'description': 'Overlay color (hex string, e.g. `#000000`).'},
    'sigmaX': {'type': 'number', 'description': 'Horizontal gaussian blur sigma.'},
    'sigmaY': {'type': 'number', 'description': 'Vertical gaussian blur sigma.'},
  },
};
