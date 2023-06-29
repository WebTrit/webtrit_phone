import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenImages extends ThemeExtension<GenImages> {
  const GenImages({
    this.logo,
    this.loginOnboarding,
  });

  final Stream<SvgLoader?>? logo;
  final Stream<SvgLoader?>? loginOnboarding;

  @override
  ThemeExtension<GenImages> copyWith({
    Stream<SvgLoader?>? logo,
    Stream<SvgLoader?>? loginOnboarding,
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
