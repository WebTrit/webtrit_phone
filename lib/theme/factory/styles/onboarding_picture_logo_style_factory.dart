import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class OnboardingPictureLogoStyleFactory implements ThemeStyleFactory<OnboardingPictureLogoStyles> {
  OnboardingPictureLogoStyleFactory(this.colors, this.imageAssetConfig, this.loginPageConfig);

  final ColorScheme colors;
  final ImageAssetConfig? imageAssetConfig;
  final LoginPageConfig? loginPageConfig;

  @override
  OnboardingPictureLogoStyles create() {
    final textStyleColor = imageAssetConfig?.labelColor.toColor() ?? colors.onPrimary;

    final primaryOnboardingLogoPath = loginPageConfig?.picture ?? imageAssetConfig?.uri;
    final widthFactor = loginPageConfig?.scale ?? imageAssetConfig?.widthFactor;

    final textStyle = TextStyle(color: textStyleColor, fontWeight: FontWeight.w600);

    return OnboardingPictureLogoStyles(
      primary: OnboardingPictureLogoStyle(
        picture: primaryOnboardingLogoPath?.toThemeSvgAsset(),
        scale: widthFactor,
        textStyle: textStyle,
      ),
    );
  }
}
