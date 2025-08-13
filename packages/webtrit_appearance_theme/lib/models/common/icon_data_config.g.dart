// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_data_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IconDataConfigImpl _$$IconDataConfigImplFromJson(Map<String, dynamic> json) =>
    _$IconDataConfigImpl(
      codePoint:
          const HexCodePointConverter().fromJson(json['codePoint'] as String),
      fontFamily: json['fontFamily'] as String? ?? 'MaterialIcons',
      matchTextDirection: json['matchTextDirection'] as bool? ?? false,
    );

Map<String, dynamic> _$$IconDataConfigImplToJson(
        _$IconDataConfigImpl instance) =>
    <String, dynamic>{
      'codePoint': const HexCodePointConverter().toJson(instance.codePoint),
      'fontFamily': instance.fontFamily,
      'matchTextDirection': instance.matchTextDirection,
    };
