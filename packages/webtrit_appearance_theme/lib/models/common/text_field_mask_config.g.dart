// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_field_mask_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaskConfig _$MaskConfigFromJson(Map<String, dynamic> json) => MaskConfig(
  pattern: json['pattern'] as String?,
  filter: (json['filter'] as Map<String, dynamic>?)?.map(
    (k, e) => MapEntry(k, e as String),
  ),
);

Map<String, dynamic> _$MaskConfigToJson(MaskConfig instance) =>
    <String, dynamic>{'pattern': instance.pattern, 'filter': instance.filter};
