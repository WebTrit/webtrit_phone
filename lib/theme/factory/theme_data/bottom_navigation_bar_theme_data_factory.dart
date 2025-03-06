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

    // Providing default values to prevent unexpected styling issues.
    // If backgroundColor is not set, it may default to canvasColor, causing visibility issues,
    // especially when using BottomNavigationBarType.shifting.
    // Likewise, ensuring unselectedItemColor and selectedItemColor are always defined avoids theme inconsistencies.
    // More details on this behavior: https://www.flutterclutter.dev/flutter/troubleshooting/2022-03-23-bottom-navigation-bar-more-than-3-items/
    return BottomNavigationBarThemeData(
      backgroundColor: backgroundColor ?? colors.surface,
      unselectedItemColor: unselectedItemColor ?? colors.onSurface,
      selectedItemColor: selectedItemColor ?? colors.primary,
      showUnselectedLabels: true,
    );
  }
}
