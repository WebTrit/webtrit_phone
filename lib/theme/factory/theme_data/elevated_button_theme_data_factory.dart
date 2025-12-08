import 'package:flutter/material.dart';

import '../theme_style_factory.dart';

class ElevatedButtonThemeDataFactory implements ThemeStyleFactory<ElevatedButtonThemeData> {
  ElevatedButtonThemeDataFactory(this.colors);

  final ColorScheme colors;

  @override
  ElevatedButtonThemeData create() {
    return ElevatedButtonThemeData(style: ElevatedButton.styleFrom(shape: const StadiumBorder()));
  }
}
