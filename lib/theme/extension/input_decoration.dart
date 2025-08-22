import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

extension InputDecorationConfigExtension on InputDecorationConfig {
  InputDecoration toInputDecoration({
    required ColorScheme colors,
  }) {
    final mappedBorder = _mapBorder(border, colors);
    final mappedEnabledBorder = _mapBorder(enabledBorder, colors);
    final mappedFocusedBorder = _mapBorder(focusedBorder, colors);
    final mappedErrorBorder = _mapBorder(errorBorder, colors);
    final mappedFocusedErrBorder = _mapBorder(focusedErrorBorder, colors);
    final mappedDisabledBorder = _mapBorder(disabledBorder, colors);

    final noneEverywhere = border?.type == 'none';

    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyle?.toTextStyle(
        fallbackColor: colors.onSurface.withValues(alpha: 0.5),
      ),
      labelText: labelText,
      labelStyle: labelStyle?.toTextStyle(fallbackColor: colors.onSurface),
      helperText: helperText,
      helperStyle: helperStyle?.toTextStyle(fallbackColor: colors.onSurfaceVariant),
      errorStyle: errorStyle?.toTextStyle(fallbackColor: colors.error),
      prefixText: prefixText,
      prefixStyle: prefixStyle?.toTextStyle(fallbackColor: colors.onSurface),
      suffixText: suffixText,
      suffixStyle: suffixStyle?.toTextStyle(fallbackColor: colors.onSurface),
      fillColor: fillColor?.toColor(),
      filled: filled ?? fillColor != null,
      border: noneEverywhere ? InputBorder.none : (mappedBorder ?? InputBorder.none),
      enabledBorder: noneEverywhere ? InputBorder.none : (mappedEnabledBorder ?? mappedBorder),
      focusedBorder: noneEverywhere ? InputBorder.none : (mappedFocusedBorder ?? mappedBorder),
      errorBorder: noneEverywhere ? InputBorder.none : (mappedErrorBorder ?? mappedBorder),
      focusedErrorBorder: noneEverywhere ? InputBorder.none : (mappedFocusedErrBorder ?? mappedBorder),
      disabledBorder: noneEverywhere ? InputBorder.none : (mappedDisabledBorder ?? mappedBorder),
    );
  }

  InputBorder? _mapBorder(BorderConfig? config, ColorScheme colors) {
    if (config == null) return null;

    if (config.type == 'none') {
      return InputBorder.none;
    }

    final color = config.borderColor?.toColor() ?? colors.outline;
    final width = config.borderWidth ?? 1.0;

    switch (config.type) {
      case 'outline':
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(config.borderRadius ?? 4.0),
          borderSide: BorderSide(color: color, width: width),
        );
      case 'underline':
      default:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: color, width: width),
        );
    }
  }
}
