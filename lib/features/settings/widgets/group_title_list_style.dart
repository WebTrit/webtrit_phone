import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GroutTitleListStyle with Diagnosticable {
  const GroutTitleListStyle({this.textStyle, this.background});

  final TextStyle? textStyle;
  final Color? background;

  static GroutTitleListStyle? merge(GroutTitleListStyle? a, GroutTitleListStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return GroutTitleListStyle(
      textStyle: a.textStyle?.merge(b.textStyle) ?? b.textStyle,
      background: b.background ?? a.background,
    );
  }

  static GroutTitleListStyle? lerp(GroutTitleListStyle? a, GroutTitleListStyle? b, double t) {
    if (a == null && b == null) return null;
    return GroutTitleListStyle(
      textStyle: TextStyle.lerp(a?.textStyle, b?.textStyle, t),
      background: Color.lerp(a?.background, b?.background, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle));
    properties.add(ColorProperty('background', background));
  }
}
