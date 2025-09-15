import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

class CallScreenStyle with Diagnosticable {
  CallScreenStyle({
    this.systemUiOverlayStyle,
    this.appBar,
    this.callInfo,
    this.actions,
  });

  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final AppBarStyle? appBar;
  final CallInfoStyle? callInfo;
  final CallScreenActionsStyle? actions;

  static CallScreenStyle? lerp(CallScreenStyle? a, CallScreenStyle? b, double t) {
    if (identical(a, b)) return a;

    return CallScreenStyle(
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      callInfo: CallInfoStyle.lerp(a?.callInfo, b?.callInfo, t),
      appBar: AppBarStyle.lerp(a?.appBar, b?.appBar, t),
      actions: CallScreenActionsStyle.lerp(a?.actions, b?.actions, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle))
      ..add(DiagnosticsProperty<AppBarStyle?>('appBar', appBar))
      ..add(DiagnosticsProperty<CallInfoStyle?>('callInfo', callInfo))
      ..add(DiagnosticsProperty<CallScreenActionsStyle?>('actions', actions));
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

class CallScreenActionsStyle with Diagnosticable {
  const CallScreenActionsStyle({
    this.callStart,
    this.hangup,
    this.transfer,
    this.camera,
    this.muted,
    this.speaker,
    this.held,
    this.swap,
    this.key,
  });

  final ButtonStyle? callStart;
  final ButtonStyle? hangup;
  final ButtonStyle? transfer;
  final ButtonStyle? camera;
  final ButtonStyle? muted;
  final ButtonStyle? speaker;
  final ButtonStyle? held;
  final ButtonStyle? swap;
  final ButtonStyle? key;

  CallScreenActionsStyle copyWith({
    ButtonStyle? callStart,
    ButtonStyle? hangup,
    ButtonStyle? transfer,
    ButtonStyle? camera,
    ButtonStyle? muted,
    ButtonStyle? speaker,
    ButtonStyle? held,
    ButtonStyle? swap,
    ButtonStyle? key,
  }) {
    return CallScreenActionsStyle(
      callStart: callStart ?? this.callStart,
      hangup: hangup ?? this.hangup,
      transfer: transfer ?? this.transfer,
      camera: camera ?? this.camera,
      muted: muted ?? this.muted,
      speaker: speaker ?? this.speaker,
      held: held ?? this.held,
      swap: swap ?? this.swap,
      key: key ?? this.key,
    );
  }

  /// Field-wise merge. `other` overrides non-null ButtonStyle parts.
  CallScreenActionsStyle merge(CallScreenActionsStyle? other) {
    if (other == null) return this;

    ButtonStyle? mergeButtonStyle(ButtonStyle? a, ButtonStyle? b) {
      if (a == null) return b;
      return a.merge(b);
    }

    return CallScreenActionsStyle(
      callStart: mergeButtonStyle(callStart, other.callStart),
      hangup: mergeButtonStyle(hangup, other.hangup),
      transfer: mergeButtonStyle(transfer, other.transfer),
      camera: mergeButtonStyle(camera, other.camera),
      muted: mergeButtonStyle(muted, other.muted),
      speaker: mergeButtonStyle(speaker, other.speaker),
      held: mergeButtonStyle(held, other.held),
      swap: mergeButtonStyle(swap, other.swap),
      key: mergeButtonStyle(key, other.key),
    );
  }

  static CallScreenActionsStyle? lerp(CallScreenActionsStyle? a, CallScreenActionsStyle? b, double t) {
    if (identical(a, b)) return a;
    return CallScreenActionsStyle(
      callStart: ButtonStyle.lerp(a?.callStart, b?.callStart, t),
      hangup: ButtonStyle.lerp(a?.hangup, b?.hangup, t),
      transfer: ButtonStyle.lerp(a?.transfer, b?.transfer, t),
      camera: ButtonStyle.lerp(a?.camera, b?.camera, t),
      muted: ButtonStyle.lerp(a?.muted, b?.muted, t),
      speaker: ButtonStyle.lerp(a?.speaker, b?.speaker, t),
      held: ButtonStyle.lerp(a?.held, b?.held, t),
      swap: ButtonStyle.lerp(a?.swap, b?.swap, t),
      key: ButtonStyle.lerp(a?.key, b?.key, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ButtonStyle?>('callStart', callStart))
      ..add(DiagnosticsProperty<ButtonStyle?>('hangup', hangup))
      ..add(DiagnosticsProperty<ButtonStyle?>('transfer', transfer))
      ..add(DiagnosticsProperty<ButtonStyle?>('camera', camera))
      ..add(DiagnosticsProperty<ButtonStyle?>('muted', muted))
      ..add(DiagnosticsProperty<ButtonStyle?>('speaker', speaker))
      ..add(DiagnosticsProperty<ButtonStyle?>('held', held))
      ..add(DiagnosticsProperty<ButtonStyle?>('swap', swap))
      ..add(DiagnosticsProperty<ButtonStyle?>('key', key));
  }
}
