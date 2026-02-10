import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class ActionPadStyleFactory implements ThemeStyleFactory<ActionpadStyles> {
  ActionPadStyleFactory(this.colors, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final ActionPadWidgetConfig? config;
  final String? defaultFontFamily;

  @override
  ActionpadStyles create() {
    const defaultScale = 0.75;
    const callStartScale = 1.0;

    final filledStyle = TextButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: colors.onSecondary,
      backgroundColor: colors.secondary,
      iconColor: colors.surface,
      disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
      disabledIconColor: colors.onSurface.withValues(alpha: 0.38),
      disabledBackgroundColor: colors.onSurface.withValues(alpha: 0.12),
    );

    final backspaceStyle = TextButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: colors.onSurface,
      backgroundColor: Colors.transparent,
      iconColor: colors.surface,
      disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
      disabledIconColor: colors.onSurface.withValues(alpha: 0.38),
    );

    return ActionpadStyles(
      primary: ActionpadStyle(
        primary: _resolveStyle(source: config?.callStart, fallback: filledStyle, scale: callStartScale),
        secondary: _resolveStyle(source: config?.callTransfer, fallback: filledStyle, scale: defaultScale),
        backspace: _resolveStyle(source: config?.backspacePressed, fallback: backspaceStyle, scale: defaultScale),
      ),
    );
  }

  ScaleButtonStyle _resolveStyle({
    required ButtonStyle fallback,
    required double scale,
    ButtonStyleConfig? source,
    bool checkTransparency = true,
  }) {
    final style = source?.toButtonStyle(defaultFontFamily: defaultFontFamily).merge(fallback) ?? fallback;

    final backgroundColor = style.backgroundColor?.resolve({});
    final isTransparent = checkTransparency && (backgroundColor == null || backgroundColor.a == 0);

    return ScaleButtonStyle(style: style, scale: isTransparent ? 1 : scale);
  }
}
