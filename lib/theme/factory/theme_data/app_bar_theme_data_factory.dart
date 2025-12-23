import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class AppBarThemeDataFactory implements ThemeStyleFactory<AppBarTheme> {
  const AppBarThemeDataFactory(this.config);

  final AppBarConfig config;

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
      titleTextStyle: config.titleTextStyle?.toTextStyle(),
      toolbarTextStyle: config.toolbarTextStyle?.toTextStyle(),
      systemOverlayStyle: config.systemOverlayStyle?.toSystemUiOverlayStyle(),
    );
  }
}
