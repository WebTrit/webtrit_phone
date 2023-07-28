import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenImages extends ThemeExtension<GenImages> {
  const GenImages({
    this.primaryOnboardinLogo,
    this.secondaryOnboardinLogo,
  });

  final Stream<SvgLoader?>? primaryOnboardinLogo;
  final Stream<SvgLoader?>? secondaryOnboardinLogo;

  @override
  ThemeExtension<GenImages> copyWith({
    Stream<SvgLoader?>? primaryOnboardinLogo,
    Stream<SvgLoader?>? secondaryOnboardinLogo,
  }) {
    return GenImages(
      primaryOnboardinLogo: primaryOnboardinLogo ?? this.primaryOnboardinLogo,
      secondaryOnboardinLogo: secondaryOnboardinLogo ?? this.secondaryOnboardinLogo,
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
