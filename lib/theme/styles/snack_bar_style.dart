import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SnackBarStyle with Diagnosticable {
  SnackBarStyle({
    this.successBackgroundColor,
    this.errorBackgroundColor,
    this.infoBackgroundColor,
    this.warningBackgroundColor,
  });

  final Color? successBackgroundColor;
  final Color? errorBackgroundColor;
  final Color? infoBackgroundColor;
  final Color? warningBackgroundColor;

  static SnackBarStyle lerp(SnackBarStyle? a, SnackBarStyle? b, double t) {
    return SnackBarStyle(
      successBackgroundColor: Color.lerp(a?.successBackgroundColor, b?.successBackgroundColor, t),
      errorBackgroundColor: Color.lerp(a?.errorBackgroundColor, b?.errorBackgroundColor, t),
      infoBackgroundColor: Color.lerp(a?.infoBackgroundColor, b?.infoBackgroundColor, t),
      warningBackgroundColor: Color.lerp(a?.warningBackgroundColor, b?.warningBackgroundColor, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color?>('successBackgroundColor', successBackgroundColor));
    properties.add(DiagnosticsProperty<Color?>('errorBackgroundColor', errorBackgroundColor));
    properties.add(DiagnosticsProperty<Color?>('infoBackgroundColor', infoBackgroundColor));
    properties.add(DiagnosticsProperty<Color?>('warningBackgroundColor', warningBackgroundColor));
  }
}
