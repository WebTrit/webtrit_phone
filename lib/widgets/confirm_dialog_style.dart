import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConfirmDialogStyle with Diagnosticable {
  ConfirmDialogStyle({
    this.activeButtonStyle1,
    this.activeButtonStyle2,
    this.defaultButtonStyle,
    this.backgroundColor,
    this.surfaceTintColor,
    this.elevation,
    this.shape,
    this.titleTextStyle,
    this.contentTextStyle,
  });

  final ButtonStyle? activeButtonStyle1;
  final ButtonStyle? activeButtonStyle2;
  final ButtonStyle? defaultButtonStyle;

  /// Per-confirm-dialog overrides layered on top of [ThemeData.dialogTheme].
  /// A null value leaves the corresponding [AlertDialog] property unset so it
  /// inherits the global dialog theme.
  final Color? backgroundColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final ShapeBorder? shape;
  final TextStyle? titleTextStyle;
  final TextStyle? contentTextStyle;

  static ConfirmDialogStyle merge(ConfirmDialogStyle? a, ConfirmDialogStyle? b) {
    return ConfirmDialogStyle(
      activeButtonStyle1: _mergeButtonStyles(a?.activeButtonStyle1, b?.activeButtonStyle1),
      activeButtonStyle2: _mergeButtonStyles(a?.activeButtonStyle2, b?.activeButtonStyle2),
      defaultButtonStyle: _mergeButtonStyles(a?.defaultButtonStyle, b?.defaultButtonStyle),
      backgroundColor: a?.backgroundColor ?? b?.backgroundColor,
      surfaceTintColor: a?.surfaceTintColor ?? b?.surfaceTintColor,
      elevation: a?.elevation ?? b?.elevation,
      shape: a?.shape ?? b?.shape,
      titleTextStyle: _mergeTextStyles(a?.titleTextStyle, b?.titleTextStyle),
      contentTextStyle: _mergeTextStyles(a?.contentTextStyle, b?.contentTextStyle),
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
    return b.merge(a);
  }

  static ConfirmDialogStyle lerp(ConfirmDialogStyle? a, ConfirmDialogStyle? b, double t) {
    return ConfirmDialogStyle(
      activeButtonStyle1: ButtonStyle.lerp(a?.activeButtonStyle1, b?.activeButtonStyle1, t),
      activeButtonStyle2: ButtonStyle.lerp(a?.activeButtonStyle2, b?.activeButtonStyle2, t),
      defaultButtonStyle: ButtonStyle.lerp(a?.defaultButtonStyle, b?.defaultButtonStyle, t),
      backgroundColor: Color.lerp(a?.backgroundColor, b?.backgroundColor, t),
      surfaceTintColor: Color.lerp(a?.surfaceTintColor, b?.surfaceTintColor, t),
      elevation: lerpDouble(a?.elevation, b?.elevation, t),
      shape: ShapeBorder.lerp(a?.shape, b?.shape, t),
      titleTextStyle: TextStyle.lerp(a?.titleTextStyle, b?.titleTextStyle, t),
      contentTextStyle: TextStyle.lerp(a?.contentTextStyle, b?.contentTextStyle, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ButtonStyle?>('activeButtonStyle1', activeButtonStyle1));
    properties.add(DiagnosticsProperty<ButtonStyle?>('activeButtonStyle2', activeButtonStyle2));
    properties.add(DiagnosticsProperty<ButtonStyle?>('defaultButtonStyle', defaultButtonStyle));
    properties.add(ColorProperty('backgroundColor', backgroundColor));
    properties.add(ColorProperty('surfaceTintColor', surfaceTintColor));
    properties.add(DoubleProperty('elevation', elevation));
    properties.add(DiagnosticsProperty<ShapeBorder?>('shape', shape));
    properties.add(DiagnosticsProperty<TextStyle?>('titleTextStyle', titleTextStyle));
    properties.add(DiagnosticsProperty<TextStyle?>('contentTextStyle', contentTextStyle));
  }
}
