import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class OnboardingLogoStyleFactory implements ThemeStyleFactory<OnboardingLogoStyles> {
  OnboardingLogoStyleFactory(this.colors, this.pictureWidgetConfig, this.loginPageConfig);

  final ColorScheme colors;
  final PictureWidgetConfig? pictureWidgetConfig;
  final LoginPageConfig? loginPageConfig;

  @override
  OnboardingLogoStyles create() {
    final textStyleColor = pictureWidgetConfig?.onboardingPictureLogo.labelColor?.toColor() ?? colors.onPrimary;

    final primaryOnboardingLogoPath = loginPageConfig?.picture ?? pictureWidgetConfig?.primaryOnboardingLogo;

    final textStyle = TextStyle(color: textStyleColor, fontWeight: FontWeight.w600);

    return OnboardingLogoStyles(
      primary: OnboardingLogoStyle(
        picture: primaryOnboardingLogoPath?.toThemeSvgAsset(),
        scale: pictureWidgetConfig?.onboardingPictureLogo.scale,
        textStyle: textStyle,
      ),
    );
  }
}
