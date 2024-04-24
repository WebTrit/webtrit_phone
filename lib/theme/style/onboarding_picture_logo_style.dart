import 'package:flutter/material.dart';

import '../tools/tools.dart';

class OnboardingPictureLogoStyle {
  OnboardingPictureLogoStyle({
    this.scale,
    this.textStyle,
  });

  final double? scale;
  final TextStyle? textStyle;

  static OnboardingPictureLogoStyle? lerp(OnboardingPictureLogoStyle? a, OnboardingPictureLogoStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return OnboardingPictureLogoStyle(
      scale: LerpTools.lerpDouble(a?.scale, b?.scale, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }
}
