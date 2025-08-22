import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextButtonsTableStyle with Diagnosticable {
  const TextButtonsTableStyle({
    this.buttonStyle,
    this.minimumSize,
    this.spacing,
  });

  final ButtonStyle? buttonStyle;

  final Size? minimumSize;

  final EdgeInsetsGeometry? spacing;

  TextButtonsTableStyle copyWith({
    ButtonStyle? buttonStyle,
    Size? minimumSize,
    EdgeInsetsGeometry? spacing,
  }) {
    return TextButtonsTableStyle(
      buttonStyle: buttonStyle ?? this.buttonStyle,
      minimumSize: minimumSize ?? this.minimumSize,
      spacing: spacing ?? this.spacing,
    );
  }

  static TextButtonsTableStyle merge(TextButtonsTableStyle? a, TextButtonsTableStyle? b) {
    if (a == null) return b ?? const TextButtonsTableStyle();
    if (b == null) return a;
    return TextButtonsTableStyle(
      buttonStyle: _mergeButtonStyles(a.buttonStyle, b.buttonStyle),
      minimumSize: b.minimumSize ?? a.minimumSize,
      spacing: b.spacing ?? a.spacing,
    );
  }

  static ButtonStyle? _mergeButtonStyles(ButtonStyle? a, ButtonStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.merge(b);
  }

  static TextButtonsTableStyle lerp(TextButtonsTableStyle? a, TextButtonsTableStyle? b, double t) {
    return TextButtonsTableStyle(
      buttonStyle: ButtonStyle.lerp(a?.buttonStyle, b?.buttonStyle, t),
      minimumSize: t < 0.5 ? a?.minimumSize : b?.minimumSize,
      spacing: t < 0.5 ? a?.spacing : b?.spacing,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ButtonStyle?>('buttonStyle', buttonStyle))
      ..add(DiagnosticsProperty<Size?>('minimumSize', minimumSize))
      ..add(DiagnosticsProperty<EdgeInsetsGeometry?>('spacing', spacing));
  }
}
