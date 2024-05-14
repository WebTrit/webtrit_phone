import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActionpadStyle with Diagnosticable {
  ActionpadStyle({
    this.callTransfer,
    this.callStart,
    this.backspacePressed,
  });

  final ButtonStyle? callTransfer;
  final ButtonStyle? callStart;
  final ButtonStyle? backspacePressed;

  static ActionpadStyle lerp(ActionpadStyle? a, ActionpadStyle? b, double t) {
    final callTransfer = ButtonStyle.lerp(a?.callTransfer, b?.callTransfer, t);
    final callStart = ButtonStyle.lerp(a?.callStart, b?.callStart, t);
    final backspacePressed = ButtonStyle.lerp(a?.backspacePressed, b?.backspacePressed, t);
    return ActionpadStyle(
      callTransfer: callTransfer,
      callStart: callStart,
      backspacePressed: backspacePressed
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ButtonStyle?>('callTransfer', callTransfer));
    properties.add(DiagnosticsProperty<ButtonStyle?>('callStart', callStart));
    properties.add(DiagnosticsProperty<ButtonStyle?>('backspacePressed', backspacePressed));
  }
}
