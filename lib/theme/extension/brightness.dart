import 'package:flutter/material.dart';

extension BrightnessExtension on Brightness {
  bool get isLight => this == Brightness.light;

  bool get isDark => this == Brightness.dark;
}
