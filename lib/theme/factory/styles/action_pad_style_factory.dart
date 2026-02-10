import 'package:flutter/material.dart';

import 'package:logging/logging.dart';

import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

final _logger = Logger('ActionPadStyleFactory');

class ActionPadStyleFactory implements ThemeStyleFactory<ActionpadStyles> {
  ActionPadStyleFactory(this.colors, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final ActionPadWidgetConfig? config;
  final String? defaultFontFamily;

  @override
  ActionpadStyles create() {
    const defaultScale = 0.75;
    const callStartScale = 1.0;

    _logger.finePretty('Creating ActionPadStyles, config = $config, defaultFontFamily = $defaultFontFamily');

    final filledStyle = TextButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: colors.onSecondary,
      backgroundColor: colors.secondary,
      disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
      disabledIconColor: colors.onSurface.withValues(alpha: 0.38),
      disabledBackgroundColor: colors.onSurface.withValues(alpha: 0.12),
    );

    return ActionpadStyles(
      primary: ActionpadStyle(
        primary: _resolveStyle(source: config?.callStart, fallback: filledStyle, scale: callStartScale),
        secondary: _resolveStyle(source: config?.callTransfer, fallback: filledStyle, scale: defaultScale),
        backspace: _resolveStyle(source: config?.backspacePressed, fallback: filledStyle, scale: defaultScale),
      ),
    );
  }

  ScaleButtonStyle _resolveStyle({
    required ButtonStyle fallback,
    required double scale,
    ButtonStyleConfig? source,
    bool checkTransparency = true,
  }) {
    final sourceStyle = source?.toButtonStyle(defaultFontFamily: defaultFontFamily);

    // If no config provided, strictly use fallback
    if (sourceStyle == null) {
      final backgroundColor = fallback.backgroundColor?.resolve({});
      final isTransparent = checkTransparency && (backgroundColor == null || backgroundColor.a == 0);
      return ScaleButtonStyle(style: fallback, scale: isTransparent ? 1 : scale);
    }

    // Force override properties using copyWith to ensure config values take precedence
    final style = fallback.copyWith(
      backgroundColor: sourceStyle.backgroundColor,
      foregroundColor: sourceStyle.foregroundColor,
      iconColor: sourceStyle.iconColor,
      overlayColor: sourceStyle.overlayColor,
      shadowColor: sourceStyle.shadowColor,
      elevation: sourceStyle.elevation,
      side: sourceStyle.side,
      shape: sourceStyle.shape,
      textStyle: sourceStyle.textStyle,
    );

    final backgroundColor = style.backgroundColor?.resolve({});
    final isTransparent = checkTransparency && (backgroundColor == null || backgroundColor.a == 0);

    return ScaleButtonStyle(style: style, scale: isTransparent ? 1 : scale);
  }
}
