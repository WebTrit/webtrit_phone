// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportedThemeMode _$SupportedThemeModeFromJson(Map<String, dynamic> json) => SupportedThemeMode(
  mode: $enumDecodeNullable(_$ThemeModeConfigEnumMap, json['mode']) ?? ThemeModeConfig.system,
  type: json['type'] as String? ?? 'themeMode',
);

Map<String, dynamic> _$SupportedThemeModeToJson(SupportedThemeMode instance) => <String, dynamic>{
  'mode': _$ThemeModeConfigEnumMap[instance.mode]!,
  'type': instance.type,
};

const _$SupportedThemeModeJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'mode': {'type': 'object'},
    'type': {'type': 'string', 'description': 'The discriminator. Always `themeMode`.', 'default': 'themeMode'},
  },
};

const _$ThemeModeConfigEnumMap = {
  ThemeModeConfig.system: 'system',
  ThemeModeConfig.light: 'light',
  ThemeModeConfig.dark: 'dark',
};

SupportedVideoCall _$SupportedVideoCallFromJson(Map<String, dynamic> json) =>
    SupportedVideoCall(enabled: json['enabled'] as bool? ?? true, type: json['type'] as String? ?? 'videoCall');

Map<String, dynamic> _$SupportedVideoCallToJson(SupportedVideoCall instance) => <String, dynamic>{
  'enabled': instance.enabled,
  'type': instance.type,
};

const _$SupportedVideoCallJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'type': {'type': 'string', 'description': 'The discriminator. Always `videoCall`.', 'default': 'videoCall'},
  },
};

SupportedLoggingConfig _$SupportedLoggingConfigFromJson(Map<String, dynamic> json) => SupportedLoggingConfig(
  logLevel: json['logLevel'] as String? ?? 'INFO',
  checkIntervalSec: (json['checkIntervalSec'] as num?)?.toInt() ?? 15,
  anonymizationEnabled: json['anonymizationEnabled'] as bool? ?? true,
  type: json['type'] as String? ?? 'loggingConfig',
);

Map<String, dynamic> _$SupportedLoggingConfigToJson(SupportedLoggingConfig instance) => <String, dynamic>{
  'logLevel': instance.logLevel,
  'checkIntervalSec': instance.checkIntervalSec,
  'anonymizationEnabled': instance.anonymizationEnabled,
  'type': instance.type,
};

const _$SupportedLoggingConfigJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'logLevel': {'type': 'string', 'description': 'The application log level.', 'default': 'INFO'},
    'checkIntervalSec': {
      'type': 'integer',
      'description': 'How often the RTP traffic monitor checks for traffic, in seconds.',
      'default': 15,
    },
    'anonymizationEnabled': {'type': 'boolean', 'default': true},
    'type': {'type': 'string', 'description': 'The discriminator. Always `loggingConfig`.', 'default': 'loggingConfig'},
  },
};

SupportedSystemNotifications _$SupportedSystemNotificationsFromJson(Map<String, dynamic> json) =>
    SupportedSystemNotifications(
      enabled: json['enabled'] as bool? ?? true,
      type: json['type'] as String? ?? 'systemNotifications',
    );

Map<String, dynamic> _$SupportedSystemNotificationsToJson(SupportedSystemNotifications instance) => <String, dynamic>{
  'enabled': instance.enabled,
  'type': instance.type,
};

const _$SupportedSystemNotificationsJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'type': {
      'type': 'string',
      'description': 'The discriminator. Always `systemNotifications`.',
      'default': 'systemNotifications',
    },
  },
};

SupportedHybridPresence _$SupportedHybridPresenceFromJson(Map<String, dynamic> json) => SupportedHybridPresence(
  enabled: json['enabled'] as bool? ?? true,
  type: json['type'] as String? ?? 'hybridPresence',
);

Map<String, dynamic> _$SupportedHybridPresenceToJson(SupportedHybridPresence instance) => <String, dynamic>{
  'enabled': instance.enabled,
  'type': instance.type,
};

const _$SupportedHybridPresenceJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'enabled': {'type': 'boolean', 'default': true},
    'type': {
      'type': 'string',
      'description': 'The discriminator. Always `hybridPresence`.',
      'default': 'hybridPresence',
    },
  },
};

SupportedCallPull _$SupportedCallPullFromJson(Map<String, dynamic> json) => SupportedCallPull(
  videoStrategy: json['videoStrategy'] as String? ?? 'softMute',
  type: json['type'] as String? ?? 'callPull',
);

Map<String, dynamic> _$SupportedCallPullToJson(SupportedCallPull instance) => <String, dynamic>{
  'videoStrategy': instance.videoStrategy,
  'type': instance.type,
};

const _$SupportedCallPullJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'videoStrategy': {
      'type': 'string',
      'description':
          'Parsed by the app into a call-pull video strategy. `softMute` is the one\nthat needs no backend; the others are `hideVideo` and `mirror`.',
      'default': 'softMute',
    },
    'type': {'type': 'string', 'description': 'The discriminator. Always `callPull`.', 'default': 'callPull'},
  },
};
