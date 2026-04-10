// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'border_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BorderConfig _$BorderConfigFromJson(Map<String, dynamic> json) =>
    _BorderConfig(
      type:
          $enumDecodeNullable(_$BorderTypeConfigEnumMap, json['type']) ??
          BorderTypeConfig.underline,
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
      borderColor: json['borderColor'] as String?,
      borderWidth: (json['borderWidth'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BorderConfigToJson(_BorderConfig instance) =>
    <String, dynamic>{
      'type': _$BorderTypeConfigEnumMap[instance.type]!,
      'borderRadius': instance.borderRadius,
      'borderColor': instance.borderColor,
      'borderWidth': instance.borderWidth,
    };

const _$BorderTypeConfigEnumMap = {
  BorderTypeConfig.underline: 'underline',
  BorderTypeConfig.outline: 'outline',
  BorderTypeConfig.none: 'none',
};
