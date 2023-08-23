import 'package:flutter/material.dart';
import 'package:webtrit_phone/utils/utils.dart';

class SvgAssets extends ThemeExtension<SvgAssets> {
  const SvgAssets({
    required this.primaryOnboardingLogo,
    required this.secondaryOnboardingLogo,
  });

  final SvgAssetImg? primaryOnboardingLogo;
  final SvgAssetImg? secondaryOnboardingLogo;

  @override
  ThemeExtension<SvgAssets> copyWith({
    SvgAssetImg? primaryOnboardingLogo,
    SvgAssetImg? secondaryOnboardingLogo,
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
