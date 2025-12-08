import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GroutTitleListStyle with Diagnosticable {
  GroutTitleListStyle({this.textStyle, this.background});

  final TextStyle? textStyle;
  final Color? background;

  static GroutTitleListStyle lerp(GroutTitleListStyle? a, GroutTitleListStyle? b, double t) {
    final newTextStyle = TextStyle.lerp(a?.textStyle, b?.textStyle, t);
    final newBackground = Color.lerp(a?.background, b?.background, t);
    return GroutTitleListStyle(textStyle: newTextStyle, background: newBackground);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextStyle?>('textStyle', textStyle));
    properties.add(DiagnosticsProperty<Color?>('background', background));
  }
}
