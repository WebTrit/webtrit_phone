import 'package:flutter/material.dart';

class AppIconStyle {
  AppIconStyle({
    this.color,
  });

  final Color? color;

  static AppIconStyle lerp(AppIconStyle? a, AppIconStyle? b, double t) {
    return AppIconStyle(
      color: Color.lerp(a?.color, b?.color, t),
    );
  }
}
