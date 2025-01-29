import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class TabBarThemeDataFactory implements ThemeStyleFactory<TabBarTheme> {
  TabBarThemeDataFactory(this.colors, this.config);

  final ColorScheme colors;
  final ExtTabBarWidgetConfig? config;

  @override
  TabBarTheme create() {
    final unselectedLabelColor = config?.unSelectedItemColor?.toColor() ?? colors.onSurface;
    const dividerColor = Colors.transparent;
    final labelColor = colors.onPrimary;

    return TabBarTheme(
      unselectedLabelColor: unselectedLabelColor,
      dividerColor: dividerColor,
      labelColor: labelColor,
    );
  }
}
