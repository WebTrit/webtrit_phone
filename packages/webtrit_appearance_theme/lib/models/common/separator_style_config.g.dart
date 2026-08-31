// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'separator_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeparatorStyleConfig _$SeparatorStyleConfigFromJson(Map<String, dynamic> json) =>
    SeparatorStyleConfig(enabled: json['enabled'] as bool?, color: json['color'] as String?);

Map<String, dynamic> _$SeparatorStyleConfigToJson(SeparatorStyleConfig instance) => <String, dynamic>{
  'enabled': instance.enabled,
  'color': instance.color,
};

const _$SeparatorStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'description': 'Whether to render the separator. `null` → shown (default).'},
    'color': {'type': 'string', 'description': 'Separator color (hex string, e.g. `#CAC7D1`). `null` → theme default.'},
  },
};
