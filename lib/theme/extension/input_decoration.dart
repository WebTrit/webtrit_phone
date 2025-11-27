import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

extension InputDecorationConfigExtension on InputDecorationConfig {
  InputDecoration toInputDecoration({required ColorScheme colors, TextStyle? baseStyle}) {
    final mappedBorder = _mapBorder(border, colors);
    final mappedEnabledBorder = _mapBorder(enabledBorder, colors);
    final mappedFocusedBorder = _mapBorder(focusedBorder, colors);
    final mappedErrorBorder = _mapBorder(errorBorder, colors);
    final mappedFocusedErrBorder = _mapBorder(focusedErrorBorder, colors);
    final mappedDisabledBorder = _mapBorder(disabledBorder, colors);

    final noneEverywhere = border?.type == 'none';

    final onSurface = colors.onSurface;
    final onSurface50 = onSurface.withValues(alpha: 0.5);
    final onSurfaceVariant = colors.onSurfaceVariant;
    final errorColor = colors.error;

    final hintStyleResult = _resolveStyle(hintStyle, baseStyle: baseStyle, color: onSurface50);
    final prefixStyleResult = _resolveStyle(prefixStyle, baseStyle: baseStyle, color: onSurface);
    final labelStyleResult = _resolveStyle(labelStyle, baseStyle: baseStyle, color: onSurface);
    final helperStyleResult = _resolveStyle(helperStyle, baseStyle: baseStyle, color: onSurfaceVariant);
    final errorStyleResult = _resolveStyle(errorStyle, baseStyle: baseStyle, color: errorColor);
    final suffixStyleResult = _resolveStyle(suffixStyle, baseStyle: baseStyle, color: onSurface);

    return InputDecoration(
      hintText: hintText,
      hintStyle: hintStyleResult,
      labelText: labelText,
      labelStyle: labelStyleResult,
      helperText: helperText,
      helperStyle: helperStyleResult,
      errorStyle: errorStyleResult,
      prefixText: prefixText,
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

  TextStyle _resolveStyle(TextStyleConfig? config, {TextStyle? baseStyle, Color? color}) {
    final base = baseStyle ?? const TextStyle();

    final custom = config?.toTextStyle();
    final mergedStyle = custom != null ? base.merge(custom) : base;

    return mergedStyle.copyWith(color: color);
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
