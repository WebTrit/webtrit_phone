import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:equatable/equatable.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

class AppThemes {
  static late AppThemes _instance;

  static Future<void> init() async {
    final themeJson = await _getJson(Assets.themes.original);

    final themeWidgetLightConfigJson = await _getJson(Assets.themes.originalWidgetLightConfig);
    final themePageLightConfigJson = await _getJson(Assets.themes.originalPageLightConfig);

    final themeWidgetDarkConfigJson = await _getJson(Assets.themes.originalWidgetDarkConfig);
    final themePageDarkConfigJson = await _getJson(Assets.themes.originalPageDarkConfig);

    final uiComposeConfigJson = await _getJson(Assets.themes.originalUiComposeConfig);

    final themeWidgetLightConfig = ThemeWidgetConfig.fromJson(themeWidgetLightConfigJson);
    final themePageLightConfig = ThemePageConfig.fromJson(themePageLightConfigJson);

    final themeWidgetDarkConfig = ThemeWidgetConfig.fromJson(themeWidgetDarkConfigJson);
    final themePageDarkConfig = ThemePageConfig.fromJson(themePageDarkConfigJson);

    final uiComposeConfig = UiComposeSettings.fromJson(uiComposeConfigJson);

    final settings = ThemeSettings.fromJson(themeJson).copyWith(
      themeWidgetLightConfig: themeWidgetLightConfig,
      themePageLightConfig: themePageLightConfig,
      themeWidgetDarkConfig: themeWidgetDarkConfig,
      themePageDarkConfig: themePageDarkConfig,
    );
    final themes = [AppTheme(settings: settings)];

    /// Preload Google Fonts for preventing flickering during the first render
    if (settings.fontFamily != null) {
      await GoogleFonts.pendingFonts([
        GoogleFonts.getFont(settings.fontFamily!),
      ]);
    }

    _instance = AppThemes._(themes, uiComposeConfig);
  }

  static Future<dynamic> _getJson(String path) async {
    return jsonDecode(await rootBundle.loadString(path));
  }

  factory AppThemes() {
    return _instance;
  }

  AppThemes._(this.values, this.uiComposeSettings);

  final List<AppTheme> values;
  final UiComposeSettings uiComposeSettings;
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
