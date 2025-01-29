import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class TextSelectionThemeDataFactory implements ThemeStyleFactory<TextSelectionThemeData> {
  TextSelectionThemeDataFactory(this.colors, this.config);

  final ColorScheme colors;
  TextSelectionWidgetConfig? config;

  @override
  TextSelectionThemeData create() {
    final cursorColor = config?.cursorColor?.toColor();
    final selectionColor = config?.selectionColor?.toColor();
    final selectionHandleColor = config?.selectionHandleColor?.toColor();

    return TextSelectionThemeData(
      cursorColor: cursorColor,
      selectionColor: selectionColor,
      selectionHandleColor: selectionHandleColor,
    );
  }
}
