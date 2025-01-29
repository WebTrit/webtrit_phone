import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class BottomNavigationBarThemeDataFactory implements ThemeStyleFactory<BottomNavigationBarThemeData> {
  BottomNavigationBarThemeDataFactory(this.colors, this.config);

  final ColorScheme colors;
  final BottomNavigationBarWidgetConfig config;

  @override
  BottomNavigationBarThemeData create() {
    final backgroundColor = config.backgroundColor?.toColor();
    final unselectedItemColor = config.unSelectedItemColor?.toColor();
    final selectedItemColor = config.selectedItemColor?.toColor();

    return BottomNavigationBarThemeData(
      backgroundColor: backgroundColor ?? colors.surface,
      unselectedItemColor: unselectedItemColor,
      selectedItemColor: selectedItemColor,
    );
  }
}
