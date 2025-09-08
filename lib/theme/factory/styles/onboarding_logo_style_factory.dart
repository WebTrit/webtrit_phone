import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class OnboardingLogoStyleFactory implements ThemeStyleFactory<OnboardingLogoStyles> {
  OnboardingLogoStyleFactory(this.colors, this.imageAssetConfig, this.loginPageConfig);

  final ColorScheme colors;
  final ImageAssetConfig? imageAssetConfig;
  final LoginPageConfig? loginPageConfig;

  @override
  OnboardingLogoStyles create() {
    final textStyleColor = imageAssetConfig?.labelColor.toColor() ?? colors.onPrimary;

    final loginPageConfigUri = imageAssetConfig?.imageSource?.uri ??
        // TODO: Remove after migrating all themes to use imageSource
        // ignore: deprecated_member_use
        imageAssetConfig?.uri;
    final imageAssetConfigUri = loginPageConfig?.imageSource?.uri ??
        // TODO: Remove after migrating all themes to use imageSource
        // ignore: deprecated_member_use
        loginPageConfig?.picture;

    final onboardingLogoLoginConfig = loginPageConfigUri ?? imageAssetConfigUri;
    final widthFactor = loginPageConfig?.scale ?? imageAssetConfig?.widthFactor;
    final textStyle = TextStyle(color: textStyleColor, fontWeight: FontWeight.w600);

    return OnboardingLogoStyles(
      primary: OnboardingLogoStyle(
        picture: onboardingLogoLoginConfig?.toThemeSvgAsset(),
        widthFactor: widthFactor,
        textStyle: textStyle,
      ),
    );
  }
}
