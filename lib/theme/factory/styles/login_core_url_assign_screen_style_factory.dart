import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class LoginCoreUrlAssignScreenStyleFactory implements ThemeStyleFactory<LoginCoreUrlAssignScreenStyles> {
  LoginCoreUrlAssignScreenStyleFactory(this.config, this.colors, {this.appBarTheme});

  final LoginCoreUrlAssignPageConfig config;
  final ColorScheme colors;
  final AppBarTheme? appBarTheme;

  @override
  LoginCoreUrlAssignScreenStyles create() {
    return LoginCoreUrlAssignScreenStyles(
      primary: LoginCoreUrlAssignScreenStyle(
        systemUiOverlayStyle: config.systemUiOverlayStyle?.toSystemUiOverlayStyle(colors.brightness),
        contentThemeOverride: config.themeOverride.mode.toThemeMode(),
        applyToAppBar: config.themeOverride.applyToAppBar,
        background: config.background?.toStyle(),
        appBarBlurredSurface: config.appBarBlurredSurface?.toStyle(),
        appBarTheme: appBarTheme,
      ),
    );
  }
}
