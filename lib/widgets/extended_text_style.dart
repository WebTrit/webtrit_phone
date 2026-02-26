import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ExtendedTextDecoration {
  const ExtendedTextDecoration({required this.color, this.borderRadius, this.padding});

  final Color color;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;

  ExtendedTextDecoration copyWith({Color? color, BorderRadius? borderRadius, EdgeInsets? padding}) {
    return ExtendedTextDecoration(
      color: color ?? this.color,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  static ExtendedTextDecoration? lerp(ExtendedTextDecoration? a, ExtendedTextDecoration? b, double t) {
    if (a == null && b == null) return null;
    if (a == null) return b;
    if (b == null) return a;
    return ExtendedTextDecoration(
      color: Color.lerp(a.color, b.color, t)!,
      borderRadius: BorderRadius.lerp(a.borderRadius, b.borderRadius, t),
      padding: EdgeInsets.lerp(a.padding, b.padding, t),
    );
  }
}

class ExtendedTextStyle with Diagnosticable {
  const ExtendedTextStyle({this.textStyle, this.decoration});

  final TextStyle? textStyle;
  final ExtendedTextDecoration? decoration;

  ExtendedTextStyle copyWith({TextStyle? textStyle, ExtendedTextDecoration? decoration}) {
    return ExtendedTextStyle(textStyle: textStyle ?? this.textStyle, decoration: decoration ?? this.decoration);
  }

  static ExtendedTextStyle merge(ExtendedTextStyle? a, ExtendedTextStyle? b) {
    if (a == null) return b ?? const ExtendedTextStyle();
    if (b == null) return a;
    return ExtendedTextStyle(textStyle: b.textStyle ?? a.textStyle, decoration: b.decoration ?? a.decoration);
  }

  static ExtendedTextStyle lerp(ExtendedTextStyle? a, ExtendedTextStyle? b, double t) {
    return ExtendedTextStyle(
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
      decoration: ExtendedTextDecoration.lerp(a?.decoration, b?.decoration, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle));
    properties.add(DiagnosticsProperty<ExtendedTextDecoration?>('decoration', decoration));
  }
}
