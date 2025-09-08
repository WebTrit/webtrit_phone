import 'package:flutter/material.dart';

import '../models/theme_asset.dart';

class LogoAssets extends ThemeExtension<LogoAssets> {
  const LogoAssets({
    required this.primaryOnboarding,
    required this.secondaryOnboarding,
  });

  final ThemeSvgAsset? primaryOnboarding;
  final ThemeSvgAsset? secondaryOnboarding;

  @override
  ThemeExtension<LogoAssets> copyWith({
    ThemeSvgAsset? primaryOnboarding,
    ThemeSvgAsset? secondaryOnboarding,
  }) {
    return LogoAssets(
      primaryOnboarding: primaryOnboarding ?? this.primaryOnboarding,
      secondaryOnboarding: secondaryOnboarding ?? this.secondaryOnboarding,
    );
  }

  @override
  ThemeExtension<LogoAssets> lerp(ThemeExtension<LogoAssets>? other, double t) {
    if (other is! LogoAssets) {
      return this;
    }

    return t < 0.5 ? this : other;
  }
}
