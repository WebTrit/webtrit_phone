import 'package:flutter/material.dart';

extension BrightnessExtension on Brightness {
  bool get isLight => this == Brightness.light;

  bool get isDark => this == Brightness.dark;

  /// The opposite brightness - what system bar icons need to stay readable over a
  /// surface of this brightness.
  Brightness get inverted => isLight ? Brightness.dark : Brightness.light;
}
