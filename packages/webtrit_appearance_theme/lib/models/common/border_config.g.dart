// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'border_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BorderConfig _$BorderConfigFromJson(Map<String, dynamic> json) => _BorderConfig(
  type: $enumDecodeNullable(_$BorderTypeConfigEnumMap, json['type']) ?? BorderTypeConfig.underline,
  borderRadius: (json['borderRadius'] as num?)?.toDouble(),
  borderColor: json['borderColor'] as String?,
  borderWidth: (json['borderWidth'] as num?)?.toDouble(),
);

Map<String, dynamic> _$BorderConfigToJson(_BorderConfig instance) => <String, dynamic>{
  'type': _$BorderTypeConfigEnumMap[instance.type]!,
  'borderRadius': instance.borderRadius,
  'borderColor': instance.borderColor,
  'borderWidth': instance.borderWidth,
};

const _$_BorderConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'type': {
      'enum': ['underline', 'outline', 'none'],
      'description':
          'Border type:\n- [`BorderTypeConfig.underline`]\n- [`BorderTypeConfig.outline`]\n- [`BorderTypeConfig.none`]',
      'default': 'underline',
    },
    'borderRadius': {'type': 'number', 'description': 'Corner radius for outline borders.'},
    'borderColor': {'type': 'string', 'description': 'Border color (hex string, e.g. `#000000`).'},
    'borderWidth': {'type': 'number', 'description': 'Stroke width of the border.'},
  },
};

const _$BorderTypeConfigEnumMap = {
  BorderTypeConfig.underline: 'underline',
  BorderTypeConfig.outline: 'outline',
  BorderTypeConfig.none: 'none',
};
