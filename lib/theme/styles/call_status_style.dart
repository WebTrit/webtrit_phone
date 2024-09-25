import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CallStatusStyle with Diagnosticable {
  CallStatusStyle({
    this.connectivityNone,
    this.connectError,
    this.appUnregistered,
    this.connectIssue,
    this.inProgress,
    this.ready,
  });

  final Color? connectivityNone;
  final Color? connectError;
  final Color? appUnregistered;
  final Color? connectIssue;
  final Color? inProgress;
  final Color? ready;

  static CallStatusStyle lerp(CallStatusStyle? a, CallStatusStyle? b, double t) {
    return CallStatusStyle(
      connectivityNone: Color.lerp(a?.connectivityNone, b?.connectivityNone, t),
      connectError: Color.lerp(a?.connectError, b?.connectError, t),
      appUnregistered: Color.lerp(a?.appUnregistered, b?.appUnregistered, t),
      connectIssue: Color.lerp(a?.connectIssue, b?.connectIssue, t),
      inProgress: Color.lerp(a?.inProgress, b?.inProgress, t),
      ready: Color.lerp(a?.ready, b?.ready, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color?>('connectivityNone', connectivityNone));
    properties.add(DiagnosticsProperty<Color?>('connectError', connectError));
    properties.add(DiagnosticsProperty<Color?>('appUnregistered', appUnregistered));
    properties.add(DiagnosticsProperty<Color?>('connectIssue', connectIssue));
    properties.add(DiagnosticsProperty<Color?>('inProgress', inProgress));
    properties.add(DiagnosticsProperty<Color?>('ready', ready));
  }
}
