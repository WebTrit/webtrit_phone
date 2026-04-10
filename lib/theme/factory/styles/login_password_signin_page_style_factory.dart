import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/login/features/login_password_signin/login_password_signin.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class LoginPasswordSigninPageStyleFactory implements ThemeStyleFactory<LoginPasswordSigninPageStyles> {
  LoginPasswordSigninPageStyleFactory(
    this.colors,
    this.defaultFontFamily, {
    required this.config,
    required this.textTheme,
  });

  final ColorScheme colors;
  final LoginPasswordSigninPageConfig? config;
  final TextTheme textTheme;
  final String? defaultFontFamily;

  @override
  LoginPasswordSigninPageStyles create() {
    final defaultInputFontSize = textTheme.bodyLarge?.fontSize ?? 16.0;
    final defaultInputFontWeight = textTheme.bodyLarge?.fontWeight ?? FontWeight.w400;
    final defaultInputColor = textTheme.bodyLarge?.color ?? colors.onSurface;

    final themeData = ThemeData(colorScheme: colors);

    final baseTextFieldStyle = TextFieldStyle(
      textStyle: TextStyle(
        fontSize: defaultInputFontSize,
        fontWeight: defaultInputFontWeight,
        color: defaultInputColor,
      ),
    );

    return LoginPasswordSigninPageStyles(
      primary: LoginPasswordSigninPageStyle(
        refInput: config?.refTextField?.toStyle(
          colors: colors,
          defaultFontFamily: defaultFontFamily,
          theme: themeData,
          base: baseTextFieldStyle,
        ),
        passwordInput: config?.passwordTextField?.toStyle(
          colors: colors,
          defaultFontFamily: defaultFontFamily,
          theme: themeData,
          base: baseTextFieldStyle,
        ),
      ),
    );
  }
}
