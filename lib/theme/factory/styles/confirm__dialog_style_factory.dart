import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_widget_config.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/widgets/confirm_dialog.dart';

import '../theme_style_factory.dart';

class ConfirmDialogStyleFactory implements ThemeStyleFactory<ConfirmDialogStyles> {
  ConfirmDialogStyleFactory(this.colors, this.styles, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final TextButtonStyles styles;
  final ConfirmDialogWidgetConfig? config;
  final String? defaultFontFamily;

  @override
  ConfirmDialogStyles create() {
    final activeButtonStyle1ForegroundColor = WidgetStatePropertyAll(config?.activeButtonColor1?.toColor());
    final activeButtonStyle2ForegroundColor = WidgetStatePropertyAll(config?.activeButtonColor2?.toColor());
    final defaultButtonStyleForegroundColor = WidgetStatePropertyAll(config?.defaultButtonColor?.toColor());

    final activeButtonStyle1 = styles.neutral?.copyWith(foregroundColor: activeButtonStyle1ForegroundColor);
    final activeButtonStyle2 = styles.dangerous?.copyWith(foregroundColor: activeButtonStyle2ForegroundColor);
    final defaultButtonStyle = const ButtonStyle().copyWith(foregroundColor: defaultButtonStyleForegroundColor);

    // Confirm-specific overrides stay null when unset so the dialog inherits
    // [ThemeData.dialogTheme] instead of forcing a value.
    final borderRadius = config?.borderRadius;
    final shape = borderRadius != null
        ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))
        : null;

    return ConfirmDialogStyles(
      primary: ConfirmDialogStyle(
        activeButtonStyle1: activeButtonStyle1,
        activeButtonStyle2: activeButtonStyle2,
        defaultButtonStyle: defaultButtonStyle,
        backgroundColor: config?.backgroundColor?.toColor(),
        surfaceTintColor: config?.surfaceTintColor?.toColor(),
        elevation: config?.elevation,
        shape: shape,
        titleTextStyle: config?.titleTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
        contentTextStyle: config?.contentTextStyle?.toTextStyle(defaultFontFamily: defaultFontFamily),
      ),
    );
  }
}
