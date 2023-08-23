import 'package:flutter/material.dart';

import 'theme_asset.dart';

class SvgAssets extends ThemeExtension<SvgAssets> {
  const SvgAssets({
    required this.primaryOnboardingLogo,
    required this.secondaryOnboardingLogo,
  });

  final ThemeSvgAsset? primaryOnboardingLogo;
  final ThemeSvgAsset? secondaryOnboardingLogo;

  @override
  ThemeExtension<SvgAssets> copyWith({
    ThemeSvgAsset? primaryOnboardingLogo,
    ThemeSvgAsset? secondaryOnboardingLogo,
  }) {
    return SvgAssets(
      primaryOnboardingLogo: primaryOnboardingLogo ?? this.primaryOnboardingLogo,
      secondaryOnboardingLogo: secondaryOnboardingLogo ?? this.secondaryOnboardingLogo,
    );
  }

  @override
  ThemeExtension<SvgAssets> lerp(ThemeExtension<SvgAssets>? other, double t) {
    if (other is! SvgAssets) {
      return this;
    }

    return t < 0.5 ? this : other;
  }
}
