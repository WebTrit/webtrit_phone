import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActionpadStyle with Diagnosticable {
  const ActionpadStyle({this.primary, this.secondary, this.backspace});

  /// The main action button style (usually center: Audio Call, Transfer Confirm).
  final ScaleButtonStyle? primary;

  /// The secondary action button style (usually left: Video Call, Options Menu).
  final ScaleButtonStyle? secondary;

  /// The backspace button style (usually right).
  final ScaleButtonStyle? backspace;

  ActionpadStyle copyWith({ScaleButtonStyle? primary, ScaleButtonStyle? secondary, ScaleButtonStyle? backspace}) {
    return ActionpadStyle(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      backspace: backspace ?? this.backspace,
    );
  }

  static ActionpadStyle merge(ActionpadStyle? a, ActionpadStyle? b) {
    if (a == null) return b ?? const ActionpadStyle();
    if (b == null) return a;

    return ActionpadStyle(
      primary: ScaleButtonStyle.merge(a.primary, b.primary),
      secondary: ScaleButtonStyle.merge(a.secondary, b.secondary),
      backspace: ScaleButtonStyle.merge(a.backspace, b.backspace),
    );
  }

  static ActionpadStyle lerp(ActionpadStyle? a, ActionpadStyle? b, double t) {
    return ActionpadStyle(
      primary: ScaleButtonStyle.lerp(a?.primary, b?.primary, t),
      secondary: ScaleButtonStyle.lerp(a?.secondary, b?.secondary, t),
      backspace: ScaleButtonStyle.lerp(a?.backspace, b?.backspace, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ScaleButtonStyle?>('primary', primary))
      ..add(DiagnosticsProperty<ScaleButtonStyle?>('secondary', secondary))
      ..add(DiagnosticsProperty<ScaleButtonStyle?>('backspace', backspace));
  }
}

class ScaleButtonStyle with Diagnosticable {
  const ScaleButtonStyle({this.style, this.scale = 1.0});

  final ButtonStyle? style;
  final double scale;

  /// Merges two ScaleButtonStyle objects.
  /// The [style] is merged using ButtonStyle.merge.
  /// The [scale] from [b] takes precedence over [a] if [b] is not null.
  static ScaleButtonStyle? merge(ScaleButtonStyle? a, ScaleButtonStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return ScaleButtonStyle(style: a.style?.merge(b.style) ?? b.style, scale: b.scale);
  }

  static ScaleButtonStyle? lerp(ScaleButtonStyle? a, ScaleButtonStyle? b, double t) {
    if (a == null && b == null) return null;
    return ScaleButtonStyle(
      style: ButtonStyle.lerp(a?.style, b?.style, t),
      scale: Tween<double>(begin: a?.scale ?? 1.0, end: b?.scale ?? 1.0).transform(t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ButtonStyle?>('style', style))
      ..add(DoubleProperty('scale', scale));
  }
}
