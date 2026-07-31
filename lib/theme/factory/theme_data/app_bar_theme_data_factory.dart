import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class AppBarThemeDataFactory implements ThemeStyleFactory<AppBarTheme> {
  const AppBarThemeDataFactory(this.config, this.defaultFontFamily, this.brightness);

  final AppBarConfig config;
  final String? defaultFontFamily;

  /// Theme brightness, used to complete the app bar's system overlay style.
  final Brightness brightness;

  @override
  AppBarTheme create() {
    return AppBarTheme(
      backgroundColor: config.backgroundColor?.toColor(),
      foregroundColor: config.foregroundColor?.toColor(),
      shadowColor: config.shadowColor?.toColor(),
      surfaceTintColor: config.surfaceTintColor?.toColor(),
      elevation: config.elevation,
      scrolledUnderElevation: config.scrolledUnderElevation,
      titleSpacing: config.titleSpacing,
      leadingWidth: config.leadingWidth,
      toolbarHeight: config.toolbarHeight,
      centerTitle: config.centerTitle,
      iconTheme: config.iconTheme?.toIconThemeData(),
      actionsIconTheme: config.actionsIconTheme?.toIconThemeData(),
      titleTextStyle: config.titleTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
      toolbarTextStyle: config.toolbarTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
      // Always non-null: an AppBar wraps itself in an AnnotatedRegion, and the engine
      // keeps the previously set value for every null field, so a partial style would
      // leave the bars looking like the screen shown before this one.
      systemOverlayStyle:
          config.systemOverlayStyle?.toSystemUiOverlayStyle(brightness) ?? systemOverlayStyleOf(brightness),
    );
  }
}
