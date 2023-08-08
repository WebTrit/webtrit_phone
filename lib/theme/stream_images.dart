import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StreamImages extends ThemeExtension<StreamImages> {
  const StreamImages({
    this.primaryOnboardinLogo,
    this.secondaryOnboardinLogo,
  });

  final Stream<SvgLoader?>? primaryOnboardinLogo;
  final Stream<SvgLoader?>? secondaryOnboardinLogo;

  @override
  ThemeExtension<StreamImages> copyWith({
    Stream<SvgLoader?>? primaryOnboardinLogo,
    Stream<SvgLoader?>? secondaryOnboardinLogo,
  }) {
    return StreamImages(
      primaryOnboardinLogo: primaryOnboardinLogo ?? this.primaryOnboardinLogo,
      secondaryOnboardinLogo: secondaryOnboardinLogo ?? this.secondaryOnboardinLogo,
    );
  }

  @override
  ThemeExtension<StreamImages> lerp(ThemeExtension<StreamImages>? other, double t) {
    if (other is! StreamImages) {
      return this;
    }

    return t < 0.5 ? this : other;
  }
}
