import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PresenceStatusStyle with Diagnosticable {
  PresenceStatusStyle({
    this.available,
    this.unavailable,
  });

  final Color? available;
  final Color? unavailable;

  static PresenceStatusStyle lerp(PresenceStatusStyle? a, PresenceStatusStyle? b, double t) {
    return PresenceStatusStyle(
      available: Color.lerp(a?.available, b?.available, t),
      unavailable: Color.lerp(a?.unavailable, b?.unavailable, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color?>('available', available));
    properties.add(DiagnosticsProperty<Color?>('unavailable', unavailable));
  }
}
