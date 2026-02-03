// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supported_feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportedThemeMode _$SupportedThemeModeFromJson(Map<String, dynamic> json) =>
    SupportedThemeMode(
      mode:
          $enumDecodeNullable(_$ThemeModeConfigEnumMap, json['mode']) ??
          ThemeModeConfig.auto,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$SupportedThemeModeToJson(SupportedThemeMode instance) =>
    <String, dynamic>{
      'mode': _$ThemeModeConfigEnumMap[instance.mode]!,
      'type': instance.$type,
    };

const _$ThemeModeConfigEnumMap = {
  ThemeModeConfig.auto: 'auto',
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
