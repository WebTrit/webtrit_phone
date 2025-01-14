import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:equatable/equatable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

final Logger _logger = Logger('AppThemes');

class AppThemes {
  static late AppThemes _instance;

  static Future<AppThemes> init() async {
    final themeColorSchemeLightConfigJson = await _getJson(Assets.themes.originalColorSchemeLightConfig);
    final themeColorSchemeDarkConfigJson = await _getJson(Assets.themes.originalColorSchemeDarkConfig);

    final themeWidgetLightConfigJson = await _getJson(Assets.themes.originalWidgetLightConfig);
    final themePageLightConfigJson = await _getJson(Assets.themes.originalPageLightConfig);

    final themeWidgetDarkConfigJson = await _getJson(Assets.themes.originalWidgetDarkConfig);
    final themePageDarkConfigJson = await _getJson(Assets.themes.originalPageDarkConfig);

    final appConfigJson = await _getJson(Assets.themes.appConfig);


    final themeColorSchemeLightConfig= ColorSchemeConfig.fromJson(themeColorSchemeLightConfigJson);
    final themeColorSchemeDarkConfig = ColorSchemeConfig.fromJson(themeColorSchemeDarkConfigJson);

    final themeWidgetLightConfig = ThemeWidgetConfig.fromJson(themeWidgetLightConfigJson);
    final themePageLightConfig = ThemePageConfig.fromJson(themePageLightConfigJson);

    final themeWidgetDarkConfig = ThemeWidgetConfig.fromJson(themeWidgetDarkConfigJson);
    final themePageDarkConfig = ThemePageConfig.fromJson(themePageDarkConfigJson);

    final appConfig = AppConfig.fromJson(appConfigJson);

    final settings = ThemeSettings(
      lightColorSchemeConfig: themeColorSchemeLightConfig,
      darkColorSchemeConfig: themeColorSchemeDarkConfig,
      themeWidgetLightConfig: themeWidgetLightConfig,
      themePageLightConfig: themePageLightConfig,
      themeWidgetDarkConfig: themeWidgetDarkConfig,
      themePageDarkConfig: themePageDarkConfig,
    );

    final themes = [AppTheme(settings: settings)];

    try {
      // Preload Google Fonts for preventing flickering during the first render
      await GoogleFonts.pendingFonts([
        GoogleFonts.getFont((themeWidgetLightConfig.fonts.fontFamily)),
        GoogleFonts.getFont((themeWidgetDarkConfig.fonts.fontFamily)),
      ]);
    } catch (e) {
      _logger.warning('Failed to preload Google Fonts: $e');
    }

    _instance = AppThemes._(themes, appConfig);
    return _instance;
  }

  static Future<dynamic> _getJson(String path) async {
    return jsonDecode(await rootBundle.loadString(path));
  }

  factory AppThemes() {
    return _instance;
  }

  AppThemes._(this.values, this.appConfig);

  final List<AppTheme> values;
  final AppConfig appConfig;
}

class AppTheme extends Equatable {
  const AppTheme({
    required this.settings,
  });

  final ThemeSettings settings;

  @override
  List<Object> get props => [
        settings,
      ];
}
