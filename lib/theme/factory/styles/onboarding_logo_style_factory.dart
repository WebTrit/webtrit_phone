import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class OnboardingLogoStyleFactory implements ThemeStyleFactory<OnboardingLogoStyles> {
  OnboardingLogoStyleFactory(this.colors, this.imageAssetsConfig, this.loginPageConfig);

  final ColorScheme colors;
  final ImageAssetsConfig? imageAssetsConfig;
  final LoginPageConfig? loginPageConfig;

  @override
  OnboardingLogoStyles create() {
    final onboardingLogoConfig = imageAssetsConfig?.secondaryOnboardingLogo;
    final textStyleColor = onboardingLogoConfig?.labelColor?.toColor() ?? colors.onPrimary;

    final onboardingLogoLoginConfig = loginPageConfig?.picture ?? imageAssetsConfig?.secondaryOnboardingLogo.uri;
    final scale = loginPageConfig?.scale ?? imageAssetsConfig?.secondaryOnboardingLogo.scale;
    final textStyle = TextStyle(color: textStyleColor, fontWeight: FontWeight.w600);

    return OnboardingLogoStyles(
      primary: OnboardingLogoStyle(
        picture: onboardingLogoLoginConfig?.toThemeSvgAsset(),
        scale: scale,
        textStyle: textStyle,
      ),
    );
  }
}
