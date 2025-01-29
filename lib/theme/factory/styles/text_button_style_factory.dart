import 'package:flutter/material.dart';

import '../../extension/extension.dart';
import '../theme_style_factory.dart';

class TextButtonStyleFactory implements ThemeStyleFactory<TextButtonStyles> {
  TextButtonStyleFactory(this.colors);

  final ColorScheme colors;

  @override
  TextButtonStyles create() {
    return TextButtonStyles(
      neutral: TextButton.styleFrom(
        foregroundColor: colors.secondary,
      ),
      dangerous: TextButton.styleFrom(
        foregroundColor: colors.error,
      ),
      callStart: TextButton.styleFrom(
        foregroundColor: colors.onTertiary,
        backgroundColor: colors.tertiary,
        disabledForegroundColor: colors.onTertiary.withValues(alpha: 0.38),
        padding: EdgeInsets.zero,
      ),
      callHangup: TextButton.styleFrom(
        foregroundColor: colors.onError,
        backgroundColor: colors.error,
        disabledForegroundColor: colors.onError.withValues(alpha: 0.38),
        padding: EdgeInsets.zero,
      ),
      callTransfer: TextButton.styleFrom(
        foregroundColor: colors.onSecondary,
        backgroundColor: colors.secondary,
        disabledForegroundColor: colors.secondary.withValues(alpha: 0.38),
        padding: EdgeInsets.zero,
      ),
      callAction: TextButton.styleFrom(
        foregroundColor: colors.surface,
        backgroundColor: colors.surface.withValues(alpha: 0.3),
        padding: EdgeInsets.zero,
      ),
      callActiveAction: TextButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
