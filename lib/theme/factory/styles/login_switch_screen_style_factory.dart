import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/features/features.dart';

import '../theme_style_factory.dart';

class LoginSwitchScreenStyleFactory implements ThemeStyleFactory<LoginSwitchScreenStyles> {
  LoginSwitchScreenStyleFactory(this.config, this.colors);

  final LoginSwitchPageConfig? config;
  final ColorScheme colors;

  @override
  LoginSwitchScreenStyles create() {
    final textStyleColor = colors.onPrimary;

    final loginPageConfigUri = config?.mainLogo?.uri;
    final widthFactor = config?.mainLogo?.render?.scale ?? 0.25;

    final textStyle = TextStyle(color: textStyleColor, fontWeight: FontWeight.w600);

    return LoginSwitchScreenStyles(
      primary: LoginSwitchScreenStyle(
        onboardingLogoStyle: OnboardingLogoStyle(
          picture: loginPageConfigUri?.toThemeSvgAsset(),
          widthFactor: widthFactor,
          textStyle: textStyle,
          padding: config?.mainLogo?.render?.padding?.toEdgeInsets(),
        ),
      ),
    );
  }
}
