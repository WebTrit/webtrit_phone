import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class OnboardingPictureLogoStyle {
  OnboardingPictureLogoStyle({
    this.picture,
    this.scale,
    this.textStyle,
  });

  final ThemeSvgAsset? picture;
  final double? scale;
  final TextStyle? textStyle;

  static OnboardingPictureLogoStyle? lerp(OnboardingPictureLogoStyle? a, OnboardingPictureLogoStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return OnboardingPictureLogoStyle(
      picture: t < 0.5 ? a?.picture : b?.picture,
      scale: LerpTools.lerpDouble(a?.scale, b?.scale, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }
}
