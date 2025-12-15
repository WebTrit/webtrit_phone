import 'package:flutter/material.dart';

import 'package:webtrit_appearance_theme/models/models.dart';
import 'package:webtrit_phone/theme/extension/extension.dart';

/// Extension methods for [InputDecorationConfig] to facilitate conversion
/// to Flutter's [InputDecoration].
extension InputDecorationConfigExtension on InputDecorationConfig {
  /// Converts the configuration object into a material [InputDecoration].
  ///
  /// Requires a [ColorScheme] to resolve default colors and an optional
  /// [baseStyle] to be used as a foundation for text styles.
  InputDecoration toInputDecoration({required ColorScheme colors, TextStyle? baseStyle}) {
    // Map specific border configurations for different states
    final mappedBorder = _mapBorder(border, colors);
    final mappedEnabledBorder = _mapBorder(enabledBorder, colors);
    final mappedFocusedBorder = _mapBorder(focusedBorder, colors);
    final mappedErrorBorder = _mapBorder(errorBorder, colors);
    final mappedFocusedErrBorder = _mapBorder(focusedErrorBorder, colors);
    final mappedDisabledBorder = _mapBorder(disabledBorder, colors);

    // Check if the main border type is 'none' to apply it globally if needed
    final noneEverywhere = border?.type == 'none';

    // Derive default colors from the provided ColorScheme
    final onSurface = colors.onSurface;
    final onSurface50 = onSurface.withValues(alpha: 0.5);
    final onSurfaceVariant = colors.onSurfaceVariant;
    final errorColor = colors.error;

    // Define a smaller base style for helper and error text
    final smallBaseStyle = baseStyle?.copyWith(fontSize: 12.0, height: 1.2) ?? const TextStyle(fontSize: 12.0);

    // Resolve text styles ONLY if the configuration is provided.
    // If the config is null, pass null to InputDecoration so it uses
    // the default Flutter theme styles.

    final hintStyleResult = hintStyle != null
        ? _resolveStyle(hintStyle, baseStyle: baseStyle, color: onSurface50)
        : null;

    final prefixStyleResult = prefixStyle != null
        ? _resolveStyle(prefixStyle, baseStyle: baseStyle, color: onSurface)
        : null;

    final labelStyleResult = labelStyle != null
        ? _resolveStyle(labelStyle, baseStyle: baseStyle, color: onSurface)
        : null;

    final suffixStyleResult = suffixStyle != null
        ? _resolveStyle(suffixStyle, baseStyle: baseStyle, color: onSurface)
        : null;

    final helperStyleResult = helperStyle != null
        ? _resolveStyle(helperStyle, baseStyle: smallBaseStyle, color: onSurfaceVariant)
        : null;

    final errorStyleResult = errorStyle != null
        ? _resolveStyle(errorStyle, baseStyle: smallBaseStyle, color: errorColor)
        : null;

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
      // If 'filled' is not explicitly set, assume true if a fillColor exists
      filled: filled ?? fillColor != null,
      // Apply borders, handling the 'none' type logic
      border: noneEverywhere ? InputBorder.none : mappedBorder,
      enabledBorder: noneEverywhere ? InputBorder.none : (mappedEnabledBorder ?? mappedBorder),
      focusedBorder: noneEverywhere ? InputBorder.none : (mappedFocusedBorder ?? mappedBorder),
      errorBorder: noneEverywhere ? InputBorder.none : (mappedErrorBorder ?? mappedBorder),
      focusedErrorBorder: noneEverywhere ? InputBorder.none : (mappedFocusedErrBorder ?? mappedBorder),
      disabledBorder: noneEverywhere ? InputBorder.none : (mappedDisabledBorder ?? mappedBorder),
    );
  }

  /// Helper to merge a [TextStyleConfig] with a [baseStyle] and apply a specific [color].
  TextStyle _resolveStyle(TextStyleConfig? config, {TextStyle? baseStyle, Color? color}) {
    final base = baseStyle ?? const TextStyle();

    final custom = config?.toTextStyle();
    final mergedStyle = custom != null ? base.merge(custom) : base;

    return mergedStyle.copyWith(color: color);
  }

  /// Helper to map a [BorderConfig] to a Flutter [InputBorder].
  ///
  /// Supports 'outline', 'underline', and 'none'.
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
