// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TextStyleConfigImpl _$$TextStyleConfigImplFromJson(
  Map<String, dynamic> json,
) => _$TextStyleConfigImpl(
  fontFamily: json['fontFamily'] as String?,
  fontSize: (json['fontSize'] as num?)?.toDouble(),
  fontWeight: json['fontWeight'] == null
      ? null
      : FontWeightConfig.fromJson(json['fontWeight'] as Map<String, dynamic>),
  fontStyle: json['fontStyle'] == null
      ? null
      : FontStyleConfig.fromJson(json['fontStyle'] as Map<String, dynamic>),
  color: json['color'] as String?,
  letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
  wordSpacing: (json['wordSpacing'] as num?)?.toDouble(),
  height: (json['height'] as num?)?.toDouble(),
  decoration: json['decoration'] == null
      ? null
      : TextDecorationConfig.fromJson(
          json['decoration'] as Map<String, dynamic>,
        ),
  backgroundColor: json['backgroundColor'] as String?,
);

Map<String, dynamic> _$$TextStyleConfigImplToJson(
  _$TextStyleConfigImpl instance,
) => <String, dynamic>{
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

_$FontWeightConfigImpl _$$FontWeightConfigImplFromJson(
  Map<String, dynamic> json,
) => _$FontWeightConfigImpl(weight: (json['weight'] as num).toInt());

Map<String, dynamic> _$$FontWeightConfigImplToJson(
  _$FontWeightConfigImpl instance,
) => <String, dynamic>{'weight': instance.weight};

_$FontStyleConfigImpl _$$FontStyleConfigImplFromJson(
  Map<String, dynamic> json,
) => _$FontStyleConfigImpl(value: json['value'] as String? ?? 'normal');

Map<String, dynamic> _$$FontStyleConfigImplToJson(
  _$FontStyleConfigImpl instance,
) => <String, dynamic>{'value': instance.value};

_$TextDecorationConfigImpl _$$TextDecorationConfigImplFromJson(
  Map<String, dynamic> json,
) => _$TextDecorationConfigImpl(
  types:
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$TextDecorationConfigImplToJson(
  _$TextDecorationConfigImpl instance,
) => <String, dynamic>{'types': instance.types};
