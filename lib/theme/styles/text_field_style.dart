import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'input_mask_style.dart';

class TextFieldStyle with Diagnosticable {
  const TextFieldStyle({
    this.decoration,
    this.textStyle,
    this.textAlign,
    this.showCursor,
    this.keyboardType,
    this.cursorColor,
    this.mask,
    this.inputValue,
  });

  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final bool? showCursor;
  final TextInputType? keyboardType;
  final Color? cursorColor;
  final InputMaskStyle? mask;
  final InputValue? inputValue;

  TextFieldStyle copyWith({
    InputDecoration? decoration,
    TextStyle? textStyle,
    TextAlign? textAlign,
    bool? showCursor,
    TextInputType? keyboardType,
    Color? cursorColor,
    InputMaskStyle? mask,
    InputValue? inputValue,
  }) {
    return TextFieldStyle(
      decoration: decoration ?? this.decoration,
      textStyle: textStyle ?? this.textStyle,
      textAlign: textAlign ?? this.textAlign,
      showCursor: showCursor ?? this.showCursor,
      keyboardType: keyboardType ?? this.keyboardType,
      cursorColor: cursorColor ?? this.cursorColor,
      mask: mask ?? this.mask,
      inputValue: inputValue ?? this.inputValue,
    );
  }

  static TextFieldStyle merge(TextFieldStyle? a, TextFieldStyle? b) {
    if (a == null) return b ?? const TextFieldStyle();
    if (b == null) return a;
    return TextFieldStyle(
      decoration: a.decoration?.applyDefaults(const InputDecorationTheme()) ?? b.decoration ?? a.decoration,
      textStyle: b.textStyle ?? a.textStyle,
      textAlign: b.textAlign ?? a.textAlign,
      showCursor: b.showCursor ?? a.showCursor,
      keyboardType: b.keyboardType ?? a.keyboardType,
      cursorColor: b.cursorColor ?? a.cursorColor,
      mask: b.mask ?? a.mask,
      inputValue: b.inputValue ?? a.inputValue,
    );
  }

  static TextFieldStyle lerp(TextFieldStyle? a, TextFieldStyle? b, double t) {
    final decoration = t < 0.5 ? a?.decoration : b?.decoration;

    return TextFieldStyle(
      decoration: decoration,
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
      textAlign: t < 0.5 ? a?.textAlign : b?.textAlign,
      showCursor: t < 0.5 ? a?.showCursor : b?.showCursor,
      keyboardType: t < 0.5 ? a?.keyboardType : b?.keyboardType,
      cursorColor: Color.lerp(a?.cursorColor, b?.cursorColor, t),
      mask: InputMaskStyle.lerp(a?.mask, b?.mask, t),
      inputValue: InputValue.lerp(a?.inputValue, b?.inputValue, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<InputDecoration?>('decoration', decoration))
      ..add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle))
      ..add(EnumProperty<TextAlign?>('textAlign', textAlign))
      ..add(FlagProperty('showCursor', value: showCursor, ifTrue: 'true', ifFalse: 'false'))
      ..add(DiagnosticsProperty<TextInputType?>('keyboardType', keyboardType))
      ..add(ColorProperty('cursorColor', cursorColor))
      ..add(DiagnosticsProperty<InputMaskStyle?>('mask', mask))
      ..add(DiagnosticsProperty<InputValue?>('inputValue', inputValue));
  }
}

class InputValue {
  const InputValue({this.includePrefixInData, this.initialValue});

  /// Whether prefixText is included in the raw data sent outside.
  ///
  /// * `true`: Emitted value = `prefixText` + `userInput`.
  /// * `false` (default): Emitted value = `userInput`.
  final bool? includePrefixInData;

  /// The text value to pre-fill in the input field upon initialization.
  ///
  /// * Use this for **initial state** only (e.g. data from backend).
  /// * This is NOT a placeholder/hint; it is mutable text the user can edit.
  final String? initialValue;

  /// Linearly interpolates between two [InputValue]s.
  ///
  /// Since these are discrete configuration values (booleans, strings),
  /// this method swaps between [a] and [b] at `t = 0.5`.
  static InputValue? lerp(InputValue? a, InputValue? b, double t) {
    if (a == null && b == null) return null;
    if (t <= 0.0) return a ?? b;
    if (t >= 1.0) return b ?? a;

    // Discrete interpolation: switch at 50%
    return t < 0.5 ? (a ?? b) : (b ?? a);
  }
}
