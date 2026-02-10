import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';

import '../../models/models.dart';
import '../theme_style_factory.dart';

class ElevatedButtonStyleFactory implements ThemeStyleFactory<ElevatedButtonStyles> {
  ElevatedButtonStyleFactory(this.colors, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final ButtonStyleConfig? config;
  final String? defaultFontFamily;

  @override
  ElevatedButtonStyles create() {
    return ElevatedButtonStyles(
      primary:
          ElevatedButton.styleFrom(
                foregroundColor: colors.onPrimary,
                backgroundColor: colors.primary,
                disabledForegroundColor: colors.onPrimaryContainer.withValues(alpha: 0.38),
                disabledBackgroundColor: colors.onPrimaryContainer.withValues(alpha: 0.12),
              )
              .copyWith(elevation: WidgetStateProperty.all(0.0))
              .merge(config?.toButtonStyle(defaultFontFamily: defaultFontFamily)),
      neutral: ElevatedButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
      ).copyWith(elevation: WidgetStateProperty.all(0.0)),
      primaryOnDark: ElevatedButton.styleFrom(
        foregroundColor: colors.onPrimary,
        backgroundColor: colors.primary,
        disabledForegroundColor: colors.onPrimary.withValues(alpha: 0.5),
        disabledBackgroundColor: colors.primary.withValues(alpha: 0.5),
      ).copyWith(elevation: WidgetStateProperty.all(0.0)),
      neutralOnDark: ElevatedButton.styleFrom(
        foregroundColor: colors.onSurface,
        backgroundColor: colors.surface,
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.5),
        disabledBackgroundColor: colors.surface.withValues(alpha: 0.5),
      ).copyWith(elevation: WidgetStateProperty.all(0.0)),
    );
  }
}
