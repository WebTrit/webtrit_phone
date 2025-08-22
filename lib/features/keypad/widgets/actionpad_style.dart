import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActionpadStyle with Diagnosticable {
  const ActionpadStyle({
    this.callTransfer,
    this.callStart,
    this.backspacePressed,
  });

  final ButtonStyle? callTransfer;
  final ButtonStyle? callStart;
  final ButtonStyle? backspacePressed;

  ActionpadStyle copyWith({
    ButtonStyle? callTransfer,
    ButtonStyle? callStart,
    ButtonStyle? backspacePressed,
  }) {
    return ActionpadStyle(
      callTransfer: callTransfer ?? this.callTransfer,
      callStart: callStart ?? this.callStart,
      backspacePressed: backspacePressed ?? this.backspacePressed,
    );
  }

  static ActionpadStyle merge(ActionpadStyle? a, ActionpadStyle? b) {
    if (a == null) return b ?? const ActionpadStyle();
    if (b == null) return a;
    return ActionpadStyle(
      callTransfer: _mergeButtonStyles(a.callTransfer, b.callTransfer),
      callStart: _mergeButtonStyles(a.callStart, b.callStart),
      backspacePressed: _mergeButtonStyles(a.backspacePressed, b.backspacePressed),
    );
  }

  static ButtonStyle? _mergeButtonStyles(ButtonStyle? a, ButtonStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.merge(b);
  }

  static ActionpadStyle lerp(ActionpadStyle? a, ActionpadStyle? b, double t) {
    return ActionpadStyle(
      callTransfer: ButtonStyle.lerp(a?.callTransfer, b?.callTransfer, t),
      callStart: ButtonStyle.lerp(a?.callStart, b?.callStart, t),
      backspacePressed: ButtonStyle.lerp(a?.backspacePressed, b?.backspacePressed, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ButtonStyle?>('callTransfer', callTransfer))
      ..add(DiagnosticsProperty<ButtonStyle?>('callStart', callStart))
      ..add(DiagnosticsProperty<ButtonStyle?>('backspacePressed', backspacePressed));
  }
}
