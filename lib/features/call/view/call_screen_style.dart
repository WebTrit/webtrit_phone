import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

class CallScreenStyle with Diagnosticable {
  CallScreenStyle({
    this.systemUiOverlayStyle,
    this.appBar,
    this.callInfo,
  });

  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final AppBarStyle? appBar;
  final CallInfoStyle? callInfo;

  static CallScreenStyle? lerp(CallScreenStyle? a, CallScreenStyle? b, double t) {
    if (identical(a, b)) return a;

    return CallScreenStyle(
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      callInfo: CallInfoStyle.lerp(a?.callInfo, b?.callInfo, t),
      appBar: AppBarStyle.lerp(a?.appBar, b?.appBar, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle))
      ..add(DiagnosticsProperty<AppBarStyle?>('appBar', appBar))
      ..add(DiagnosticsProperty<CallInfoStyle?>('callInfo', callInfo));
  }
}

class CallInfoStyle with Diagnosticable {
  const CallInfoStyle({
    this.userInfo,
    this.number,
    this.callStatus,
    this.processingStatus,
  });

  final TextStyle? userInfo;

  final TextStyle? number;

  final TextStyle? callStatus;

  final TextStyle? processingStatus;

  static CallInfoStyle? lerp(CallInfoStyle? a, CallInfoStyle? b, double t) {
    if (identical(a, b)) return a;

    return CallInfoStyle(
      userInfo: TextStyle.lerp(a?.userInfo, b?.userInfo, t),
      number: TextStyle.lerp(a?.number, b?.number, t),
      callStatus: TextStyle.lerp(a?.callStatus, b?.callStatus, t),
      processingStatus: TextStyle.lerp(a?.processingStatus, b?.processingStatus, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextStyle?>('userInfo', userInfo))
      ..add(DiagnosticsProperty<TextStyle?>('number', number))
      ..add(DiagnosticsProperty<TextStyle?>('callStatus', callStatus))
      ..add(DiagnosticsProperty<TextStyle?>('processingStatus', processingStatus));
  }
}
