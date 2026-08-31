// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'separator_style_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeparatorStyleConfig _$SeparatorStyleConfigFromJson(Map<String, dynamic> json) =>
    _SeparatorStyleConfig(enabled: json['enabled'] as bool?, color: json['color'] as String?);

Map<String, dynamic> _$SeparatorStyleConfigToJson(_SeparatorStyleConfig instance) => <String, dynamic>{
  'enabled': instance.enabled,
  'color': instance.color,
};

const _$_SeparatorStyleConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'description': 'Whether to render the separator. `null` → shown (default).'},
    'color': {'type': 'string', 'description': 'Separator color (hex string, e.g. `#CAC7D1`). `null` → theme default.'},
  },
};
