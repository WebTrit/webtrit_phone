// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeSettings _$ThemeSettingsFromJson(Map<String, dynamic> json) =>
    ThemeSettings(
      lightColorSchemeConfig: json['lightColorSchemeConfig'] == null
          ? const ColorSchemeConfig()
          : ColorSchemeConfig.fromJson(
              json['lightColorSchemeConfig'] as Map<String, dynamic>,
            ),
      darkColorSchemeConfig: json['darkColorSchemeConfig'] == null
          ? const ColorSchemeConfig()
          : ColorSchemeConfig.fromJson(
              json['darkColorSchemeConfig'] as Map<String, dynamic>,
            ),
      themeWidgetLightConfig: json['themeWidgetLightConfig'] == null
          ? const ThemeWidgetConfig()
          : ThemeWidgetConfig.fromJson(
              json['themeWidgetLightConfig'] as Map<String, dynamic>,
            ),
      themeWidgetDarkConfig: json['themeWidgetDarkConfig'] == null
          ? const ThemeWidgetConfig()
          : ThemeWidgetConfig.fromJson(
              json['themeWidgetDarkConfig'] as Map<String, dynamic>,
            ),
      themePageLightConfig: json['themePageLightConfig'] == null
          ? const ThemePageConfig()
          : ThemePageConfig.fromJson(
              json['themePageLightConfig'] as Map<String, dynamic>,
            ),
      themePageDarkConfig: json['themePageDarkConfig'] == null
          ? const ThemePageConfig()
          : ThemePageConfig.fromJson(
              json['themePageDarkConfig'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ThemeSettingsToJson(ThemeSettings instance) =>
    <String, dynamic>{
      'lightColorSchemeConfig': instance.lightColorSchemeConfig.toJson(),
      'darkColorSchemeConfig': instance.darkColorSchemeConfig.toJson(),
      'themeWidgetLightConfig': instance.themeWidgetLightConfig.toJson(),
      'themeWidgetDarkConfig': instance.themeWidgetDarkConfig.toJson(),
      'themePageLightConfig': instance.themePageLightConfig.toJson(),
      'themePageDarkConfig': instance.themePageDarkConfig.toJson(),
    };
