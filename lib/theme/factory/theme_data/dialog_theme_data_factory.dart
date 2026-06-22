import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

/// Builds [ThemeData.dialogTheme] for every dialog (`showDialog`, `AlertDialog`,
/// `Dialog`).
///
/// Material 3 derives the dialog background from `colorScheme.surfaceContainerHigh`,
/// which can resolve to an unreadable color in a seeded scheme. To keep all dialogs
/// legible by default this factory pins the background to a readable surface role and
/// disables the surface tint overlay, while still allowing a theme to override every
/// value through [DialogThemeConfig].
class DialogThemeDataFactory implements ThemeStyleFactory<DialogThemeData> {
  const DialogThemeDataFactory(this.colors, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final DialogThemeConfig config;
  final String? defaultFontFamily;

  @override
  DialogThemeData create() {
    final borderRadius = config.borderRadius;

    return DialogThemeData(
      backgroundColor: config.backgroundColor?.toColor() ?? colors.surface,
      surfaceTintColor: config.surfaceTintColor?.toColor() ?? Colors.transparent,
      shadowColor: config.shadowColor?.toColor(),
      barrierColor: config.barrierColor?.toColor(),
      elevation: config.elevation,
      shape: borderRadius != null ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)) : null,
      titleTextStyle: config.titleTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
      contentTextStyle: config.contentTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
    );
  }
}
