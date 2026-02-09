// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'button_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ButtonStyleConfig _$ButtonStyleConfigFromJson(Map<String, dynamic> json) =>
    ButtonStyleConfig(
      textStyle: json['textStyle'] == null
          ? null
          : TextStyleConfig.fromJson(json['textStyle'] as Map<String, dynamic>),
      backgroundColor: json['backgroundColor'] as String?,
      foregroundColor: json['foregroundColor'] as String?,
      overlayColor: json['overlayColor'] as String?,
      shadowColor: json['shadowColor'] as String?,
      surfaceTintColor: json['surfaceTintColor'] as String?,
      elevation: (json['elevation'] as num?)?.toDouble(),
      padding: json['padding'] == null
          ? null
          : EdgeInsetsConfig.fromJson(json['padding'] as Map<String, dynamic>),
      minimumSize: json['minimumSize'] == null
          ? null
          : SizeConfig.fromJson(json['minimumSize'] as Map<String, dynamic>),
      fixedSize: json['fixedSize'] == null
          ? null
          : SizeConfig.fromJson(json['fixedSize'] as Map<String, dynamic>),
      maximumSize: json['maximumSize'] == null
          ? null
          : SizeConfig.fromJson(json['maximumSize'] as Map<String, dynamic>),
      iconColor: json['iconColor'] as String?,
      iconSize: (json['iconSize'] as num?)?.toDouble(),
      side: json['side'] == null
          ? null
          : BorderSideConfig.fromJson(json['side'] as Map<String, dynamic>),
      shape: json['shape'] == null
          ? null
          : ShapeBorderConfig.fromJson(json['shape'] as Map<String, dynamic>),
      visualDensity: json['visualDensity'] == null
          ? null
          : VisualDensityConfig.fromJson(
              json['visualDensity'] as Map<String, dynamic>,
            ),
      animationDuration: (json['animationDuration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ButtonStyleConfigToJson(ButtonStyleConfig instance) =>
    <String, dynamic>{
      'textStyle': instance.textStyle?.toJson(),
      'backgroundColor': instance.backgroundColor,
      'foregroundColor': instance.foregroundColor,
      'overlayColor': instance.overlayColor,
      'shadowColor': instance.shadowColor,
      'surfaceTintColor': instance.surfaceTintColor,
      'elevation': instance.elevation,
      'padding': instance.padding?.toJson(),
      'minimumSize': instance.minimumSize?.toJson(),
      'fixedSize': instance.fixedSize?.toJson(),
      'maximumSize': instance.maximumSize?.toJson(),
      'iconColor': instance.iconColor,
      'iconSize': instance.iconSize,
      'side': instance.side?.toJson(),
      'shape': instance.shape?.toJson(),
      'visualDensity': instance.visualDensity?.toJson(),
      'animationDuration': instance.animationDuration,
    };
