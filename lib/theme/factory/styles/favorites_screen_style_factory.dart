import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_page_config.dart';

import 'package:webtrit_phone/features/favorites/view/favorites_screen_style.dart';
import 'package:webtrit_phone/features/favorites/view/favorites_screen_styles.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';

import '../theme_style_factory.dart';

class FavoritesScreenStyleFactory implements ThemeStyleFactory<FavoritesScreenStyles> {
  FavoritesScreenStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final FavoritesPageConfig config;

  @override
  FavoritesScreenStyles create() {
    final backgroundStyle = config.background?.toStyle();

    return FavoritesScreenStyles(
      primary: FavoritesScreenStyle(
        background: backgroundStyle,
        contentThemeOverride: config.themeOverride.mode.toContentThemeOverride(),
        applyToAppBar: config.themeOverride.applyToAppBar,
      ),
    );
  }
}
