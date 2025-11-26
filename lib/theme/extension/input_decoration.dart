import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

extension InputDecorationConfigExtension on InputDecorationConfig {
  InputDecoration toInputDecoration({required ColorScheme colors}) {
    final mappedBorder = _mapBorder(border, colors);
    final mappedEnabledBorder = _mapBorder(enabledBorder, colors);
    final mappedFocusedBorder = _mapBorder(focusedBorder, colors);
    final mappedErrorBorder = _mapBorder(errorBorder, colors);
    final mappedFocusedErrBorder = _mapBorder(focusedErrorBorder, colors);
    final mappedDisabledBorder = _mapBorder(disabledBorder, colors);

    final noneEverywhere = border?.type == 'none';

    final hintStyleResult = _resolveStyle(hintStyle, color: colors.onSurface.withValues(alpha: 0.5));
    final prefixStyleResult = _resolveStyle(prefixStyle, color: colors.onSurface);
    final labelStyleResult = _resolveStyle(labelStyle, color: colors.onSurface);
    final helperStyleResult = _resolveStyle(helperStyle, color: colors.onSurfaceVariant);
    final errorStyleResult = _resolveStyle(errorStyle, color: colors.error);
    final suffixStyleResult = _resolveStyle(suffixStyle, color: colors.onSurface);

    return InputDecoration(
      hintText: hintText,
      // Fallback to grey-ish color (medium emphasis)
      hintStyle: hintStyleResult,
      labelText: labelText,
      labelStyle: labelStyleResult,
      helperText: helperText,
      helperStyle: helperStyleResult,
      errorStyle: errorStyleResult,
      prefixText: prefixText,
      // Fallback to solid main color (high emphasis)
      prefixStyle: prefixStyleResult,
      suffixText: suffixText,
      suffixStyle: suffixStyleResult,
      fillColor: fillColor?.toColor(),
      filled: filled ?? fillColor != null,
      border: noneEverywhere ? InputBorder.none : mappedBorder,
      enabledBorder: noneEverywhere ? InputBorder.none : (mappedEnabledBorder ?? mappedBorder),
      focusedBorder: noneEverywhere ? InputBorder.none : (mappedFocusedBorder ?? mappedBorder),
      errorBorder: noneEverywhere ? InputBorder.none : (mappedErrorBorder ?? mappedBorder),
      focusedErrorBorder: noneEverywhere ? InputBorder.none : (mappedFocusedErrBorder ?? mappedBorder),
      disabledBorder: noneEverywhere ? InputBorder.none : (mappedDisabledBorder ?? mappedBorder),
    );
  }

  TextStyle _resolveStyle(
    TextStyleConfig? config, {
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) => (config?.toTextStyle() ?? const TextStyle()).copyWith(
    color: color,
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
  );

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
