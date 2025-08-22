import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KeypadKeyStyle with Diagnosticable {
  const KeypadKeyStyle({
    this.buttonStyle,
    this.textStyle,
    this.subtextStyle,
  });

  final ButtonStyle? buttonStyle;
  final TextStyle? textStyle;
  final TextStyle? subtextStyle;

  KeypadKeyStyle copyWith({
    ButtonStyle? buttonStyle,
    TextStyle? textStyle,
    TextStyle? subtextStyle,
  }) {
    return KeypadKeyStyle(
      buttonStyle: buttonStyle ?? this.buttonStyle,
      textStyle: textStyle ?? this.textStyle,
      subtextStyle: subtextStyle ?? this.subtextStyle,
    );
  }

  static KeypadKeyStyle merge(KeypadKeyStyle? a, KeypadKeyStyle? b) {
    if (a == null) return b ?? const KeypadKeyStyle();
    if (b == null) return a;
    return KeypadKeyStyle(
      buttonStyle: _mergeButtonStyles(a.buttonStyle, b.buttonStyle),
      textStyle: _mergeTextStyles(a.textStyle, b.textStyle),
      subtextStyle: _mergeTextStyles(a.subtextStyle, b.subtextStyle),
    );
  }

  static ButtonStyle? _mergeButtonStyles(ButtonStyle? a, ButtonStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.merge(b);
  }

  static TextStyle? _mergeTextStyles(TextStyle? a, TextStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.merge(b);
  }

  static KeypadKeyStyle lerp(KeypadKeyStyle? a, KeypadKeyStyle? b, double t) {
    return KeypadKeyStyle(
      buttonStyle: ButtonStyle.lerp(a?.buttonStyle, b?.buttonStyle, t),
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
      subtextStyle: TextStyle.lerp(a?.subtextStyle, b?.subtextStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ButtonStyle?>('buttonStyle', buttonStyle))
      ..add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle))
      ..add(DiagnosticsProperty<TextStyle?>('subtextStyle', subtextStyle));
  }
}
