import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';
import 'theme_image_style.dart';

class LoginModeSelectScreenStyleFactory implements ThemeStyleFactory<LoginModeSelectScreenStyles> {
  LoginModeSelectScreenStyleFactory(this.config, this.colors);

  final LoginModeSelectPageConfig? config;
  final ColorScheme colors;

  @override
  LoginModeSelectScreenStyles create() {
    final pictureLogoStyle = ThemeImageStyleFactory(source: config?.mainLogo).create();

    return LoginModeSelectScreenStyles(
      primary: LoginModeSelectScreenStyle(
        systemUiOverlayStyle: config?.systemUiOverlayStyle?.toSystemUiOverlayStyle(),
        pictureLogoStyle: pictureLogoStyle,
        onboardingTextStyle: TextStyle(color: colors.onPrimary, fontWeight: FontWeight.w600),
        signInTypeButton: config?.buttonSignupStyleType,
        signUpTypeButton: config?.buttonLoginStyleType,
      ),
    );
  }
}
