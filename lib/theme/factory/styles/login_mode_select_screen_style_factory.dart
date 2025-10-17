import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';

class LoginModeSelectScreenStyleFactory implements ThemeStyleFactory<LoginModeSelectScreenStyles> {
  LoginModeSelectScreenStyleFactory(this.config, this.colors);

  final LoginModeSelectPageConfig? config;
  final ColorScheme colors;

  @override
  LoginModeSelectScreenStyles create() {
    final textStyleColor = colors.onPrimary;

    final loginPageConfigUri = config?.mainLogo?.uri;
    final primaryOnboardingLogoPath = loginPageConfigUri;
    final widthFactor = config?.mainLogo?.render?.scale ?? 0.25;

    final textStyle = TextStyle(color: textStyleColor, fontWeight: FontWeight.w600);

    return LoginModeSelectScreenStyles(
      primary: LoginModeSelectScreenStyle(
        systemUiOverlayStyle: config?.systemUiOverlayStyle?.toSystemUiOverlayStyle(),
        onboardingPictureLogoStyle: OnboardingPictureLogoStyle(
          picture: primaryOnboardingLogoPath?.toThemeSvgAsset(),
          widthFactor: widthFactor,
          textStyle: textStyle,
          padding: config?.mainLogo?.render?.padding?.toEdgeInsets(),
        ),
        signInTypeButton: config?.buttonSignupStyleType,
        signUpTypeButton: config?.buttonLoginStyleType,
      ),
    );
  }
}
