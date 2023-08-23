import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/theme/theme.dart';

class AppTheme {
  static late AppTheme _instance;

  static Future<void> init() async {
    final styleMap = jsonDecode(await rootBundle.loadString(Assets.style.branding));
    ThemeSettings theme = _parseBrandingJson(styleMap);
    _instance = AppTheme._(theme);
  }

  factory AppTheme() {
    return _instance;
  }

  AppTheme._(this._settings);

  ThemeSettings _settings;

  ThemeSettings get settings => _settings;

  static ThemeSettings _parseBrandingJson(Map styleMap) {
    // Get only gradient field
    final gradientSchemeList = (styleMap['color_scheme']['gradient_tab_color'] as List).map((it) => it.toString());

    // Remove gradient field for possibility to cast another fields to string
    styleMap['color_scheme'].remove('gradient_tab_color');

    // Prepare map for getting hex color string
    final colorSchemeMap = Map<String, String>.from(styleMap['color_scheme']);

    // TODO: Used until a dependency is added to import model
    final colorScheme = ColorSchemeOverride(
      primary: colorSchemeMap['primary']?.toColor,
      onPrimary: colorSchemeMap['on_primary']?.toColor,
      onSurface: colorSchemeMap['on_surface']?.toColor,
      surface: colorSchemeMap['surface']?.toColor,
      onSecondaryContainer: colorSchemeMap['on_secondary_container']?.toColor,
      secondaryContainer: colorSchemeMap['secondary_container']?.toColor,
      tertiary: colorSchemeMap['tertiary']?.toColor,
      error: colorSchemeMap['error']?.toColor,
      secondary: colorSchemeMap['secondary']?.toColor,
      outline: colorSchemeMap['outline']?.toColor,
      background: colorSchemeMap['background']?.toColor,
      onBackground: colorSchemeMap['on_background']?.toColor,
    );

    final gradientTabColor =
        List<String>.from(gradientSchemeList).map((hex) => CustomColor(color: hex.toColor!, blend: false)).toList();

    final theme = ThemeSettings(
      seedColor: (colorSchemeMap['primary'] as String).toColor!,
      lightColorSchemeOverride: colorScheme,
      primaryGradientColors: gradientTabColor,
      fontFamily: 'Montserrat',
      primaryOnboardingLogo: ThemeAssetSvgAsset(Assets.primaryOnboardinLogo.path),
      secondaryOnboardingLogo: ThemeAssetSvgAsset(Assets.secondaryOnboardinLogo.path),
    );
    return theme;
  }
}
