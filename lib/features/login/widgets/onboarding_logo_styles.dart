import 'package:flutter/material.dart';

import 'onboarding_logo_style.dart';

class OnboardingLogoStyles extends ThemeExtension<OnboardingLogoStyles> {
  const OnboardingLogoStyles({
    required this.primary,
  });

  final OnboardingLogoStyle? primary;

  @override
  ThemeExtension<OnboardingLogoStyles> copyWith({
    OnboardingLogoStyle? primary,
  }) {
    return OnboardingLogoStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<OnboardingLogoStyles> lerp(ThemeExtension<OnboardingLogoStyles>? other, double t) {
    if (other == null || primary == null || other is! OnboardingLogoStyles) {
      return this;
    }

    return OnboardingLogoStyles(primary: OnboardingLogoStyle.lerp(primary, other.primary, t));
  }
}
