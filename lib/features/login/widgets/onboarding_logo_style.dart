import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class OnboardingLogoStyle with Diagnosticable {
  OnboardingLogoStyle({
    this.picture,
    this.scale,
    this.textStyle,
  });

  final ThemeSvgAsset? picture;
  final double? scale;
  final TextStyle? textStyle;

  static OnboardingLogoStyle? lerp(OnboardingLogoStyle? a, OnboardingLogoStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return OnboardingLogoStyle(
      picture: t < 0.5 ? a?.picture : b?.picture,
      scale: LerpTools.lerpDouble(a?.scale, b?.scale, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeSvgAsset?>('picture', picture));
    properties.add(DiagnosticsProperty<double?>('scale', scale));
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle));
  }
}
