import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:equatable/equatable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

final Logger _logger = Logger('AppThemes');

class AppThemes {
  static const _fontPreloadTimeout = Duration(seconds: 3);

  static Future<AppThemes> init() async {
    final themeColorSchemeLightConfigJson = await _getJson(Assets.themes.originalColorSchemeLightConfig);
    final themeColorSchemeDarkConfigJson = await _getJson(Assets.themes.originalColorSchemeDarkConfig);

    final themeWidgetLightConfigJson = await _getJson(Assets.themes.originalWidgetLightConfig);
    final themePageLightConfigJson = await _getJson(Assets.themes.originalPageLightConfig);

    final themeWidgetDarkConfigJson = await _getJson(Assets.themes.originalWidgetDarkConfig);
    final themePageDarkConfigJson = await _getJson(Assets.themes.originalPageDarkConfig);

    final appConfigJson = await _getJson(Assets.themes.appConfig);
    final eppEmbeddedConfigJson = await _getJson(Assets.themes.appEmbeddedConfig);

    final themeColorSchemeLightConfig = ColorSchemeConfig.fromJson(themeColorSchemeLightConfigJson);
    final themeColorSchemeDarkConfig = ColorSchemeConfig.fromJson(themeColorSchemeDarkConfigJson);

    final themeWidgetLightConfig = ThemeWidgetConfig.fromJson(themeWidgetLightConfigJson);
    final themePageLightConfig = ThemePageConfig.fromJson(themePageLightConfigJson);

    final themeWidgetDarkConfig = ThemeWidgetConfig.fromJson(themeWidgetDarkConfigJson);
    final themePageDarkConfig = ThemePageConfig.fromJson(themePageDarkConfigJson);

    final appConfig = AppConfig.fromJson(appConfigJson);
    final embeddedResources = (eppEmbeddedConfigJson as List)
        .map<EmbeddedResource>((e) => EmbeddedResource.fromJson(Map<String, dynamic>.from(e)))
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

    await _preloadFonts(themeWidgetLightConfig, themeWidgetDarkConfig);

    return AppThemes._(themes, appConfig, embeddedResources);
  }

  // TODO(offline-fonts): In the future, run flutter pub run google_fonts:update
  // to bundle the required TTF fonts into assets and update pubspec.yaml.
  // After that, set GoogleFonts.config.allowRuntimeFetching = false
  // permanently to avoid any network dependency.
  static Future<void> _preloadFonts(ThemeWidgetConfig lightConfig, ThemeWidgetConfig darkConfig) async {
    GoogleFonts.config.allowRuntimeFetching = true;

    try {
      final families = <String>{
        if (lightConfig.fonts.fontFamily != null) lightConfig.fonts.fontFamily!,
        if (darkConfig.fonts.fontFamily != null) darkConfig.fonts.fontFamily!,
      }.toList();

      if (families.isEmpty) return;

      await GoogleFonts.pendingFonts([for (final font in families) GoogleFonts.getFont(font)]).timeout(
        _fontPreloadTimeout,
        onTimeout: () {
          _logger.warning('Preloading Google Fonts timed out ($_fontPreloadTimeout)');
          return const [];
        },
      );
    } catch (e, st) {
      _logger.finest('Failed to preload Google Fonts: $e\n$st');
    }
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
