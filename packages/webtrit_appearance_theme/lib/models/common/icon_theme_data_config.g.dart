// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_theme_data_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconThemeDataConfig _$IconThemeDataConfigFromJson(Map<String, dynamic> json) => IconThemeDataConfig(
  size: (json['size'] as num?)?.toDouble(),
  fill: (json['fill'] as num?)?.toDouble(),
  weight: (json['weight'] as num?)?.toDouble(),
  grade: (json['grade'] as num?)?.toDouble(),
  opticalSize: (json['opticalSize'] as num?)?.toDouble(),
  color: json['color'] as String?,
  opacity: (json['opacity'] as num?)?.toDouble(),
  shadows: (json['shadows'] as List<dynamic>?)?.map((e) => ShadowConfig.fromJson(e as Map<String, dynamic>)).toList(),
  applyTextScaling: json['applyTextScaling'] as bool?,
);

Map<String, dynamic> _$IconThemeDataConfigToJson(IconThemeDataConfig instance) => <String, dynamic>{
  'size': instance.size,
  'fill': instance.fill,
  'weight': instance.weight,
  'grade': instance.grade,
  'opticalSize': instance.opticalSize,
  'color': instance.color,
  'opacity': instance.opacity,
  'shadows': instance.shadows?.map((e) => e.toJson()).toList(),
  'applyTextScaling': instance.applyTextScaling,
};

const _$IconThemeDataConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'size': {'type': 'number', 'description': 'The default size for icons.'},
    'fill': {
      'type': 'number',
      'description': 'The default fill for icons (0.0 to 1.0).\nUseful for variable fonts (e.g. Material Symbols).',
    },
    'weight': {
      'type': 'number',
      'description': 'The default weight for icons (e.g. 400.0).\nUseful for variable fonts.',
    },
    'grade': {'type': 'number', 'description': 'The default grade for icons.\nUseful for variable fonts.'},
    'opticalSize': {'type': 'number', 'description': 'The default optical size for icons.\nUseful for variable fonts.'},
    'color': {'type': 'string', 'description': 'The default color for icons (hex string).'},
    'opacity': {'type': 'number', 'description': 'An opacity to apply to both explicit and default icon colors.'},
    'shadows': {
      'type': 'array',
      'items': {r'$ref': r'#/$defs/ShadowConfig'},
      'description': 'A list of shadows to apply to the icons.',
    },
    'applyTextScaling': {'type': 'boolean', 'description': 'Whether to apply text scaling to the icons.'},
  },
  r'$defs': {
    'OffsetConfig': {
      'type': 'object',
      'properties': {
        'dx': {'type': 'number', 'default': 0.0},
        'dy': {'type': 'number', 'default': 0.0},
      },
    },
    'ShadowConfig': {
      'type': 'object',
      'properties': {
        'color': {'type': 'string', 'description': 'Color of the shadow (hex string).'},
        'offset': {r'$ref': r'#/$defs/OffsetConfig', 'description': 'The displacement of the shadow.'},
        'blurRadius': {'type': 'number', 'description': 'The blur radius of the shadow.', 'default': 0.0},
      },
    },
  },
};

ShadowConfig _$ShadowConfigFromJson(Map<String, dynamic> json) => ShadowConfig(
  color: json['color'] as String?,
  offset: json['offset'] == null ? null : OffsetConfig.fromJson(json['offset'] as Map<String, dynamic>),
  blurRadius: (json['blurRadius'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$ShadowConfigToJson(ShadowConfig instance) => <String, dynamic>{
  'color': instance.color,
  'offset': instance.offset?.toJson(),
  'blurRadius': instance.blurRadius,
};

const _$ShadowConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'color': {'type': 'string', 'description': 'Color of the shadow (hex string).'},
    'offset': {r'$ref': r'#/$defs/OffsetConfig', 'description': 'The displacement of the shadow.'},
    'blurRadius': {'type': 'number', 'description': 'The blur radius of the shadow.', 'default': 0.0},
  },
  r'$defs': {
    'OffsetConfig': {
      'type': 'object',
      'properties': {
        'dx': {'type': 'number', 'default': 0.0},
        'dy': {'type': 'number', 'default': 0.0},
      },
    },
  },
};

OffsetConfig _$OffsetConfigFromJson(Map<String, dynamic> json) =>
    OffsetConfig(dx: (json['dx'] as num?)?.toDouble() ?? 0.0, dy: (json['dy'] as num?)?.toDouble() ?? 0.0);

Map<String, dynamic> _$OffsetConfigToJson(OffsetConfig instance) => <String, dynamic>{
  'dx': instance.dx,
  'dy': instance.dy,
};

const _$OffsetConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'dx': {'type': 'number', 'default': 0.0},
    'dy': {'type': 'number', 'default': 0.0},
  },
};
