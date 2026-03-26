part of 'call_bloc.dart';

/// Implements [CallkeepDelegate] by translating native platform callbacks into
/// bloc events.  Lives in the same library as [CallBloc] so it can create
/// private event classes directly.
mixin _PlatformBridgeMixin on Bloc<CallEvent, CallState> implements CallkeepDelegate {
  // Abstract fields satisfied by CallBloc.
  Function(Notification) get submitNotification;

  /// Tracks in-flight [_CallPerformEvent]s whose [_CallPerformEvent.future] has
  /// been handed to the native CallKit/ConnectionService layer.  Call
  /// [_drainPendingPerformEvents] from [CallBloc.close] to fail them all,
  /// preventing the native side from hanging when the BLoC tears down.
  final _pendingPerformEvents = <_CallPerformEvent>{};

  void _drainPendingPerformEvents() {
    for (final event in _pendingPerformEvents) {
      event.fail();
    }
    _pendingPerformEvents.clear();
  }

  @override
  void continueStartCallIntent(CallkeepHandle handle, String? displayName, bool video) {
    _logger.fine(() => 'continueStartCallIntent handle: $handle displayName: $displayName video: $video');
    unawaited(_continueStartCallIntent(handle, displayName, video));
  }

  Future<void> _continueStartCallIntent(CallkeepHandle handle, String? displayName, bool video) async {
    _logger.fine(
      () => StringBuffer()
        ..write('_continueStartCallIntent - Attempting to start call')
        ..write(' handle: $handle')
        ..write(' displayName: $displayName')
        ..write(' video: $video')
        ..write(' isHandshakeActive: ${state.isHandshakeEstablished}')
        ..write(' isSignalingActive: ${state.isSignalingEstablished}'),
    );

    try {
      // Wait until both signaling and handshake are active.
      // If the desired state is not reached within kSignalingClientConnectionTimeout,
      // a TimeoutException is thrown.
      final resolvedState = await stream
          .firstWhere((s) => s.isHandshakeEstablished && s.isSignalingEstablished)
          .timeout(kSignalingClientConnectionTimeout);

      if (isClosed) return;

      _logger.fine(
        () => StringBuffer()
          ..write('_continueStartCallIntent - Signaling and handshake are now active for')
          ..write(' handle: $handle')
          ..write(' displayName: $displayName')
          ..write(' video: $video')
          ..write(' isHandshakeActive: ${resolvedState.isHandshakeEstablished}')
          ..write(' isSignalingActive: ${resolvedState.isSignalingEstablished}'),
      );

      add(
        CallControlEvent.started(
          generic: handle.isGeneric ? handle.value : null,
          number: handle.isNumber ? handle.value : null,
          email: handle.isEmail ? handle.value : null,
          displayName: displayName,
          video: video,
        ),
      );
    } on TimeoutException {
      if (isClosed) return;

      _logger.warning(
        () => StringBuffer()
          ..write('_continueStartCallIntent - Failed to start call')
          ..write(' handle: $handle')
          ..write(' (Signaling/handshake connection timed out after ${kSignalingClientConnectionTimeout.inSeconds}s)')
          ..write(' isHandshakeActive: ${state.isHandshakeEstablished}')
          ..write(' isSignalingActive: ${state.isSignalingEstablished}'),
      );

      submitNotification(const SignalingConnectFailedNotification());
    } catch (e, s) {
      if (isClosed) return;

      final severeMessage = StringBuffer()
        ..write('_continueStartCallIntent - An unexpected error occurred while waiting for signaling')
        ..write(' handle: $handle');
      _logger.severe(() => severeMessage, e, s);

      submitNotification(ErrorMessageNotification(e.toString()));
    }
  }

  @override
  // Handles incoming call notifications from the native side.
  // On iOS, triggered via PushKit when a push is received.
  //
  // On Android, this method is currently not used. Call state synchronization
  // from the background is handled by `CallkeepConnections`. A future refactoring
  // could unify this logic so that both platforms use this delegate method.
  //
  // TODO: Unify incoming-call handling for both iOS and Android so that
  // this method becomes the shared entry point. This may require removing
  // `CallkeepConnections` and adjusting the method signature.
  void didPushIncomingCall(
    CallkeepHandle handle,
    String? displayName,
    bool video,
    String callId,
    CallkeepIncomingCallError? error,
  ) {
    _logger.fine(
      () =>
          'didPushIncomingCall handle: $handle displayName: $displayName video: $video'
          ' callId: $callId error: $error',
    );

    add(_CallPushEventIncoming(callId: callId, handle: handle, displayName: displayName, video: video, error: error));
  }

  @override
  Future<bool> performStartCall(
    String callId,
    CallkeepHandle handle,
    String? displayNameOrContactIdentifier,
    bool video,
  ) {
    return _perform(
      _CallPerformEvent.started(callId, handle: handle, displayName: displayNameOrContactIdentifier, video: video),
    );
  }

  @override
  Future<bool> performAnswerCall(String callId) => _perform(_CallPerformEvent.answered(callId));

  @override
  Future<bool> performEndCall(String callId) => _perform(_CallPerformEvent.ended(callId));

  @override
  Future<bool> performSetHeld(String callId, bool onHold) => _perform(_CallPerformEvent.setHeld(callId, onHold));

  @override
  Future<bool> performSetMuted(String callId, bool muted) => _perform(_CallPerformEvent.setMuted(callId, muted));

  @override
  Future<bool> performSendDTMF(String callId, String key) => _perform(_CallPerformEvent.sentDTMF(callId, key));

  @override
  Future<bool> performAudioDeviceSet(String callId, CallkeepAudioDevice device) {
    return _perform(_CallPerformEvent.audioDeviceSet(callId, CallAudioDevice.fromCallkeep(device)));
  }

  @override
  Future<bool> performAudioDevicesUpdate(String callId, List<CallkeepAudioDevice> devices) {
    return _perform(_CallPerformEvent.audioDevicesUpdate(callId, devices.map(CallAudioDevice.fromCallkeep).toList()));
  }

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

  Future<bool> _perform(_CallPerformEvent callPerformEvent) {
    _pendingPerformEvents.add(callPerformEvent);
    add(callPerformEvent);
    return callPerformEvent.future.whenComplete(() {
      _pendingPerformEvents.remove(callPerformEvent);
    });
  }
}
