// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_theme_data_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IconThemeDataConfig _$IconThemeDataConfigFromJson(Map<String, dynamic> json) =>
    _IconThemeDataConfig(
      size: (json['size'] as num?)?.toDouble(),
      fill: (json['fill'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      grade: (json['grade'] as num?)?.toDouble(),
      opticalSize: (json['opticalSize'] as num?)?.toDouble(),
      color: json['color'] as String?,
      opacity: (json['opacity'] as num?)?.toDouble(),
      shadows: (json['shadows'] as List<dynamic>?)
          ?.map((e) => ShadowConfig.fromJson(e as Map<String, dynamic>))
          .toList(),
      applyTextScaling: json['applyTextScaling'] as bool?,
    );

Map<String, dynamic> _$IconThemeDataConfigToJson(
  _IconThemeDataConfig instance,
) => <String, dynamic>{
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

_ShadowConfig _$ShadowConfigFromJson(Map<String, dynamic> json) =>
    _ShadowConfig(
      color: json['color'] as String?,
      offset: json['offset'] == null
          ? null
          : OffsetConfig.fromJson(json['offset'] as Map<String, dynamic>),
      blurRadius: (json['blurRadius'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ShadowConfigToJson(_ShadowConfig instance) =>
    <String, dynamic>{
      'color': instance.color,
      'offset': instance.offset?.toJson(),
      'blurRadius': instance.blurRadius,
    };

_OffsetConfig _$OffsetConfigFromJson(Map<String, dynamic> json) =>
    _OffsetConfig(
      dx: (json['dx'] as num?)?.toDouble() ?? 0.0,
      dy: (json['dy'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$OffsetConfigToJson(_OffsetConfig instance) =>
    <String, dynamic>{'dx': instance.dx, 'dy': instance.dy};
