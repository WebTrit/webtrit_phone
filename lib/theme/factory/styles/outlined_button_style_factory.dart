import 'package:flutter/material.dart';

import '../../extension/extension.dart';
import '../theme_style_factory.dart';

class OutlinedButtonStyleFactory implements ThemeStyleFactory<OutlinedButtonStyles> {
  OutlinedButtonStyleFactory(this.colors);

  final ColorScheme colors;

  @override
  OutlinedButtonStyles create() {
    return OutlinedButtonStyles(
      neutral: OutlinedButton.styleFrom(
        foregroundColor: colors.onSurface,
        side: BorderSide(color: colors.onSurface.withValues(alpha: 0.2)),
      ),
    );
  }
}
