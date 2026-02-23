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

SupportedLoggingConfig _$SupportedLoggingConfigFromJson(
  Map<String, dynamic> json,
) => SupportedLoggingConfig(
  logLevel: json['logLevel'] as String? ?? 'INFO',
  checkIntervalSec: (json['checkIntervalSec'] as num?)?.toInt() ?? 15,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SupportedLoggingConfigToJson(
  SupportedLoggingConfig instance,
) => <String, dynamic>{
  'logLevel': instance.logLevel,
  'checkIntervalSec': instance.checkIntervalSec,
  'type': instance.$type,
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

SupportedSipPresence _$SupportedSipPresenceFromJson(
  Map<String, dynamic> json,
) => SupportedSipPresence(
  enabled: json['enabled'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$SupportedSipPresenceToJson(
  SupportedSipPresence instance,
) => <String, dynamic>{'enabled': instance.enabled, 'type': instance.$type};
