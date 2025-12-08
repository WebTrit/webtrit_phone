import 'package:flutter/material.dart';

import 'package:webtrit_phone/features/keypad/keypad.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/keypad_key_style.dart';

import '../theme_style_factory.dart';

/// Factory responsible for creating [KeypadStyles] based on theme colors,
/// text theme, and optional configuration overrides.
///
/// ### Note about font sizes:
/// At this point (during style factory creation), Flutter's [TextTheme]
/// may not have fully resolved font metrics (like `headlineLarge?.fontSize`)
/// because they are finalized only after the widget tree is built with
/// a proper [MediaQuery] and [DefaultTextStyle].
///
/// To avoid returning `null`, we fallback to **approximate Material defaults**:
/// - `headlineLarge`: ~32.0, weight 400
/// - `bodyMedium`: ~14.0, weight 400
///
/// This ensures predictable styles even outside of a widget build context.
///
/// TODO: Investigate a way to defer resolution or merge styles later
/// inside widgets (e.g. `merge(theme.textTheme.headlineLarge)`),
/// so that the final computed sizes are always respected.
class KeypadStyleFactory implements ThemeStyleFactory<KeypadStyles> {
  KeypadStyleFactory(this.colors, {required this.config, required this.textTheme});

  final ColorScheme colors;
  final KeypadStyleConfig? config;
  final TextTheme textTheme;

  @override
  KeypadStyles create() {
    // Number defaults (headlineLarge)
    final defaultNumberFontSize = textTheme.headlineLarge?.fontSize ?? 32.0;
    final defaultNumberFontWeight = textTheme.headlineLarge?.fontWeight ?? FontWeight.w400;
    final defaultNumberColor = textTheme.headlineLarge?.color ?? colors.onSurface;

    // Subtext defaults(bodyMedium)
    final defaultSubFontSize = textTheme.bodyMedium?.fontSize ?? 14.0;
    final defaultSubFontWeight = textTheme.bodyMedium?.fontWeight ?? FontWeight.w400;
    final defaultSubColor = (textTheme.bodyMedium?.color ?? colors.onSurface).withValues(alpha: 0.6);

    return KeypadStyles(
      primary: KeypadStyle(
        keyStyle: KeypadKeyStyle(
          textStyle:
              config?.textStyle?.toTextStyle(
                fallbackColor: defaultNumberColor,
                defaultFontSize: defaultNumberFontSize,
                defaultFontWeight: defaultNumberFontWeight,
              ) ??
              TextStyle(
                fontSize: defaultNumberFontSize,
                fontWeight: defaultNumberFontWeight,
                color: defaultNumberColor,
                height: 1.125,
              ),
          subtextStyle:
              config?.subtextStyle?.toTextStyle(
                fallbackColor: defaultSubColor,
                defaultFontSize: defaultSubFontSize,
                defaultFontWeight: defaultSubFontWeight,
              ) ??
              TextStyle(
                fontSize: defaultSubFontSize,
                fontWeight: defaultSubFontWeight,
                color: defaultSubColor,
                height: 1.428,
              ),
        ),
      ),
    );
  }
}
