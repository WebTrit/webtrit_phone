import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppIconStyle with Diagnosticable {
  AppIconStyle({this.color});

  final Color? color;

  static AppIconStyle lerp(AppIconStyle? a, AppIconStyle? b, double t) {
    return AppIconStyle(color: Color.lerp(a?.color, b?.color, t));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color?>('color', color));
  }
}
