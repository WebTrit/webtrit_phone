import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/extended_text_style.dart';

import '../theme_style_factory.dart';
import 'theme_image_style.dart';

class LoginModeSelectScreenStyleFactory implements ThemeStyleFactory<LoginModeSelectScreenStyles> {
  LoginModeSelectScreenStyleFactory(this.config, this.colors, this.defaultFontFamily);

  final LoginModeSelectPageConfig? config;
  final ColorScheme colors;
  final String? defaultFontFamily;

  @override
  LoginModeSelectScreenStyles create() {
    final pictureLogoStyle = ThemeImageStyleFactory(source: config?.mainLogo).create();
    final backgroundDecoration = config?.greetingTextStyle?.toExtendedTextDecoration();

    var textStyle = TextStyle(
      color: colors.onPrimary,
      fontWeight: FontWeight.w600,
    ).merge(config?.greetingTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily));

    if (backgroundDecoration != null) {
      textStyle = textStyle.copyWith(backgroundColor: null);
    }

    return LoginModeSelectScreenStyles(
      primary: LoginModeSelectScreenStyle(
        contentThemeOverride: config?.themeOverride.mode.toThemeMode(),
        applyToAppBar: config?.themeOverride.applyToAppBar,
        systemUiOverlayStyle: config?.systemUiOverlayStyle?.toSystemUiOverlayStyle(),
        pictureLogoStyle: pictureLogoStyle,
        onboardingTextStyle: ExtendedTextStyle(textStyle: textStyle, decoration: backgroundDecoration),
        signInTypeButton: config?.buttonSignupStyleType,
        signUpTypeButton: config?.buttonLoginStyleType,
      ),
    );
  }
}
