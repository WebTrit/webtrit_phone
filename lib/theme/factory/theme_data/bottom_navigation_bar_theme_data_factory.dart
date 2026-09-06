import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class BottomNavigationBarThemeDataFactory implements ThemeStyleFactory<BottomNavigationBarThemeData> {
  BottomNavigationBarThemeDataFactory(this.colors, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final BottomNavigationBarWidgetConfig config;
  final String? defaultFontFamily;

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
      elevation: config.elevation,
      unselectedItemColor: unselectedItemColor ?? colors.onSurface,
      selectedItemColor: selectedItemColor ?? colors.primary,
      // A style only when the theme names one. A style that exists carries a
      // colour, and Flutter uses that colour instead of the item colours
      // above - so handing one over unasked is how the two item colours came
      // to paint icons and nothing else.
      selectedLabelStyle: config.selectedLabelStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
      unselectedLabelStyle: config.unselectedLabelStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
      selectedIconTheme: config.selectedIconTheme?.toIconThemeData(),
      unselectedIconTheme: config.unselectedIconTheme?.toIconThemeData(),
      showSelectedLabels: config.showSelectedLabels,
      showUnselectedLabels: config.showUnselectedLabels ?? true,
    );
  }
}
