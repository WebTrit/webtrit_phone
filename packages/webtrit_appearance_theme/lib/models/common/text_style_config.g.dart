// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextStyleConfig _$TextStyleConfigFromJson(Map<String, dynamic> json) => TextStyleConfig(
  fontFamily: json['fontFamily'] as String?,
  fontSize: (json['fontSize'] as num?)?.toDouble(),
  fontWeight: json['fontWeight'] == null ? null : FontWeightConfig.fromJson(json['fontWeight'] as Map<String, dynamic>),
  fontStyle: json['fontStyle'] == null ? null : FontStyleConfig.fromJson(json['fontStyle'] as Map<String, dynamic>),
  color: json['color'] as String?,
  letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
  wordSpacing: (json['wordSpacing'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  decoration: json['decoration'] == null
      ? null
      : TextDecorationConfig.fromJson(json['decoration'] as Map<String, dynamic>),
  backgroundColor: json['backgroundColor'] as String?,
);

Map<String, dynamic> _$TextStyleConfigToJson(TextStyleConfig instance) => <String, dynamic>{
  'fontFamily': instance.fontFamily,
  'fontSize': instance.fontSize,
  'fontWeight': instance.fontWeight?.toJson(),
  'fontStyle': instance.fontStyle?.toJson(),
  'color': instance.color,
  'letterSpacing': instance.letterSpacing,
  'wordSpacing': instance.wordSpacing,
  'height': instance.height,
  'decoration': instance.decoration?.toJson(),
  'backgroundColor': instance.backgroundColor,
};

FontWeightConfig _$FontWeightConfigFromJson(Map<String, dynamic> json) =>
    FontWeightConfig(weight: (json['weight'] as num).toInt());

Map<String, dynamic> _$FontWeightConfigToJson(FontWeightConfig instance) => <String, dynamic>{
  'weight': instance.weight,
};

FontStyleConfig _$FontStyleConfigFromJson(Map<String, dynamic> json) =>
    FontStyleConfig(value: json['value'] as String? ?? 'normal');

Map<String, dynamic> _$FontStyleConfigToJson(FontStyleConfig instance) => <String, dynamic>{'value': instance.value};

TextDecorationConfig _$TextDecorationConfigFromJson(Map<String, dynamic> json) =>
    TextDecorationConfig(types: (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const []);

Map<String, dynamic> _$TextDecorationConfigToJson(TextDecorationConfig instance) => <String, dynamic>{
  'types': instance.types,
};
