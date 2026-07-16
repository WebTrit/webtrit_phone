import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webtrit_phone/theme/styles/styles.dart';

class CallScreenStyle with Diagnosticable {
  CallScreenStyle({
    this.background,
    this.systemUiOverlayStyle,
    this.appBar,
    this.callInfo,
    this.list,
    this.hint,
    this.actions,
  });

  final BackgroundStyle? background;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final AppBarStyle? appBar;
  final CallInfoStyle? callInfo;
  final CallListStyle? list;
  final FocusedActionHintStyle? hint;
  final CallScreenActionsStyle? actions;

  static CallScreenStyle? lerp(CallScreenStyle? a, CallScreenStyle? b, double t) {
    if (identical(a, b)) return a;

    return CallScreenStyle(
      background: BackgroundStyle.lerp(a?.background, b?.background, t),
      systemUiOverlayStyle: b?.systemUiOverlayStyle ?? a?.systemUiOverlayStyle,
      callInfo: CallInfoStyle.lerp(a?.callInfo, b?.callInfo, t),
      list: CallListStyle.lerp(a?.list, b?.list, t),
      hint: FocusedActionHintStyle.lerp(a?.hint, b?.hint, t),
      appBar: AppBarStyle.lerp(a?.appBar, b?.appBar, t),
      actions: CallScreenActionsStyle.lerp(a?.actions, b?.actions, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<BackgroundStyle?>('background', background))
      ..add(DiagnosticsProperty<SystemUiOverlayStyle?>('systemUiOverlayStyle', systemUiOverlayStyle))
      ..add(DiagnosticsProperty<AppBarStyle?>('appBar', appBar))
      ..add(DiagnosticsProperty<CallInfoStyle?>('callInfo', callInfo))
      ..add(DiagnosticsProperty<CallListStyle?>('list', list))
      ..add(DiagnosticsProperty<FocusedActionHintStyle?>('hint', hint))
      ..add(DiagnosticsProperty<CallScreenActionsStyle?>('actions', actions));
  }
}

/// Colors of the call-list rows: overlays, the focused border and the
/// per-state status dots.
class CallListStyle with Diagnosticable {
  const CallListStyle({
    this.rowBackground,
    this.rowFocusedBackground,
    this.rowFocusedBorder,
    this.dotRinging,
    this.dotOnCall,
    this.dotHeld,
  });

  final Color? rowBackground;
  final Color? rowFocusedBackground;
  final Color? rowFocusedBorder;
  final Color? dotRinging;
  final Color? dotOnCall;
  final Color? dotHeld;

  static CallListStyle? lerp(CallListStyle? a, CallListStyle? b, double t) {
    if (identical(a, b)) return a;

    return CallListStyle(
      rowBackground: Color.lerp(a?.rowBackground, b?.rowBackground, t),
      rowFocusedBackground: Color.lerp(a?.rowFocusedBackground, b?.rowFocusedBackground, t),
      rowFocusedBorder: Color.lerp(a?.rowFocusedBorder, b?.rowFocusedBorder, t),
      dotRinging: Color.lerp(a?.dotRinging, b?.dotRinging, t),
      dotOnCall: Color.lerp(a?.dotOnCall, b?.dotOnCall, t),
      dotHeld: Color.lerp(a?.dotHeld, b?.dotHeld, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('rowBackground', rowBackground))
      ..add(ColorProperty('rowFocusedBackground', rowFocusedBackground))
      ..add(ColorProperty('rowFocusedBorder', rowFocusedBorder))
      ..add(ColorProperty('dotRinging', dotRinging))
      ..add(ColorProperty('dotOnCall', dotOnCall))
      ..add(ColorProperty('dotHeld', dotHeld));
  }
}

/// Colors of the "Acting on" hint pill: the pill background and the
/// highlighted affected-call names.
class FocusedActionHintStyle with Diagnosticable {
  const FocusedActionHintStyle({this.background, this.affectedName});

  final Color? background;
  final Color? affectedName;

  static FocusedActionHintStyle? lerp(FocusedActionHintStyle? a, FocusedActionHintStyle? b, double t) {
    if (identical(a, b)) return a;

    return FocusedActionHintStyle(
      background: Color.lerp(a?.background, b?.background, t),
      affectedName: Color.lerp(a?.affectedName, b?.affectedName, t),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ColorProperty('background', background))
      ..add(ColorProperty('affectedName', affectedName));
  }
}

class CallInfoStyle with Diagnosticable {
  const CallInfoStyle({this.userInfo, this.number, this.callStatus, this.processingStatus});

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
    this.keypadInputTextStyle,
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

  /// Text style for the digits typed on the in-call DTMF keypad.
  final TextStyle? keypadInputTextStyle;

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
    TextStyle? keypadInputTextStyle,
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
      keypadInputTextStyle: keypadInputTextStyle ?? this.keypadInputTextStyle,
    );
  }

  /// Field-wise merge. `other` overrides non-null ButtonStyle parts.
  CallScreenActionsStyle merge(CallScreenActionsStyle? other) {
    if (other == null) return this;

    ButtonStyle? mergeButtonStyle(ButtonStyle? a, ButtonStyle? b) {
      if (a == null) return b;
      return a.merge(b);
    }

    TextStyle? mergeTextStyle(TextStyle? a, TextStyle? b) {
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
      keypadInputTextStyle: mergeTextStyle(keypadInputTextStyle, other.keypadInputTextStyle),
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
      keypadInputTextStyle: TextStyle.lerp(a?.keypadInputTextStyle, b?.keypadInputTextStyle, t),
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
      ..add(DiagnosticsProperty<ButtonStyle?>('key', key))
      ..add(DiagnosticsProperty<TextStyle?>('keypadInputTextStyle', keypadInputTextStyle));
  }
}
