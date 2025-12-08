import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RegisteredStatusStyle with Diagnosticable {
  RegisteredStatusStyle({this.registered, this.unregistered});

  final Color? registered;
  final Color? unregistered;

  static RegisteredStatusStyle lerp(RegisteredStatusStyle? a, RegisteredStatusStyle? b, double t) {
    return RegisteredStatusStyle(
      registered: Color.lerp(a?.registered, b?.registered, t),
      unregistered: Color.lerp(a?.unregistered, b?.unregistered, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color?>('registered', registered));
    properties.add(DiagnosticsProperty<Color?>('unregistered', unregistered));
  }
}
