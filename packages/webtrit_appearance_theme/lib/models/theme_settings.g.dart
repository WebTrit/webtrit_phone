// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeSettingsImpl _$$ThemeSettingsImplFromJson(Map<String, dynamic> json) =>
    _$ThemeSettingsImpl(
      lightColorSchemeConfig: json['lightColorSchemeConfig'] == null
          ? const ColorSchemeConfig()
          : ColorSchemeConfig.fromJson(
              json['lightColorSchemeConfig'] as Map<String, dynamic>),
      darkColorSchemeConfig: json['darkColorSchemeConfig'] == null
          ? const ColorSchemeConfig()
          : ColorSchemeConfig.fromJson(
              json['darkColorSchemeConfig'] as Map<String, dynamic>),
      themeWidgetLightConfig: json['themeWidgetLightConfig'] == null
          ? const ThemeWidgetConfig()
          : ThemeWidgetConfig.fromJson(
              json['themeWidgetLightConfig'] as Map<String, dynamic>),
      themeWidgetDarkConfig: json['themeWidgetDarkConfig'] == null
          ? const ThemeWidgetConfig()
          : ThemeWidgetConfig.fromJson(
              json['themeWidgetDarkConfig'] as Map<String, dynamic>),
      themePageLightConfig: json['themePageLightConfig'] == null
          ? const ThemePageConfig()
          : ThemePageConfig.fromJson(
              json['themePageLightConfig'] as Map<String, dynamic>),
      themePageDarkConfig: json['themePageDarkConfig'] == null
          ? const ThemePageConfig()
          : ThemePageConfig.fromJson(
              json['themePageDarkConfig'] as Map<String, dynamic>),
      appConfig: json['appConfig'] == null
          ? null
          : AppConfig.fromJson(json['appConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ThemeSettingsImplToJson(_$ThemeSettingsImpl instance) =>
    <String, dynamic>{
      'lightColorSchemeConfig': instance.lightColorSchemeConfig,
      'darkColorSchemeConfig': instance.darkColorSchemeConfig,
      'themeWidgetLightConfig': instance.themeWidgetLightConfig,
      'themeWidgetDarkConfig': instance.themeWidgetDarkConfig,
      'themePageLightConfig': instance.themePageLightConfig,
      'themePageDarkConfig': instance.themePageDarkConfig,
      'appConfig': instance.appConfig,
    };
