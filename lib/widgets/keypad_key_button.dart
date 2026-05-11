// ignore_for_file: deprecated_member_use_from_same_package

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
  static const _subextPadding = EdgeInsets.symmetric(horizontal: 8);
  static const double _minAlphaValue = 0.2;
  static const double _subtextAlphaReduction = 0.3;

  TextStyle? _textStyle;
  TextStyle? _subStyle;
  ButtonStyle? _buttonStyle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateStyles();
  }

  @override
  void didUpdateWidget(KeypadKeyButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style != widget.style ||
        oldWidget.textFontSize != widget.textFontSize ||
        oldWidget.textColor != widget.textColor ||
        oldWidget.subtextFontSize != widget.subtextFontSize) {
      _updateStyles();
    }
  }

  void _updateStyles() {
    final theme = Theme.of(context);
    final merged = KeypadKeyStyle.merge(theme.extension<KeypadKeyStyles>()?.primary, widget.style);

    final textStyle = (merged.textStyle ?? theme.textTheme.headlineLarge)?.copyWith(
      fontSize: widget.textFontSize ?? merged.textStyle?.fontSize,
      color: widget.textColor ?? merged.textStyle?.color,
      height: 1.0,
    );

    Color? derivedSubColor = textStyle?.color;
    if (derivedSubColor != null) {
      final a = (derivedSubColor.a - _subtextAlphaReduction).clamp(_minAlphaValue, 1.0);
      derivedSubColor = derivedSubColor.withValues(alpha: a);
    }

    _textStyle = textStyle;
    _subStyle = (merged.subtextStyle ?? theme.textTheme.bodyMedium)?.copyWith(
      fontSize: widget.subtextFontSize ?? merged.subtextStyle?.fontSize,
      color: merged.subtextStyle?.color ?? derivedSubColor,
      height: 1.0,
    );
    _buttonStyle = merged.buttonStyle;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => widget.onKeyPressed(widget.text),
      onLongPress: widget.subtext.length != 1 ? null : () => widget.onKeyPressed(widget.subtext),
      style: _buttonStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.text, style: _textStyle),
          Padding(
            padding: _subextPadding,
            child: Text(widget.subtext, style: _subStyle),
          ),
        ],
      ),
    );
  }
}
