import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class OnboardingPictureLogoStyleFactory implements ThemeStyleFactory<OnboardingPictureLogoStyles> {
  OnboardingPictureLogoStyleFactory(this.colors, this.imageAssetsConfig, this.loginPageConfig);

  final ColorScheme colors;
  final ImageAssetsConfig? imageAssetsConfig;
  final LoginPageConfig? loginPageConfig;

  @override
  OnboardingPictureLogoStyles create() {
    final textStyleColor = imageAssetsConfig?.onboardingPictureLogo.labelColor?.toColor() ?? colors.onPrimary;

    final primaryOnboardingLogoPath = loginPageConfig?.picture ?? imageAssetsConfig?.primaryOnboardingLogo;
    final scale = loginPageConfig?.scale ?? imageAssetsConfig?.onboardingPictureLogo.scale;

    final textStyle = TextStyle(color: textStyleColor, fontWeight: FontWeight.w600);

    return OnboardingPictureLogoStyles(
      primary: OnboardingPictureLogoStyle(
        picture: primaryOnboardingLogoPath?.toThemeSvgAsset(),
        scale: scale,
        textStyle: textStyle,
      ),
    );
  }
}
