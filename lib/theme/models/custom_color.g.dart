// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomColor _$CustomColorFromJson(Map<String, dynamic> json) => CustomColor(
      color: const CSSColorConverter().fromJson(json['color'] as String),
      blend: json['blend'] as bool? ?? true,
    );

Map<String, dynamic> _$CustomColorToJson(CustomColor instance) =>
    <String, dynamic>{
      'color': const CSSColorConverter().toJson(instance.color),
      'blend': instance.blend,
    };
