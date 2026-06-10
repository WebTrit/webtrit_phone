part of 'call_bloc.dart';

@freezed
class CallState with _$CallState {
  const CallState({
    this.callServiceState = const CallServiceState(),
    this.currentAppLifecycleState,
    this.linesCount = 0,
    this.activeCalls = const [],
    this.minimized,
    this.audioDevice,
    this.availableAudioDevices = const [],
    this.selectedCallId,
  });

  @override
  final CallServiceState callServiceState;

  @override
  final AppLifecycleState? currentAppLifecycleState;

  @override
  final int linesCount;

  @override
  final List<ActiveCall> activeCalls;

  @override
  final bool? minimized;

  @override
  final CallAudioDevice? audioDevice;

  @override
  final List<CallAudioDevice> availableAudioDevices;

  /// The call the user has explicitly focused (e.g. tapped in the call list).
  ///
  /// `null` means no explicit selection - consumers fall back to the derived
  /// [ActiveCallIterableExtension.current]. This is the foundation for the
  /// list-based call screen, where one bottom action area acts on the focused
  /// call. Always read it through [focusedCall], which clamps a stale id back
  /// to `current`.
  @override
  final String? selectedCallId;

  CallStatus get status => callServiceState.status;

  /// The call the action area should act on: the explicitly [selectedCallId]
  /// when it still maps to a live call, otherwise the derived `current`.
  ///
  /// Returns `null` only when there are no active calls. Behavior is identical
  /// to `activeCalls.current` until something dispatches
  /// [CallControlEvent.callSelected], so this is a no-op seam for existing UI.
  ActiveCall? get focusedCall {
    if (activeCalls.isEmpty) return null;
    final selected = selectedCallId == null ? null : retrieveActiveCall(selectedCallId!);
    return selected ?? activeCalls.current;
  }

  /// Indicates that the handshake phase has completed and registration status is available.
  bool get isHandshakeEstablished => callServiceState.registration?.status != null;

  /// Indicates that the signaling connection to the server is successfully established.
  bool get isSignalingEstablished => callServiceState.signalingClientStatus.isConnect;

  /// True when every precondition for placing an outgoing call is satisfied:
  ///   - the signaling client is connected;
  ///   - the handshake has been received;
  ///   - the SIP REGISTER has succeeded;
  ///   - the line config has arrived (`linesCount > 0`).
  ///
  /// Used to decide whether a dispatched outgoing call can proceed to INVITE
  /// or must be parked in [CallProcessingStatus.outgoingConnectingToSignaling]
  /// while the missing precondition resolves.
  bool get isReadyForOutgoingCall =>
      isHandshakeEstablished &&
      isSignalingEstablished &&
      callServiceState.registration?.status.isRegistered == true &&
      linesCount > 0;

  /// Computes the [LinesState] that reflects the current lines and active calls.
  ///
  /// Returns [LinesState.blank] when [linesCount] is 0 and the signaling
  /// handshake has not yet been received ([isHandshakeEstablished] is false),
  /// keeping [CallRoutingCubit] in the unready state until server config arrives.
  ///
  /// After the handshake, [linesCount] == 0 is a valid server configuration
  /// (no main lines), so a real [LinesState] is computed to allow guest-line calls.
  LinesState toLinesState() {
    if (linesCount == 0 && !isHandshakeEstablished) return LinesState.blank();

    final List<LineState> mainLinesState = [];
    for (var i = 0; i < linesCount; i++) {
      final lineCall = activeCalls.firstWhereOrNull((e) => e.line == i);
      if (lineCall != null) {
        mainLinesState.add(LineState.inUse(callId: lineCall.callId));
      } else {
        mainLinesState.add(LineState.idle());
      }
    }
    final guestLineCall = activeCalls.firstWhereOrNull((e) => e.line == null);
    final guestLineState = guestLineCall != null ? LineState.inUse(callId: guestLineCall.callId) : LineState.idle();
    return LinesState(mainLines: mainLinesState, guestLine: guestLineState);
  }

  static int? lastUsedLine;

  /// Retrieves an idle line number with rotation
  int? retrieveIdleLine() {
    final linesList = List.generate(linesCount, (index) => index)
      ..sort((a, b) {
        if (a == lastUsedLine) return 1;
        if (b == lastUsedLine) return -1;
        return 0;
      });

    final idleLines = linesList.where((line) => !activeCalls.any((activeCall) => activeCall.line == line));
    final choosenLine = idleLines.firstOrNull;
    if (choosenLine != null) {
      lastUsedLine = choosenLine;
    }
    return choosenLine;
  }

  /// Picks a main line for an outgoing call.
  ///
  /// Three outcomes:
  ///   - real line index when an idle main line is available;
  ///   - [_kUndefinedLine] when `linesCount == 0` (cold start: the signaling
  ///     handshake has not arrived yet, so line config is unknown - the
  ///     caller should park the call and resolve the real line once lines
  ///     are known);
  ///   - `null` when lines are known but all main lines are in use - the
  ///     caller should fail with [GeneralUnableToCallNotification].
  int? pickOutgoingMainLine() {
    final idle = retrieveIdleLine();
    if (idle != null) return idle;
    if (linesCount == 0) return _kUndefinedLine;
    return null;
  }

  CallDisplay get display {
    if (activeCalls.isEmpty) {
      if (minimized == false) {
        return CallDisplay.noneScreen;
      } else {
        return CallDisplay.none;
      }
    } else {
      if (minimized == true) {
        return CallDisplay.overlay;
      } else {
        return CallDisplay.screen;
      }
    }
  }

  bool get isActive => activeCalls.isNotEmpty;

  bool get isVoiceChat => activeCalls.current.video == false;

  bool get isBlingTransferInitiated => activeCalls.blindTransferInitiated != null;

  bool get shouldListenToProximity => isActive && isVoiceChat && minimized != true;

  List<ActiveCall> callsToTerminate(Set<String> activeLineCallIds) {
    final result = <ActiveCall>[];
    for (final activeCall in activeCalls) {
      if (activeLineCallIds.contains(activeCall.callId)) continue;
      if (activeCall.direction == CallDirection.outgoing &&
          activeCall.acceptedTime == null &&
          activeCall.hungUpTime == null &&
          activeCall.processingStatus.isPreOfferSent) {
        continue;
      }
      result.add(activeCall);
    }
    return result;
  }

  ActiveCall? retrieveActiveCall(String callId) {
    for (var activeCall in activeCalls) {
      if (activeCall.callId == callId) {
        return activeCall;
      }
    }
    return null;
  }

  FutureOr<T>? performOnActiveCall<T>(String callId, FutureOr<T>? Function(ActiveCall element) perform) {
    for (var activeCall in activeCalls) {
      if (activeCall.callId == callId) {
        return perform(activeCall);
      }
    }
    return null;
  }

  CallState copyWithMappedActiveCalls(ActiveCall Function(ActiveCall element) map) {
    final activeCalls = this.activeCalls.map(map).toList();
    return copyWith(activeCalls: activeCalls);
  }

  CallState copyWithMappedActiveCall(String callId, ActiveCall Function(ActiveCall element) map) {
    final activeCalls = this.activeCalls.map((activeCall) {
      if (activeCall.callId == callId) {
        return map(activeCall);
      } else {
        return activeCall;
      }
    }).toList();
    return copyWith(activeCalls: activeCalls);
  }

  CallState copyWithPushActiveCall(ActiveCall activeCall) {
    return copyWith(
      activeCalls: [...activeCalls, activeCall],
      // A new ringing incoming call demands a decision, so it grabs the focus;
      // any other call keeps the user's selection.
      selectedCallId: activeCall.isIncoming && !activeCall.wasAccepted ? activeCall.callId : selectedCallId,
    );
  }

  CallState copyWithPopActiveCall(String callId) {
    final activeCalls = this.activeCalls.where((activeCall) {
      return activeCall.callId != callId;
    }).toList();
    // When the focused call ends, prefer the next ringing incoming call (it
    // still demands a decision); otherwise clear so [focusedCall] falls back
    // to `current`. An unrelated selection is kept as is.
    final selectedCallId = this.selectedCallId == callId
        ? activeCalls.firstWhereOrNull((call) => call.isIncoming && !call.wasAccepted)?.callId
        : this.selectedCallId;
    return copyWith(
      activeCalls: activeCalls,
      minimized: activeCalls.isEmpty ? null : minimized,
      selectedCallId: selectedCallId,
    );
  }

  /// Focuses the call [callId] when it maps to a live call; otherwise returns
  /// the state unchanged. Keeps [selectedCallId] clamped to an existing call.
  CallState copyWithSelectedCall(String callId) {
    if (retrieveActiveCall(callId) == null) return this;
    return copyWith(selectedCallId: callId);
  }

  /// Ids of every active call except [callId], in list order. Pure data query;
  /// the event layer (see the combined-action plans on [CallControlEvent])
  /// turns these into the primitive events to dispatch.
  List<String> otherCallIds(String callId) => [
    for (final call in activeCalls)
      if (call.callId != callId) call.callId,
  ];

  /// Ids of every other answered, not-yet-held call - the ones that must be
  /// put on hold before resuming [callId] so only one call stays live. Pure
  /// data query for the event-layer plans.
  List<String> otherCallIdsToHold(String callId) => [
    for (final call in activeCalls)
      if (call.callId != callId && call.wasAccepted && !call.held) call.callId,
  ];
}

@freezed
class ActiveCall with _$ActiveCall implements CallEntry {
  ActiveCall({
    required this.direction,
    required this.line,
    required this.callId,
    required this.handle,
    required this.createdTime,
    required this.video,
    required this.processingStatus,
    this.frontCamera = true,
    this.held = false,
    this.muted = false,
    this.updating = false,
    this.incomingOffer,
    this.displayName,
    this.fromReferId,
    this.fromReplaces,
    this.fromNumber,
    this.acceptedTime,
    this.hungUpTime,
    this.transfer,
    this.failure,
    this.localStream,
    this.remoteStream,
    this.speakerOnBeforeMinimize,
    this.iceCandidates = const [],
    this.iceConnectionIssue,
    this.networkQuality,
  });

  @override
  final CallDirection direction;

  @override
  final int? line;

  @override
  final String callId;

  @override
  final CallkeepHandle handle;

  @override
  final DateTime createdTime;

  /// Whether the user has explicitly enabled the local camera for this call.
  ///
  /// This is local camera intent, not remote SDP capability. It is set only by
  /// user actions ([CallControlEvent.cameraEnabled]) and initial media setup.
  /// Never derive it from a remote SDP offer — that is what [remoteVideo] is for.
  @override
  final bool video;

  @override
  final CallProcessingStatus processingStatus;

  @override
  final bool? frontCamera;

  @override
  final bool held;

  @override
  final bool muted;

  @override
  final bool updating;

  @override
  final JsepValue? incomingOffer;

  @override
  final String? displayName;

  @override
  final String? fromReferId;

  @override
  final String? fromReplaces;

  @override
  final String? fromNumber;

  @override
  final DateTime? acceptedTime;

  @override
  final DateTime? hungUpTime;

  @override
  final Transfer? transfer;

  @override
  final Object? failure;

  @override
  final MediaStream? localStream;

  @override
  final MediaStream? remoteStream;

  @override
  final bool? speakerOnBeforeMinimize;

  @override
  final List<RTCIceCandidate> iceCandidates;

  @override
  final IceConnectionIssue? iceConnectionIssue;

  /// Transient media-degradation indicator from Janus `slowlink` events.
  /// Null when the media is healthy; auto-cleared once slowlink events stop.
  @override
  final CallNetworkQuality? networkQuality;

  @override
  bool get isIncoming => direction == CallDirection.incoming;

  @override
  bool get isOutgoing => direction == CallDirection.outgoing;

  @override
  bool get wasAccepted => acceptedTime != null;

  @override
  bool get wasHungUp => hungUpTime != null;

  /// Whether the remote peer is expected to send (or is already sending) video.
  ///
  /// Returns `true` when the remote stream contains at least one video track
  /// (confirmed by WebRTC). Falls back to the logical [video] flag when the
  /// stream is absent or audio-only — this covers the window between the SDP
  /// negotiation completing and the first video frame arriving, which is
  /// especially common after a glare-resolution rollback where [onAddStream]
  /// does not re-fire for the updated stream and only [onAddTrack] signals the
  /// new video track.
  bool get remoteVideo => (remoteStream?.getVideoTracks().isNotEmpty ?? false) || video;

  /// Indicates whether the [localStream] contains at least one video track.
  ///
  /// This checks for the physical existence of a track in the stream, ignoring its
  /// current [MediaStreamTrack.enabled] state. This distinction is crucial for
  /// correct state comparison, as tracks are mutable objects.
  bool get hasLocalVideoTrack => localStream?.getVideoTracks().isNotEmpty ?? false;

  /// Determines whether the local camera is effectively active and should be displayed.
  ///
  /// This is the primary flag for UI visibility. It evaluates to `true` only if:
  /// 1. The user has explicitly enabled video (logical state [video] is `true`).
  /// 2. A valid video track exists in the [localStream] (technical state [hasLocalVideoTrack] is `true`).
  bool get isCameraActive =>
      video && hasLocalVideoTrack && localStream?.getVideoTracks().any((track) => track.enabled) == true;
}

extension ActiveCallIterableExtension<T extends ActiveCall> on Iterable<T> {
  T get current => lastWhere((activeCall) => !activeCall.held, orElse: () => last);

  List<T> get nonCurrent => where((activeCall) => activeCall != current).toList();

  T? get blindTransferInitiated => firstWhereOrNull((activeCall) => activeCall.transfer is BlindTransferInitiated);

  /// The most concerning media-degradation indicator across all calls, for the
  /// global toolbar status line: an active (non-recovered) warning beats a
  /// recovered confirmation, then the higher severity wins. `null` when every
  /// stream is healthy.
  CallNetworkQuality? get worstNetworkQuality {
    CallNetworkQuality? worst;
    for (final call in this) {
      final quality = call.networkQuality;
      if (quality == null) continue;
      int score(CallNetworkQuality q) => q.recovered ? -1 : q.severity.index;
      if (worst == null || score(quality) > score(worst)) worst = quality;
    }
    return worst;
  }

  /// The first real media failure across all calls; failures take precedence
  /// over degradation warnings on the toolbar status line.
  IceConnectionIssue? get firstIceConnectionIssue =>
      firstWhereOrNull((activeCall) => activeCall.iceConnectionIssue != null)?.iceConnectionIssue;
}
