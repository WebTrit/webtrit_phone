// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_data_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconDataConfig _$IconDataConfigFromJson(Map<String, dynamic> json) =>
    IconDataConfig(
      codePoint: json['codePoint'] as String,
      fontFamily: json['fontFamily'] as String? ?? 'MaterialIcons',
      matchTextDirection: json['matchTextDirection'] as bool? ?? false,
    );

Map<String, dynamic> _$IconDataConfigToJson(IconDataConfig instance) =>
    <String, dynamic>{
      'codePoint': instance.codePoint,
      'fontFamily': instance.fontFamily,
      'matchTextDirection': instance.matchTextDirection,
    };
