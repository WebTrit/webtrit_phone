import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class OnboardingPictureLogoStyle with Diagnosticable {
  OnboardingPictureLogoStyle({
    this.picture,
    this.widthFactor,
    this.textStyle,
  });

  final ThemeSvgAsset? picture;
  final double? widthFactor;
  final TextStyle? textStyle;

  static OnboardingPictureLogoStyle? lerp(OnboardingPictureLogoStyle? a, OnboardingPictureLogoStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return OnboardingPictureLogoStyle(
      picture: t < 0.5 ? a?.picture : b?.picture,
      widthFactor: LerpTools.lerpDouble(a?.widthFactor, b?.widthFactor, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeSvgAsset?>('picture', picture));
    properties.add(DiagnosticsProperty<double?>('widthFactor', widthFactor));
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle));
  }
}
