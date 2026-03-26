import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'platform_event.dart';

final _logger = Logger('PlatformBridge');

/// Decoupled interface for the native call-platform bridge.
///
/// Implements [CallkeepDelegate] to receive native callbacks and translates
/// them into typed [PlatformEvent]s emitted on [events].
///
/// [CallBloc] subscribes to [events] and maps each event to an internal
/// BLoC event or state update.
abstract interface class PlatformBridge implements CallkeepDelegate {
  Stream<PlatformEvent> get events;
  void dispose();
}

/// Concrete [PlatformBridge] implementation.
///
/// On construction it registers itself as the [Callkeep] delegate.
/// [dispose] de-registers the delegate, fails all pending [PerformCallEvent]
/// completers, and closes the internal stream controller.
class PlatformBridgeImpl implements PlatformBridge {
  PlatformBridgeImpl({required Callkeep callkeep}) : _callkeep = callkeep {
    _callkeep.setDelegate(this);
  }

  final Callkeep _callkeep;

  // Synchronous broadcast stream to keep test behaviour identical to the
  // previous mixin-based implementation: listeners fire in the same microtask
  // as the add() call, so fakeAsync tests need only one flushMicrotasks().
  final _controller = StreamController<PlatformEvent>.broadcast(sync: true);
  final _pendingPerforms = <PerformCallEvent>{};

  @override
  Stream<PlatformEvent> get events => _controller.stream;

  @override
  void dispose() {
    final copy = _pendingPerforms.toList();
    _pendingPerforms.clear();
    for (final event in copy) {
      event.complete(false);
    }
    _callkeep.setDelegate(null);
    _controller.close();
  }

  // ---------------------------------------------------------------------------
  // CallkeepDelegate — intent callbacks
  // ---------------------------------------------------------------------------

  @override
  void continueStartCallIntent(CallkeepHandle handle, String? displayName, bool video) {
    _logger.fine(() => 'continueStartCallIntent handle: $handle displayName: $displayName video: $video');
    if (_controller.isClosed) return;
    _controller.add(StartCallIntentPlatformEvent(handle: handle, displayName: displayName, video: video));
  }

  @override
  void didPushIncomingCall(
    CallkeepHandle handle,
    String? displayName,
    bool video,
    String callId,
    CallkeepIncomingCallError? error,
  ) {
    _logger.fine(
      () =>
          'didPushIncomingCall handle: $handle displayName: $displayName'
          ' video: $video callId: $callId error: $error',
    );
    if (_controller.isClosed) return;
    _controller.add(
      PushIncomingCallPlatformEvent(
        callId: callId,
        handle: handle,
        displayName: displayName,
        video: video,
        error: error,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CallkeepDelegate — perform callbacks (return Future<bool> to native side)
  // ---------------------------------------------------------------------------

  @override
  Future<bool> performStartCall(
    String callId,
    CallkeepHandle handle,
    String? displayNameOrContactIdentifier,
    bool video,
  ) => _perform(
    StartCallPerformEvent(callId: callId, handle: handle, displayName: displayNameOrContactIdentifier, video: video),
  );

  @override
  Future<bool> performAnswerCall(String callId) => _perform(AnswerCallPerformEvent(callId));

  @override
  Future<bool> performEndCall(String callId) => _perform(EndCallPerformEvent(callId));

  @override
  Future<bool> performSetHeld(String callId, bool onHold) => _perform(SetHeldPerformEvent(callId, onHold));

  @override
  Future<bool> performSetMuted(String callId, bool muted) => _perform(SetMutedPerformEvent(callId, muted));

  @override
  Future<bool> performSendDTMF(String callId, String key) => _perform(SendDtmfPerformEvent(callId, key));

  @override
  Future<bool> performAudioDeviceSet(String callId, CallkeepAudioDevice device) =>
      _perform(AudioDeviceSetPerformEvent(callId, device));

  @override
  Future<bool> performAudioDevicesUpdate(String callId, List<CallkeepAudioDevice> devices) =>
      _perform(AudioDevicesUpdatePerformEvent(callId, devices));

  // ---------------------------------------------------------------------------
  // CallkeepDelegate — audio session callbacks (handled directly, no BLoC event)
  // ---------------------------------------------------------------------------

  @override
  void didActivateAudioSession() {
    _logger.fine('didActivateAudioSession');
    unawaited(
      Future(() async {
        try {
          await AppleNativeAudioManagement.audioSessionDidActivate();
          await AppleNativeAudioManagement.setIsAudioEnabled(true);
        } catch (e, s) {
          _logger.warning('didActivateAudioSession error', e, s);
        }
      }),
    );
  }

  @override
  void didDeactivateAudioSession() {
    _logger.fine('didDeactivateAudioSession');
    unawaited(
      Future(() async {
        try {
          await AppleNativeAudioManagement.setIsAudioEnabled(false);
          await AppleNativeAudioManagement.audioSessionDidDeactivate();
        } catch (e, s) {
          _logger.warning('didDeactivateAudioSession error', e, s);
        }
      }),
    );
  }

  @override
  void didReset() {
    _logger.warning('didReset');
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  Future<bool> _perform(PerformCallEvent event) {
    _pendingPerforms.add(event);
    if (!_controller.isClosed) _controller.add(event);
    return event.result.whenComplete(() => _pendingPerforms.remove(event));
  }
}
