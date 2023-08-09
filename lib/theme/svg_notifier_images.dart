import 'package:flutter/material.dart';

import 'svg_notifier.dart';

class SvgNotifierImages extends ThemeExtension<SvgNotifierImages> {
  const SvgNotifierImages({
    this.primaryOnboardinLogo,
    this.secondaryOnboardinLogo,
  });

  final SvgNotifier? primaryOnboardinLogo;
  final SvgNotifier? secondaryOnboardinLogo;

  @override
  ThemeExtension<SvgNotifierImages> copyWith({
    SvgNotifier? primaryOnboardinLogo,
    SvgNotifier? secondaryOnboardinLogo,
  }) {
    return SvgNotifierImages(
      primaryOnboardinLogo: primaryOnboardinLogo ?? this.primaryOnboardinLogo,
      secondaryOnboardinLogo: secondaryOnboardinLogo ?? this.secondaryOnboardinLogo,
    );
  }

  @override
  ThemeExtension<SvgNotifierImages> lerp(ThemeExtension<SvgNotifierImages>? other, double t) {
    if (other is! SvgNotifierImages) {
      return this;
    }

    return t < 0.5 ? this : other;
  }
}
