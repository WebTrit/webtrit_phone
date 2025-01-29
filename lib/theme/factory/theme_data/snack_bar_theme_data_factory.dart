import 'package:flutter/material.dart';

import '../theme_style_factory.dart';

class SnackBarThemeDataFactory implements ThemeStyleFactory<SnackBarThemeData> {
  SnackBarThemeDataFactory(this.colors);

  final ColorScheme colors;

  @override
  SnackBarThemeData create() {
    return SnackBarThemeData(
      actionTextColor: colors.surface,
    );
  }
}
