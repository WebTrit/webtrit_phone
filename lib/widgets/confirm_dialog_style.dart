import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConfirmDialogStyle with Diagnosticable {
  ConfirmDialogStyle({
    this.activeButtonStyle1,
    this.activeButtonStyle2,
    this.defaultButtonStyle,
  });

  final ButtonStyle? activeButtonStyle1;
  final ButtonStyle? activeButtonStyle2;
  final ButtonStyle? defaultButtonStyle;

  static ConfirmDialogStyle merge(ConfirmDialogStyle? a, ConfirmDialogStyle? b) {
    return ConfirmDialogStyle(
      activeButtonStyle1: _mergeButtonStyles(a?.activeButtonStyle1, b?.activeButtonStyle1),
      activeButtonStyle2: _mergeButtonStyles(a?.activeButtonStyle2, b?.activeButtonStyle2),
      defaultButtonStyle: _mergeButtonStyles(a?.defaultButtonStyle, b?.defaultButtonStyle),
    );
  }

  static ButtonStyle? _mergeButtonStyles(ButtonStyle? a, ButtonStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.merge(b);
  }

  static ConfirmDialogStyle lerp(ConfirmDialogStyle? a, ConfirmDialogStyle? b, double t) {
    return ConfirmDialogStyle(
      activeButtonStyle1: ButtonStyle.lerp(a?.activeButtonStyle1, b?.activeButtonStyle1, t),
      activeButtonStyle2: ButtonStyle.lerp(a?.activeButtonStyle2, b?.activeButtonStyle2, t),
      defaultButtonStyle: ButtonStyle.lerp(a?.defaultButtonStyle, b?.defaultButtonStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ButtonStyle?>('activeButtonStyle1', activeButtonStyle1));
    properties.add(DiagnosticsProperty<ButtonStyle?>('activeButtonStyle2', activeButtonStyle2));
    properties.add(DiagnosticsProperty<ButtonStyle?>('defaultButtonStyle', defaultButtonStyle));
  }
}
