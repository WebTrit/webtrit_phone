// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'keypad_key_style.dart';
import 'keypad_key_styles.dart';

export 'keypad_key_style.dart';
export 'keypad_key_styles.dart';

class KeypadKeyButton extends StatefulWidget {
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

  /// Minimum alpha value applied when deriving subtext color.
  static const double _minAlphaValue = 0.2;

  /// Amount to reduce alpha from main text color for subtext.
  static const double _subtextAlphaReduction = 0.3;

  final String text;
  final String subtext;
  final void Function(String) onKeyPressed;

  final KeypadKeyStyle? style;

  @Deprecated('Use style.textStyle.fontSize instead')
  final double? textFontSize;

  @Deprecated('Use style.textStyle.color instead')
  final Color? textColor;

  @Deprecated('Use style.subtextStyle.fontSize instead')
  final double? subtextFontSize;

  @override
  State<KeypadKeyButton> createState() => _KeypadKeyButtonState();
}

class _KeypadKeyButtonState extends State<KeypadKeyButton> {
  DateTime? _pointerDownAt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themed = theme.extension<KeypadKeyStyles>()?.primary;

    final merged = KeypadKeyStyle.merge(themed, widget.style);

    final textStyle = (merged.textStyle ?? theme.textTheme.headlineLarge)?.copyWith(
      fontSize: widget.textFontSize ?? merged.textStyle?.fontSize,
      color: widget.textColor ?? merged.textStyle?.color,
      height: 1.0,
    );

    // Derive subtext color from text color with reduced opacity if not set.
    Color? derivedSubColor = textStyle?.color;
    if (derivedSubColor != null) {
      var a = derivedSubColor.a - KeypadKeyButton._subtextAlphaReduction;
      if (a < KeypadKeyButton._minAlphaValue) a = KeypadKeyButton._minAlphaValue;
      derivedSubColor = derivedSubColor.withValues(alpha: a);
    }

    final subStyle = (merged.subtextStyle ?? theme.textTheme.bodyMedium)?.copyWith(
      fontSize: widget.subtextFontSize ?? merged.subtextStyle?.fontSize,
      color: merged.subtextStyle?.color ?? derivedSubColor,
      height: 1.0,
    );

    final hasLongPress = widget.subtext.length == 1;

    // Custom tap recognition used to avoid input throttling on low-end devices (see WT-1436)
    // somehow TextButton's built-in onPressed not fired after pointer up while animation is present
    // maybe later will be fixed on Flutter side, but for now we use Listener to handle pointer events directly
    return Listener(
      key: Key(widget.text),
      onPointerDown: (_) {
        _pointerDownAt = DateTime.now();
        if (!hasLongPress) widget.onKeyPressed(widget.text);
      },
      onPointerUp: hasLongPress
          ? (_) {
              final downAt = _pointerDownAt;
              if (downAt == null) return;
              if (DateTime.now().difference(downAt) < kLongPressTimeout) {
                widget.onKeyPressed(widget.text);
              }
            }
          : null,
      child: TextButton(
        onPressed: () {},
        onLongPress: hasLongPress ? () => widget.onKeyPressed(widget.subtext) : null,
        style: merged.buttonStyle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.text, style: textStyle),
            Padding(
              padding: KeypadKeyButton._subextPadding,
              child: Text(widget.subtext, style: subStyle),
            ),
          ],
        ),
      ),
    );
  }
}
