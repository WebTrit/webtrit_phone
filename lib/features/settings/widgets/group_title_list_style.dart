import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GroupTitleListStyle with Diagnosticable {
  const GroupTitleListStyle({this.textStyle, this.background});

  final TextStyle? textStyle;
  final Color? background;

  static GroupTitleListStyle? merge(GroupTitleListStyle? a, GroupTitleListStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return GroupTitleListStyle(
      textStyle: a.textStyle?.merge(b.textStyle) ?? b.textStyle,
      background: b.background ?? a.background,
    );
  }

  static GroupTitleListStyle? lerp(GroupTitleListStyle? a, GroupTitleListStyle? b, double t) {
    if (a == null && b == null) return null;
    return GroupTitleListStyle(
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
