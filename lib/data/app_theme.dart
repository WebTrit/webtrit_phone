import 'package:flutter/painting.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/theme/theme.dart';

import 'package:style/style.dart';

import 'app_style_config.dart';

class AppTheme {
  static late AppTheme _instance;

  static Future<void> init() async {
    StyleManager.setting(
      host: AppStyleConfig().publisherConfig.host,
    );

    StyleManager.init(
        applicationId: AppStyleConfig().publisherConfig.applicationId,
        themeId: AppStyleConfig().publisherConfig.themeId,
        defaultTheme: Assets.style.webtrit);

    final styleModel = await StyleManager().get();

    final imageScheme = ImagesScheme()
      ..setApplicationLogoByUrl(styleModel.images!.applicationLogo)
      ..setOnboardingByUrl(styleModel.images!.onboarding);

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
        .map(
          (hex) => CustomColor(color: _toColor(hex)!, blend: false),
        )
        .toList();

    final theme = ThemeSettings(
      seedColor: _toColor(styleModel.colors!.primary)!,
      imagesScheme: imageScheme,
      lightColorSchemeOverride: colorScheme,
      primaryGradientColors: gradientTabColor,
      fontFamily: styleModel.fontFamily ?? 'Montserrat',
      appName: styleModel.name,
    );

    _instance = AppTheme._(theme);
  }

  static Color? _toColor(String? hex) {
    return UtilityColor.tryParseColorFromHex(hex);
  }

  factory AppTheme() {
    return _instance;
  }

  AppTheme._(this._theme);

  ThemeSettings _theme;

  ThemeSettings get theme => _theme;
}
