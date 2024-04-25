import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/login/widgets/onboarding_picture_logo_style.dart';

class OnboardingPictureLogoStyles extends ThemeExtension<OnboardingPictureLogoStyles> {
  const OnboardingPictureLogoStyles({
    required this.primary,
  });

  final OnboardingPictureLogoStyle? primary;

  @override
  ThemeExtension<OnboardingPictureLogoStyles> copyWith({
    OnboardingPictureLogoStyle? primary,
  }) {
    return OnboardingPictureLogoStyles(
      primary: primary ?? this.primary,
    );
  }

  @override
  ThemeExtension<OnboardingPictureLogoStyles> lerp(ThemeExtension<OnboardingPictureLogoStyles>? other, double t) {
    if (other == null || primary == null || other is! OnboardingPictureLogoStyles) {
      return this;
    }

    return OnboardingPictureLogoStyles(primary: OnboardingPictureLogoStyle.lerp(primary, other.primary, t));
  }
}
