import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/assets.gen.dart';

class GenImages extends ThemeExtension<GenImages> {
  const GenImages({
    this.logo,
    this.loginOnboarding,
  });

  final SvgGenImage? logo;
  final SvgGenImage? loginOnboarding;

  @override
  ThemeExtension<GenImages> copyWith({
    SvgGenImage? logo,
    SvgGenImage? loginOnboarding,
  }) {
    return GenImages(
      logo: logo ?? this.logo,
      loginOnboarding: loginOnboarding ?? this.loginOnboarding,
    );
  }

  @override
  ThemeExtension<GenImages> lerp(ThemeExtension<GenImages>? other, double t) {
    if (other is! GenImages) {
      return this;
    }

    return t < 0.5 ? this : other;
  }
}
