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
      iconTheme: _iconTheme(config.iconTheme, colorScheme.onSurface),
      actionsIconTheme: _iconTheme(config.actionsIconTheme, colorScheme.onSurfaceVariant),
      titleTextStyle: _textStyle(config.titleTextStyle),
      toolbarTextStyle: _textStyle(config.toolbarTextStyle),
      // Always non-null: an AppBar wraps itself in an AnnotatedRegion, and the engine
      // keeps the previously set value for every null field, so a partial style would
      // leave the bars looking like the screen shown before this one.
      systemOverlayStyle:
          config.systemOverlayStyle?.toSystemUiOverlayStyle(colorScheme.brightness) ??
          systemOverlayStyleOf(colorScheme.brightness),
    );
  }

  // Once the config carries a style, AppBar takes it verbatim and never falls
  // back to foregroundColor, so the color chain has to be completed here:
  // explicit color -> configured foreground -> scheme default.
  TextStyle? _textStyle(TextStyleConfig? styleConfig) {
    final style = styleConfig?.toTextStyle(defaultFontFamily: defaultFontFamily);
    if (style == null || style.color != null) return style;
    return style.copyWith(color: config.foregroundColor?.toColor() ?? colorScheme.onSurface);
  }

  // Same chain for icon themes; the scheme default mirrors the framework's
  // (onSurface for leading, onSurfaceVariant for actions).
  IconThemeData? _iconTheme(IconThemeDataConfig? iconConfig, Color schemeDefault) {
    final iconTheme = iconConfig?.toIconThemeData();
    if (iconTheme == null || iconTheme.color != null) return iconTheme;
    return iconTheme.copyWith(color: config.foregroundColor?.toColor() ?? schemeDefault);
  }
}
