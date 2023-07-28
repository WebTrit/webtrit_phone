import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

import 'package:style/style.dart';

class AppBranding {
  static late AppBranding _instance;

  static Future<void> init() async {
    final config = await _initStyleManager();
    final styleModel = await _getStyleModel(config);

    //TODO: Need logic for resource choice
    final imageScheme = ImagesScheme()
      ..setPrimaryOnboardingLogo(url: styleModel.images!.primaryOnboardingLogo)
      ..setSecondaryOnboardingLogo(url: styleModel.images!.secondaryOnboardingLogo);

    final colorScheme = ColorSchemeOverride(
      primary: _toColor(styleModel.colors?.primary),
      onPrimary: _toColor(styleModel.colors?.onPrimary),
      onSurface: _toColor(styleModel.colors?.onSurface),
      surface: _toColor(styleModel.colors?.surface),
      onSecondaryContainer: _toColor(styleModel.colors?.onSecondaryContainer),
      secondaryContainer: _toColor(styleModel.colors?.secondaryContainer),
      tertiary: _toColor(styleModel.colors?.tertiary),
      error: _toColor(styleModel.colors?.error),
      secondary: _toColor(styleModel.colors?.secondary),
      outline: _toColor(styleModel.colors?.outline),
      background: _toColor(styleModel.colors?.background),
      onBackground: _toColor(styleModel.colors?.onBackground),
    );

    final gradientTabColor = (styleModel.colors?.gradientTabColor ?? [])
        .map((hex) => CustomColor(color: _toColor(hex)!, blend: false))
        .toList();

    final theme = ThemeSettings(
      seedColor: _toColor(styleModel.colors!.primary)!,
      imagesScheme: imageScheme,
      lightColorSchemeOverride: colorScheme,
      primaryGradientColors: gradientTabColor,
      fontFamily: styleModel.fontFamily ?? 'Montserrat',
      appName: styleModel.name,
    );

    _instance = AppBranding._(theme);
  }

  static Future<Config> _initStyleManager() async {
    final jsonString = await rootBundle.loadString('publisher.json');
    final config = Config.fromJson(json.decode(jsonString));

    StyleManager.init(defaultTheme: Assets.style.branding, url: config.hosts.prod);

    return config;
  }

  static Future<ThemeDTO> _getStyleModel(Config config) async {
    if (config.autoUpdate) {
      return await StyleManager().getById(config.mapping.getApplicationId, config.mapping.getThemeId);
    } else {
      return await StyleManager().getDefault();
    }
  }

  static Color? _toColor(String? hex) {
    return UtilityColor.tryParseColorFromHex(hex);
  }

  factory AppBranding() {
    return _instance;
  }

  AppBranding._(this._theme);

  ThemeSettings _theme;

  ThemeSettings get theme => _theme;
}
