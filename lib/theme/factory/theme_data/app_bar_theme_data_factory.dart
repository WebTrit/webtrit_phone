import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class AppBarThemeDataFactory implements ThemeStyleFactory<AppBarTheme> {
  AppBarThemeDataFactory(this.colors, this.config);

  final ColorScheme colors;
  final ExtTabBarWidgetConfig config;

  @override
  AppBarTheme create() {
    final backgroundColor = config.backgroundColor?.toColor();
    final foregroundColor = config.foregroundColor?.toColor();
    const surfaceTintColor = Colors.white;

    return AppBarTheme(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: surfaceTintColor,
      scrolledUnderElevation: 0.0,
      centerTitle: true,
    );
  }
}
