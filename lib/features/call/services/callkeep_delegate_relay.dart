import 'dart:async';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';

/// A [CallkeepDelegate] attached to callkeep EARLY (in `MainShell.initState`),
/// before [CallBloc] exists, that BUFFERS delegate callbacks until the real
/// delegate ([CallBloc]) [attach]es.
///
/// Why: callkeep fires `onDelegateSet` -> a native connection-state replay only
/// once a Flutter delegate is attached. Attaching this relay early makes that
/// replay run while the app is still booting (a quiet window), so an in-flight
/// incoming call from a push->foreground handoff is captured into the buffer and
/// replayed into [CallBloc] the instant it is created -- before the late signaling
/// hangup, which otherwise hits `call == null` and drops the call (leaving a ghost
/// incoming).
///
/// Once [attach]ed it is a transparent forwarder to the target. It remains the
/// single registered callkeep delegate for the lifetime of the shell; [CallBloc]
/// reports through it via [attach] / [detach] instead of calling
/// `callkeep.setDelegate` directly.
class CallkeepDelegateRelay implements CallkeepDelegate {
  CallkeepDelegate? _target;
  final List<void Function(CallkeepDelegate)> _pending = [];

  /// Set the real delegate and replay any buffered callbacks into it, in order.
  void attach(CallkeepDelegate target) {
    _target = target;
    final pending = List<void Function(CallkeepDelegate)>.of(_pending);
    _pending.clear();
    for (final action in pending) {
      action(target);
    }
  }

  /// Detach the real delegate (e.g. on `CallBloc.close()`). Subsequent callbacks
  /// buffer again until the next [attach].
  void detach() {
    _target = null;
  }

  void _run(void Function(CallkeepDelegate) action) {
    final target = _target;
    if (target != null) {
      action(target);
    } else {
      _pending.add(action);
    }
  }

  Future<bool> _runFuture(Future<bool> Function(CallkeepDelegate) action) {
    final target = _target;
    if (target != null) return action(target);
    // Defer: native awaits the result, so complete it once the target attaches
    // and actually handles the call.
    final completer = Completer<bool>();
    _pending.add(
      (d) => action(d).then(completer.complete).catchError((Object e, StackTrace s) {
        completer.completeError(e, s);
      }),
    );
    return completer.future;
  }

  @override
  void didPushIncomingCall(
    CallkeepHandle handle,
    String? displayName,
    bool video,
    String callId,
    CallkeepIncomingCallError? error,
  ) => _run((d) => d.didPushIncomingCall(handle, displayName, video, callId, error));

  @override
  void continueStartCallIntent(CallkeepHandle handle, String? displayName, bool video) =>
      _run((d) => d.continueStartCallIntent(handle, displayName, video));

  @override
  void didActivateAudioSession() => _run((d) => d.didActivateAudioSession());

  @override
  void didDeactivateAudioSession() => _run((d) => d.didDeactivateAudioSession());

  @override
  void didReset() => _run((d) => d.didReset());

  @override
  Future<bool> performStartCall(
    String callId,
    CallkeepHandle handle,
    String? displayNameOrContactIdentifier,
    bool video,
  ) => _runFuture((d) => d.performStartCall(callId, handle, displayNameOrContactIdentifier, video));

  @override
  Future<bool> performAnswerCall(String callId) => _runFuture((d) => d.performAnswerCall(callId));

  @override
  Future<bool> performEndCall(String callId) => _runFuture((d) => d.performEndCall(callId));

  @override
  Future<bool> performSetHeld(String callId, bool onHold) => _runFuture((d) => d.performSetHeld(callId, onHold));

  @override
  Future<bool> performSetMuted(String callId, bool muted) => _runFuture((d) => d.performSetMuted(callId, muted));

  @override
  Future<bool> performSendDTMF(String callId, String key) => _runFuture((d) => d.performSendDTMF(callId, key));

  @override
  Future<bool> performAudioDeviceSet(String callId, CallkeepAudioDevice device) =>
      _runFuture((d) => d.performAudioDeviceSet(callId, device));

  @override
  Future<bool> performAudioDevicesUpdate(String callId, List<CallkeepAudioDevice> devices) =>
      _runFuture((d) => d.performAudioDevicesUpdate(callId, devices));
}
