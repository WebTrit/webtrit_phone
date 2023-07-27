import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenImages extends ThemeExtension<GenImages> {
  const GenImages({
    this.logo,
    this.logoV2,
    this.loginOnboarding,
  });

  final Stream<SvgLoader?>? logo;
  final Stream<SvgLoader?>? logoV2;
  final Stream<SvgLoader?>? loginOnboarding;

  @override
  ThemeExtension<GenImages> copyWith({
    Stream<SvgLoader?>? logo,
    Stream<SvgLoader?>? logoV2,
    Stream<SvgLoader?>? loginOnboarding,
  }) {
    return GenImages(
      logo: logo ?? this.logo,
      logoV2: logoV2 ?? this.logoV2,
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
