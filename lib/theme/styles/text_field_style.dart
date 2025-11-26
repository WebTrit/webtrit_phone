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
    this.behavior,
  });

  final InputDecoration? decoration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final bool? showCursor;
  final TextInputType? keyboardType;
  final Color? cursorColor;
  final InputMaskStyle? mask;
  final InputBehavior? behavior;

  TextFieldStyle copyWith({
    InputDecoration? decoration,
    TextStyle? textStyle,
    TextAlign? textAlign,
    bool? showCursor,
    TextInputType? keyboardType,
    Color? cursorColor,
    InputMaskStyle? mask,
    InputBehavior? behavior,
  }) {
    return TextFieldStyle(
      decoration: decoration ?? this.decoration,
      textStyle: textStyle ?? this.textStyle,
      textAlign: textAlign ?? this.textAlign,
      showCursor: showCursor ?? this.showCursor,
      keyboardType: keyboardType ?? this.keyboardType,
      cursorColor: cursorColor ?? this.cursorColor,
      mask: mask ?? this.mask,
      behavior: behavior ?? this.behavior,
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
      behavior: b.behavior ?? a.behavior,
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
      behavior: InputBehavior.lerp(a?.behavior, b?.behavior, t),
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
      ..add(DiagnosticsProperty<InputBehavior?>('behavior', behavior));
  }
}

class InputBehavior {
  const InputBehavior({this.includePrefixInData});

  /// Whether prefixText is included in the raw data sent outside
  final bool? includePrefixInData;

  InputBehavior copyWith({bool? includePrefixInData, bool? normalizePhone, bool? trim, bool? emptyAsNull}) {
    return InputBehavior(includePrefixInData: includePrefixInData ?? this.includePrefixInData);
  }

  static InputBehavior? lerp(InputBehavior? a, InputBehavior? b, double t) {
    if (a == null && b == null) return null;
    if (t <= 0.0) return a ?? b;
    if (t >= 1.0) return b ?? a;
    return t < 0.5 ? (a ?? b) : (b ?? a);
  }
}
