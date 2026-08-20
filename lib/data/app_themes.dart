import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:equatable/equatable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

class AppThemes {
  static Future<AppThemes> init() async {
    final themeColorSchemeLightConfigJson = await _getJson(
      Assets.themes.originalColorSchemeLightConfig,
    );
    final themeColorSchemeDarkConfigJson = await _getJson(
      Assets.themes.originalColorSchemeDarkConfig,
    );

    final themeWidgetLightConfigJson = await _getJson(
      Assets.themes.originalWidgetLightConfig,
    );
    final themePageLightConfigJson = await _getJson(
      Assets.themes.originalPageLightConfig,
    );

    final themeWidgetDarkConfigJson = await _getJson(
      Assets.themes.originalWidgetDarkConfig,
    );
    final themePageDarkConfigJson = await _getJson(
      Assets.themes.originalPageDarkConfig,
    );

    final appConfigJson = await _getJson(Assets.themes.appConfig);
    final eppEmbeddedConfigJson = await _getJson(
      Assets.themes.appEmbeddedConfig,
    );

    final themeColorSchemeLightConfig = ColorSchemeConfig.fromJson(
      themeColorSchemeLightConfigJson,
    );
    final themeColorSchemeDarkConfig = ColorSchemeConfig.fromJson(
      themeColorSchemeDarkConfigJson,
    );

    final themeWidgetLightConfig = ThemeWidgetConfig.fromJson(
      themeWidgetLightConfigJson,
    );
    final themePageLightConfig = ThemePageConfig.fromJson(
      themePageLightConfigJson,
    );

    final themeWidgetDarkConfig = ThemeWidgetConfig.fromJson(
      themeWidgetDarkConfigJson,
    );
    final themePageDarkConfig = ThemePageConfig.fromJson(
      themePageDarkConfigJson,
    );

    final appConfig = AppConfig.fromJson(appConfigJson);
    final embeddedResources = (eppEmbeddedConfigJson as List)
        .map<EmbeddedResource>(
          (e) => EmbeddedResource.fromJson(Map<String, dynamic>.from(e)),
        )
        .toList(growable: false);

    final settings = ThemeSettings(
      lightColorSchemeConfig: themeColorSchemeLightConfig,
      darkColorSchemeConfig: themeColorSchemeDarkConfig,
      themeWidgetLightConfig: themeWidgetLightConfig,
      themePageLightConfig: themePageLightConfig,
      themeWidgetDarkConfig: themeWidgetDarkConfig,
      themePageDarkConfig: themePageDarkConfig,
    );

    final themes = [AppTheme(settings: settings)];

    // Fonts are selected and bundled by webtrit_phone_tools during the
    // white-label build. Runtime fetching would reintroduce startup network
    // work and hide a broken generated asset, so production builds fail fast.
    GoogleFonts.config.allowRuntimeFetching = false;

    return AppThemes._(themes, appConfig, embeddedResources);
  }

  static Future<dynamic> _getJson(String path) async {
    return jsonDecode(await rootBundle.loadString(path));
  }

  AppThemes._(this.values, this.appConfig, this.embeddedResources);

  final List<AppTheme> values;
  final AppConfig appConfig;
  final List<EmbeddedResource> embeddedResources;
}

class AppTheme extends Equatable {
  const AppTheme({required this.settings});

  final ThemeSettings settings;

  @override
  List<Object?> get props => [settings];
}
