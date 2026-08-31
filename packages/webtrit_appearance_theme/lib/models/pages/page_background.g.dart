// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_background.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageBackgroundSolid _$PageBackgroundSolidFromJson(Map<String, dynamic> json) =>
    PageBackgroundSolid(
      color: json['color'] as String,
      type: json['type'] as String? ?? 'solid',
    );

Map<String, dynamic> _$PageBackgroundSolidToJson(
  PageBackgroundSolid instance,
) => <String, dynamic>{'color': instance.color, 'type': instance.type};

const _$PageBackgroundSolidJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'color': {'type': 'string'},
    'type': {'type': 'string', 'default': 'solid'},
  },
  'required': ['color'],
};

PageBackgroundGradient _$PageBackgroundGradientFromJson(
  Map<String, dynamic> json,
) => PageBackgroundGradient(
  colors: (json['colors'] as List<dynamic>).map((e) => e as String).toList(),
  stops:
      (json['stops'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList() ??
      const [0.0, 1.0],
  beginX: (json['beginX'] as num?)?.toDouble() ?? 0.0,
  beginY: (json['beginY'] as num?)?.toDouble() ?? 0.0,
  endX: (json['endX'] as num?)?.toDouble() ?? 1.0,
  endY: (json['endY'] as num?)?.toDouble() ?? 1.0,
  type: json['type'] as String? ?? 'gradient',
);

Map<String, dynamic> _$PageBackgroundGradientToJson(
  PageBackgroundGradient instance,
) => <String, dynamic>{
  'colors': instance.colors,
  'stops': instance.stops,
  'beginX': instance.beginX,
  'beginY': instance.beginY,
  'endX': instance.endX,
  'endY': instance.endY,
  'type': instance.type,
};

const _$PageBackgroundGradientJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'colors': {
      'type': 'array',
      'items': {'type': 'string'},
    },
    'stops': {
      'type': 'array',
      'items': {'type': 'number'},
      'default': [0.0, 1.0],
    },
    'beginX': {'type': 'number', 'default': 0.0},
    'beginY': {'type': 'number', 'default': 0.0},
    'endX': {'type': 'number', 'default': 1.0},
    'endY': {'type': 'number', 'default': 1.0},
    'type': {'type': 'string', 'default': 'gradient'},
  },
  'required': ['colors'],
};

PageBackgroundImage _$PageBackgroundImageFromJson(Map<String, dynamic> json) =>
    PageBackgroundImage(
      imageUrl: json['imageUrl'] as String,
      fit:
          $enumDecodeNullable(_$BoxFitConfigEnumMap, json['fit']) ??
          BoxFitConfig.cover,
      opacity: (json['opacity'] as num?)?.toDouble() ?? 1.0,
      type: json['type'] as String? ?? 'image',
    );

Map<String, dynamic> _$PageBackgroundImageToJson(
  PageBackgroundImage instance,
) => <String, dynamic>{
  'imageUrl': instance.imageUrl,
  'fit': _$BoxFitConfigEnumMap[instance.fit]!,
  'opacity': instance.opacity,
  'type': instance.type,
};

const _$PageBackgroundImageJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'imageUrl': {'type': 'string'},
    'fit': {
      'enum': [
        'fill',
        'contain',
        'cover',
        'fitWidth',
        'fitHeight',
        'none',
        'scaleDown',
      ],
      'default': 'cover',
    },
    'opacity': {'type': 'number', 'default': 1.0},
    'type': {'type': 'string', 'default': 'image'},
  },
  'required': ['imageUrl'],
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
