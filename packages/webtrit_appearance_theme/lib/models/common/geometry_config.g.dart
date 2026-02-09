// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geometry_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeConfig _$SizeConfigFromJson(Map<String, dynamic> json) => SizeConfig(
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
);

Map<String, dynamic> _$SizeConfigToJson(SizeConfig instance) =>
    <String, dynamic>{'width': instance.width, 'height': instance.height};

EdgeInsetsConfig _$EdgeInsetsConfigFromJson(Map<String, dynamic> json) =>
    EdgeInsetsConfig(
      left: (json['left'] as num?)?.toDouble() ?? 0.0,
      top: (json['top'] as num?)?.toDouble() ?? 0.0,
      right: (json['right'] as num?)?.toDouble() ?? 0.0,
      bottom: (json['bottom'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$EdgeInsetsConfigToJson(EdgeInsetsConfig instance) =>
    <String, dynamic>{
      'left': instance.left,
      'top': instance.top,
      'right': instance.right,
      'bottom': instance.bottom,
    };

BorderSideConfig _$BorderSideConfigFromJson(Map<String, dynamic> json) =>
    BorderSideConfig(
      color: json['color'] as String?,
      width: (json['width'] as num?)?.toDouble() ?? 1.0,
      style: json['style'] as String? ?? 'solid',
    );

Map<String, dynamic> _$BorderSideConfigToJson(BorderSideConfig instance) =>
    <String, dynamic>{
      'color': instance.color,
      'width': instance.width,
      'style': instance.style,
    };

ShapeBorderConfig _$ShapeBorderConfigFromJson(Map<String, dynamic> json) =>
    ShapeBorderConfig(
      type: json['type'] as String? ?? 'rounded',
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShapeBorderConfigToJson(ShapeBorderConfig instance) =>
    <String, dynamic>{
      'type': instance.type,
      'borderRadius': instance.borderRadius,
    };

VisualDensityConfig _$VisualDensityConfigFromJson(Map<String, dynamic> json) =>
    VisualDensityConfig(
      horizontal: (json['horizontal'] as num?)?.toDouble() ?? 0.0,
      vertical: (json['vertical'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$VisualDensityConfigToJson(
  VisualDensityConfig instance,
) => <String, dynamic>{
  'horizontal': instance.horizontal,
  'vertical': instance.vertical,
};
