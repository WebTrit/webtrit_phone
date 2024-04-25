import 'package:flutter/material.dart';

class GroutTitleListStyle {
  GroutTitleListStyle({
    this.textStyle,
    this.background,
  });

  final TextStyle? textStyle;
  final Color? background;

  static GroutTitleListStyle lerp(GroutTitleListStyle? a, GroutTitleListStyle? b, double t) {
    final newTextStyle = TextStyle.lerp(a?.textStyle, b?.textStyle, t);
    final newBackground = Color.lerp(a?.background, b?.background, t);
    return GroutTitleListStyle(
      textStyle: newTextStyle,
      background: newBackground,
    );
  }
}
