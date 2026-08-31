// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportedThemeMode _$SupportedThemeModeFromJson(Map<String, dynamic> json) =>
    SupportedThemeMode(
      mode:
          $enumDecodeNullable(_$ThemeModeConfigEnumMap, json['mode']) ??
          ThemeModeConfig.system,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SupportedThemeModeToJson(SupportedThemeMode instance) =>
    <String, dynamic>{
      'mode': _$ThemeModeConfigEnumMap[instance.mode]!,
      'type': instance.$type,
    };

const _$SupportedThemeModeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'mode': {
      'enum': ['system', 'light', 'dark'],
      'default': 'system',
    },
    'type': {'type': 'string'},
  },
};

const _$ThemeModeConfigEnumMap = {
  ThemeModeConfig.system: 'system',
  ThemeModeConfig.light: 'light',
  ThemeModeConfig.dark: 'dark',
};

SupportedVideoCall _$SupportedVideoCallFromJson(Map<String, dynamic> json) =>
    SupportedVideoCall(
      enabled: json['enabled'] as bool? ?? true,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SupportedVideoCallToJson(SupportedVideoCall instance) =>
    <String, dynamic>{'enabled': instance.enabled, 'type': instance.$type};

const _$SupportedVideoCallJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'type': {'type': 'string'},
  },
};

SupportedLoggingConfig _$SupportedLoggingConfigFromJson(
  Map<String, dynamic> json,
) => SupportedLoggingConfig(
  logLevel: json['logLevel'] as String? ?? 'INFO',
  checkIntervalSec: (json['checkIntervalSec'] as num?)?.toInt() ?? 15,
  anonymizationEnabled: json['anonymizationEnabled'] as bool? ?? true,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SupportedLoggingConfigToJson(
  SupportedLoggingConfig instance,
) => <String, dynamic>{
  'logLevel': instance.logLevel,
  'checkIntervalSec': instance.checkIntervalSec,
  'anonymizationEnabled': instance.anonymizationEnabled,
  'type': instance.$type,
};

const _$SupportedLoggingConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'logLevel': {'type': 'string', 'default': 'INFO'},
    'checkIntervalSec': {'type': 'integer', 'default': 15},
    'anonymizationEnabled': {'type': 'boolean', 'default': true},
    'type': {'type': 'string'},
  },
};

SupportedSystemNotifications _$SupportedSystemNotificationsFromJson(
  Map<String, dynamic> json,
) => SupportedSystemNotifications(
  enabled: json['enabled'] as bool? ?? true,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SupportedSystemNotificationsToJson(
  SupportedSystemNotifications instance,
) => <String, dynamic>{'enabled': instance.enabled, 'type': instance.$type};

const _$SupportedSystemNotificationsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'type': {'type': 'string'},
  },
};

SupportedHybridPresence _$SupportedHybridPresenceFromJson(
  Map<String, dynamic> json,
) => SupportedHybridPresence(
  enabled: json['enabled'] as bool? ?? true,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SupportedHybridPresenceToJson(
  SupportedHybridPresence instance,
) => <String, dynamic>{'enabled': instance.enabled, 'type': instance.$type};

const _$SupportedHybridPresenceJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'type': {'type': 'string'},
  },
};

SupportedCallPull _$SupportedCallPullFromJson(Map<String, dynamic> json) =>
    SupportedCallPull(
      videoStrategy: json['videoStrategy'] as String? ?? 'softMute',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SupportedCallPullToJson(SupportedCallPull instance) =>
    <String, dynamic>{
      'videoStrategy': instance.videoStrategy,
      'type': instance.$type,
    };

const _$SupportedCallPullJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'videoStrategy': {'type': 'string', 'default': 'softMute'},
    'type': {'type': 'string'},
  },
};
