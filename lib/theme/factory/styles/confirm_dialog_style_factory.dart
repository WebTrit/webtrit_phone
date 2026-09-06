import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/theme_widget_config.dart';

import 'package:webtrit_phone/theme/extension/extension.dart';
import 'package:webtrit_phone/widgets/confirm_dialog.dart';

import '../theme_style_factory.dart';

class ConfirmDialogStyleFactory implements ThemeStyleFactory<ConfirmDialogStyles> {
  ConfirmDialogStyleFactory(this.colors, this.config, this.defaultFontFamily);

  final ColorScheme colors;
  final ConfirmDialogWidgetConfig? config;
  final String? defaultFontFamily;

  @override
  ConfirmDialogStyles create() {
    // A colour the theme does not name must not be written down, because an
    // unset one arrives as a property that exists and resolves to null - and a
    // property that says nothing still wins the `copyWith`. Both buttons used
    // to take one that way, so the confirming action and the destructive one
    // fell through to the same `TextButton` default and read alike.
    ButtonStyle withColour(ButtonStyle base, String? hex) {
      final color = hex?.toColor();
      return color == null ? base : base.copyWith(foregroundColor: WidgetStatePropertyAll(color));
    }

    // The two looks the dialog is built from: one for the action it confirms,
    // one for the action that cannot be undone.
    final activeButtonStyle1 = withColour(
      TextButton.styleFrom(foregroundColor: colors.secondary),
      config?.activeButtonColor1,
    );
    final activeButtonStyle2 = withColour(
      TextButton.styleFrom(foregroundColor: colors.error),
      config?.activeButtonColor2,
    );
    final defaultButtonStyle = withColour(const ButtonStyle(), config?.defaultButtonColor);

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
