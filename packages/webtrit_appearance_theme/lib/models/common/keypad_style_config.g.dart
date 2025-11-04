// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keypad_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KeypadStyleConfigImpl _$$KeypadStyleConfigImplFromJson(
  Map<String, dynamic> json,
) => _$KeypadStyleConfigImpl(
  textStyle: json['textStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['textStyle'] as Map<String, dynamic>),
  subtextStyle: json['subtextStyle'] == null
      ? null
      : TextStyleConfig.fromJson(json['subtextStyle'] as Map<String, dynamic>),
  spacing: (json['spacing'] as num?)?.toDouble(),
  padding: (json['padding'] as num?)?.toDouble(),
);

Map<String, dynamic> _$$KeypadStyleConfigImplToJson(
  _$KeypadStyleConfigImpl instance,
) => <String, dynamic>{
  'textStyle': instance.textStyle?.toJson(),
  'subtextStyle': instance.subtextStyle?.toJson(),
  'spacing': instance.spacing,
  'padding': instance.padding,
};
