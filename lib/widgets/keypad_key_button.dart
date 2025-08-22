// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';

import 'keypad_key_style.dart';
import 'keypad_key_styles.dart';

export 'keypad_key_style.dart';
export 'keypad_key_styles.dart';

class KeypadKeyButton extends StatelessWidget {
  const KeypadKeyButton({
    super.key,
    required this.text,
    required this.subtext,
    required this.onKeyPressed,
    this.style,
    @Deprecated('Use style.textStyle instead') this.textFontSize,
    @Deprecated('Use style.textStyle instead') this.textColor,
    @Deprecated('Use style.subtextStyle instead') this.subtextFontSize,
  });

  static const _subextPadding = EdgeInsets.symmetric(horizontal: 8);

  final String text;
  final String subtext;
  final void Function(String) onKeyPressed;

  /// New consolidated style (preferred).
  final KeypadKeyStyle? style;

  //  Legacy overrides (kept for compatibility) ====
  @Deprecated('Use style.textStyle.fontSize instead')
  final double? textFontSize;

  @Deprecated('Use style.textStyle.color instead')
  final Color? textColor;

  @Deprecated('Use style.subtextStyle.fontSize instead')
  final double? subtextFontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themed = theme.extension<KeypadKeyStyles>()?.primary;

    // Merge: widget.style overrides theme.extension
    final merged = KeypadKeyStyle.merge(themed, style);

    // Legacy fallbacks applied on top (if provided).
    final textStyle = (merged.textStyle ?? theme.textTheme.headlineLarge)?.copyWith(
      fontSize: textFontSize ?? merged.textStyle?.fontSize,
      color: textColor ?? merged.textStyle?.color,
      height: 1.0,
    );

    // Derive subtext color from text color with reduced opacity if not set.
    Color? derivedSubColor = textStyle?.color;
    if (derivedSubColor != null) {
      var a = derivedSubColor.a - 0.3;
      if (a < 0.2) a = 0.2;
      derivedSubColor = derivedSubColor.withValues(alpha: a);
    }

    final subStyle = (merged.subtextStyle ?? theme.textTheme.bodyMedium)?.copyWith(
      fontSize: subtextFontSize ?? merged.subtextStyle?.fontSize,
      color: merged.subtextStyle?.color ?? derivedSubColor,
      height: 1.0,
    );

    return TextButton(
      onPressed: () => onKeyPressed(text),
      onLongPress: subtext.length != 1 ? null : () => onKeyPressed(subtext),
      style: merged.buttonStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: textStyle),
          Padding(
            padding: _subextPadding,
            child: Text(subtext, style: subStyle),
          ),
        ],
      ),
    );
  }
}
