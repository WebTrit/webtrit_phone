import 'package:flutter/material.dart';

import '../../extension/extension.dart';
import '../theme_style_factory.dart';

class TextButtonStyleFactory implements ThemeStyleFactory<TextButtonStyles> {
  TextButtonStyleFactory(this.colors);

  final ColorScheme colors;

  @override
  TextButtonStyles create() {
    return TextButtonStyles(
      neutral: TextButton.styleFrom(foregroundColor: colors.secondary),
      dangerous: TextButton.styleFrom(foregroundColor: colors.error),
    );
  }
}
