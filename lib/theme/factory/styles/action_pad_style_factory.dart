import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/features.dart';
import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class ActionPadStyleFactory implements ThemeStyleFactory<ActionpadStyles> {
  ActionPadStyleFactory(this.colors, this.config);

  final ColorScheme colors;
  final ActionPadWidgetConfig? config;

  @override
  ActionpadStyles create() {
    const disabledColorOpacity = 0.4;

    final defaultCallDisabledIconColor = colors.surface.withValues(alpha: disabledColorOpacity);

    final callStartForegroundColor = config?.callStart.foregroundColor?.toColor() ?? colors.onTertiary;
    final callStartBackgroundColor = config?.callStart.backgroundColor?.toColor() ?? colors.tertiary;
    final callStartIconColor = config?.callStart.iconColor?.toColor() ?? colors.surface;
    final callStartDisabledIconColor = config?.callStart.disabledIconColor?.toColor() ?? defaultCallDisabledIconColor;

    final callTransferForegroundColor = config?.callTransfer.foregroundColor?.toColor() ?? colors.onSecondary;
    final callTransferBackgroundColor = config?.callTransfer.backgroundColor?.toColor() ?? colors.secondary;
    final callTransferIconColor = config?.callTransfer.iconColor?.toColor() ?? colors.surface;
    final callTransferDisabledIconColor =
        config?.callTransfer.disabledIconColor?.toColor() ?? defaultCallDisabledIconColor;

    final backspacePressedStyleForegroundColor =
        config?.backspacePressed.foregroundColor?.toColor() ?? colors.onSecondary;
    final backspacePressedStyleBackgroundColor = config?.backspacePressed.backgroundColor?.toColor();
    final backspacePressedStyleIconColor = config?.backspacePressed.iconColor?.toColor() ?? colors.onSurface;
    final backspacePressedStyleDisabledIconColor =
        config?.backspacePressed.disabledIconColor?.toColor() ?? colors.surface;

    final callStartStyle = TextButton.styleFrom(
      foregroundColor: callStartForegroundColor,
      backgroundColor: callStartBackgroundColor,
      disabledForegroundColor: colors.onTertiary.withValues(alpha: disabledColorOpacity),
      iconColor: callStartIconColor,
      disabledIconColor: callStartDisabledIconColor,
      padding: EdgeInsets.zero,
    );

    final callTransferStyle = TextButton.styleFrom(
      foregroundColor: callTransferForegroundColor,
      backgroundColor: callTransferBackgroundColor,
      disabledForegroundColor: colors.secondary.withValues(alpha: disabledColorOpacity),
      iconColor: callTransferIconColor,
      disabledIconColor: callTransferDisabledIconColor,
      padding: EdgeInsets.zero,
    );

    final backspacePressedStyle = TextButton.styleFrom(
      foregroundColor: backspacePressedStyleForegroundColor,
      backgroundColor: backspacePressedStyleBackgroundColor,
      iconColor: backspacePressedStyleIconColor,
      disabledIconColor: backspacePressedStyleDisabledIconColor,
    );

    return ActionpadStyles(
      primary: ActionpadStyle(
        callStart: callStartStyle,
        callTransfer: callTransferStyle,
        backspacePressed: backspacePressedStyle,
      ),
    );
  }
}
