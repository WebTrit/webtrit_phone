import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class AppBarThemeDataFactory implements ThemeStyleFactory<AppBarTheme> {
  const AppBarThemeDataFactory(this.colorScheme, this.config, this.defaultFontFamily);

  final ColorScheme colorScheme;
  final AppBarConfig config;
  final String? defaultFontFamily;

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
      titleTextStyle: _titleTextStyle(),
      toolbarTextStyle: config.toolbarTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
      // Always non-null: an AppBar wraps itself in an AnnotatedRegion, and the engine
      // keeps the previously set value for every null field, so a partial style would
      // leave the bars looking like the screen shown before this one.
      systemOverlayStyle:
          config.systemOverlayStyle?.toSystemUiOverlayStyle(colorScheme.brightness) ??
          systemOverlayStyleOf(colorScheme.brightness),
    );
  }

  // Once the config carries a title style, AppBar takes it verbatim and never
  // falls back to foregroundColor, so the color chain has to be completed here:
  // explicit title color -> configured foreground -> scheme default.
  TextStyle? _titleTextStyle() {
    final titleTextStyle = config.titleTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily);
    if (titleTextStyle == null || titleTextStyle.color != null) return titleTextStyle;
    return titleTextStyle.copyWith(color: config.foregroundColor?.toColor() ?? colorScheme.onSurface);
  }
}
