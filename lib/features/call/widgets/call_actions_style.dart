import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CallActionsStyle with Diagnosticable {
  CallActionsStyle({
    this.callStart,
    this.camera,
    this.cameraActive,
    this.muted,
    this.mutedActive,
    this.speaker,
    this.speakerActive,
    this.transfer,
    this.held,
    this.heldActive,
    this.swap,
    this.hangup,
    this.key,
    this.keypad,
    this.keypadActive,
  });

  final ButtonStyle? callStart;
  final ButtonStyle? keypad;
  final ButtonStyle? keypadActive;
  final ButtonStyle? camera;
  final ButtonStyle? cameraActive;
  final ButtonStyle? muted;
  final ButtonStyle? mutedActive;
  final ButtonStyle? speaker;
  final ButtonStyle? speakerActive;
  final ButtonStyle? transfer;
  final ButtonStyle? held;
  final ButtonStyle? heldActive;
  final ButtonStyle? swap;
  final ButtonStyle? hangup;
  final ButtonStyle? key;

  static CallActionsStyle merge(CallActionsStyle? a, CallActionsStyle? b) {
    final cameraStyle = _mergeButtonStyles(a?.camera, b?.camera);
    final callStartStyle = _mergeButtonStyles(a?.callStart, b?.callStart);
    final cameraActiveStyle = _mergeButtonStyles(a?.cameraActive, b?.cameraActive);
    final mutedStyle = _mergeButtonStyles(a?.muted, b?.muted);
    final mutedActiveStyle = _mergeButtonStyles(a?.mutedActive, b?.mutedActive);
    final speakerStyle = _mergeButtonStyles(a?.speaker, b?.speaker);
    final speakerActiveStyle = _mergeButtonStyles(a?.speakerActive, b?.speakerActive);
    final transferStyle = _mergeButtonStyles(a?.transfer, b?.transfer);
    final heldStyle = _mergeButtonStyles(a?.held, b?.held);
    final heldActiveStyle = _mergeButtonStyles(a?.heldActive, b?.heldActive);
    final swapStyle = _mergeButtonStyles(a?.swap, b?.swap);
    final hangupStyle = _mergeButtonStyles(a?.hangup, b?.hangup);
    final keyStyle = _mergeButtonStyles(a?.key, b?.key);
    final keypadStyle = _mergeButtonStyles(a?.keypad, b?.keypad);
    final keypadActiveStyle = _mergeButtonStyles(a?.keypadActive, b?.keypadActive);

    return CallActionsStyle(
      camera: cameraStyle,
      callStart: callStartStyle,
      cameraActive: cameraActiveStyle,
      muted: mutedStyle,
      mutedActive: mutedActiveStyle,
      speaker: speakerStyle,
      speakerActive: speakerActiveStyle,
      transfer: transferStyle,
      held: heldStyle,
      heldActive: heldActiveStyle,
      swap: swapStyle,
      hangup: hangupStyle,
      key: keyStyle,
      keypad: keypadStyle,
      keypadActive: keypadActiveStyle,
    );
  }

  static ButtonStyle? _mergeButtonStyles(ButtonStyle? a, ButtonStyle? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.merge(b);
  }

  static CallActionsStyle lerp(CallActionsStyle? a, CallActionsStyle? b, double t) {
    final newCallStartStyle = ButtonStyle.lerp(a?.callStart, b?.callStart, t);
    final newCameraStyle = ButtonStyle.lerp(a?.camera, b?.camera, t);
    final newCameraActiveStyle = ButtonStyle.lerp(a?.cameraActive, b?.cameraActive, t);
    final newMutedStyle = ButtonStyle.lerp(a?.muted, b?.muted, t);
    final newMutedActiveStyle = ButtonStyle.lerp(a?.mutedActive, b?.mutedActive, t);
    final newSpeakerStyle = ButtonStyle.lerp(a?.speaker, b?.speaker, t);
    final newSpeakerActiveStyle = ButtonStyle.lerp(a?.speakerActive, b?.speakerActive, t);
    final newTransferStyle = ButtonStyle.lerp(a?.transfer, b?.transfer, t);
    final newHeldStyle = ButtonStyle.lerp(a?.held, b?.held, t);
    final newHeldActiveStyle = ButtonStyle.lerp(a?.heldActive, b?.heldActive, t);
    final newSwapStyle = ButtonStyle.lerp(a?.swap, b?.swap, t);
    final newHangupStyle = ButtonStyle.lerp(a?.hangup, b?.hangup, t);
    final newKeyStyle = ButtonStyle.lerp(a?.key, b?.key, t);
    final newKeypadStyle = ButtonStyle.lerp(a?.keypad, b?.keypad, t);
    final newKeypadActiveStyle = ButtonStyle.lerp(a?.keypadActive, b?.keypadActive, t);

    return CallActionsStyle(
      callStart: newCallStartStyle,
      camera: newCameraStyle,
      cameraActive: newCameraActiveStyle,
      muted: newMutedStyle,
      mutedActive: newMutedActiveStyle,
      speaker: newSpeakerStyle,
      speakerActive: newSpeakerActiveStyle,
      transfer: newTransferStyle,
      held: newHeldStyle,
      heldActive: newHeldActiveStyle,
      swap: newSwapStyle,
      hangup: newHangupStyle,
      key: newKeyStyle,
      keypad: newKeypadStyle,
      keypadActive: newKeypadActiveStyle,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<ButtonStyle?>('callStart', callStart))
      ..add(DiagnosticsProperty<ButtonStyle?>('camera', camera))
      ..add(DiagnosticsProperty<ButtonStyle?>('cameraActive', cameraActive))
      ..add(DiagnosticsProperty<ButtonStyle?>('muted', muted))
      ..add(DiagnosticsProperty<ButtonStyle?>('mutedActive', mutedActive))
      ..add(DiagnosticsProperty<ButtonStyle?>('speaker', speaker))
      ..add(DiagnosticsProperty<ButtonStyle?>('speakerActive', speakerActive))
      ..add(DiagnosticsProperty<ButtonStyle?>('transfer', transfer))
      ..add(DiagnosticsProperty<ButtonStyle?>('held', held))
      ..add(DiagnosticsProperty<ButtonStyle?>('heldActive', heldActive))
      ..add(DiagnosticsProperty<ButtonStyle?>('swap', swap))
      ..add(DiagnosticsProperty<ButtonStyle?>('hangup', hangup))
      ..add(DiagnosticsProperty<ButtonStyle?>('key', key))
      ..add(DiagnosticsProperty<ButtonStyle?>('keypad', keypad))
      ..add(DiagnosticsProperty<ButtonStyle?>('keypadActive', keypadActive));
  }
}
