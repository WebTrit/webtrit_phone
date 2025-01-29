import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

import '../theme_style_factory.dart';

class InputDecorationThemeDataFactory implements ThemeStyleFactory<InputDecorationTheme> {
  InputDecorationThemeDataFactory(this.colors, this.config);

  final ColorScheme colors;
  TextFormFieldWidgetConfig? config;

  @override
  InputDecorationTheme create() {
    final labelStyleColor = config?.labelColor?.toColor();
    final disabledErrorBorderColor = config?.border.disabled.errorColor?.toColor();
    final disabledPrimaryBorderColor = config?.border.disabled.typicalColor?.toColor();
    final focusedErrorBorderColor = config?.border.focused.errorColor?.toColor();
    final focusedPrimaryBorderColor = config?.border.focused.typicalColor?.toColor();
    final anyErrorBorderColor = config?.border.any.errorColor?.toColor();
    final anyPrimaryBorderColor = config?.border.any.typicalColor?.toColor();

    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      isDense: true,
      filled: true,
      // TODO: add fill color from widget settings model
      fillColor: colors.surfaceBright,
      labelStyle: TextStyle(color: labelStyleColor),
      border: MaterialStateOutlineInputBorder.resolveWith((states) {
        final bool isError = states.contains(WidgetState.error);
        final Color borderColor;

        if (states.contains(WidgetState.disabled)) {
          borderColor = isError
              ? disabledErrorBorderColor ?? colors.error.withAlpha(64)
              : disabledPrimaryBorderColor ?? colors.onSurface.withAlpha(64);
        } else if (states.contains(WidgetState.focused)) {
          borderColor = isError ? focusedErrorBorderColor ?? colors.error : focusedPrimaryBorderColor ?? colors.primary;
        } else {
          borderColor = isError
              ? anyErrorBorderColor ?? colors.error.withAlpha(128)
              : anyPrimaryBorderColor ?? colors.onSurface.withAlpha(128);
        }

        return OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        );
      }),
    );
  }
}
