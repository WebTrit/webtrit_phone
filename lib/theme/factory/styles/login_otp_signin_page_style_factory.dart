import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/login/features/login_otp_signin/login_otp_signin.dart';
import 'package:webtrit_phone/theme/styles/styles.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class LoginOtpSigninPageStyleFactory implements ThemeStyleFactory<LoginOtpSigninPageStyles> {
  LoginOtpSigninPageStyleFactory(this.colors, {required this.config, required this.textTheme});

  final ColorScheme colors;
  final LoginOtpSigninPageConfig? config;
  final TextTheme textTheme;

  @override
  LoginOtpSigninPageStyles create() {
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

    final inputRef = config?.refTextField?.toStyle(colors: colors, theme: themeData, base: baseTextFieldStyle);

    return LoginOtpSigninPageStyles(primary: LoginOtpSigninPageStyle(refInput: inputRef));
  }
}
