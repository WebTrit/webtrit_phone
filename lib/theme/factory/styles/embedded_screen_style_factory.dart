import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_page_config.dart';

import 'package:webtrit_phone/features/embedded/view/embedded_screen_style.dart';
import 'package:webtrit_phone/features/embedded/view/embedded_screen_styles.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

import '../theme_style_factory.dart';

class EmbeddedScreenStyleFactory implements ThemeStyleFactory<EmbeddedScreenStyles> {
  EmbeddedScreenStyleFactory(this.colors, this.config, {this.appBarTheme});

  final ColorScheme colors;
  final EmbeddedPageConfig config;
  final AppBarTheme? appBarTheme;

  @override
  EmbeddedScreenStyles create() {
    final backgroundStyle = config.background?.toStyle();

    return EmbeddedScreenStyles(
      primary: EmbeddedScreenStyle(
        background: backgroundStyle,
        appBarBlurredSurface: config.appBarBlurredSurface?.toStyle(),
        contentThemeOverride: config.themeOverride.mode.toThemeMode(),
        applyToAppBar: config.themeOverride.applyToAppBar,
        appBarTheme: appBarTheme,
      ),
    );
  }
}
