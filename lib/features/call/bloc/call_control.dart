part of 'call_bloc.dart';

extension _CallControl on CallBloc {
  // processing call control events

  Future<void> _onCallControlEvent(CallControlEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallControlEventStarted() => __onCallControlEventStarted(event, emit),
      _CallControlEventAnswered() => __onCallControlEventAnswered(event, emit),
      _CallControlEventEnded() => __onCallControlEventEnded(event, emit),
      _CallControlEventSetHeld() => __onCallControlEventSetHeld(event, emit),
      _CallControlEventSetMuted() => __onCallControlEventSetMuted(event, emit),
      _CallControlEventSentDTMF() => __onCallControlEventSentDTMF(event, emit),
      _CallControlEventCameraSwitched() => _onCallControlEventCameraSwitched(event, emit),
      _CallControlEventCameraEnabled() => _onCallControlEventCameraEnabled(event, emit),
      _CallControlEventAudioDeviceSet() => _onCallControlEventAudioDeviceSet(event, emit),
      _CallControlEventFailureApproved() => _onCallControlEventFailureApproved(event, emit),
      _CallControlEventBlindTransferInitiated() => _onCallControlEventBlindTransferInitiated(event, emit),
      _CallControlEventAttendedTransferInitiated() => _onCallControlEventAttendedTransferInitiated(event, emit),
      _CallControlEventBlindTransferSubmitted() => _onCallControlEventBlindTransferSubmitted(event, emit),
      _CallControlEventAttendedTransferSubmitted() => _onCallControlEventAttendedTransferSubmitted(event, emit),
      _CallControlEventAttendedRequestApproved() => _onCallControlEventAttendedRequestApproved(event, emit),
      _CallControlEventAttendedRequestDeclined() => _onCallControlEventAttendedRequestDeclined(event, emit),
    };
  }

  Future<void> __onCallControlEventStarted(_CallControlEventStarted event, Emitter<CallState> emit) async {
    if (state.callServiceState.registration?.status.isRegistered != true) {
      _logger.info('__onCallControlEventStarted account is not registered');
      submitNotification(CallWhileUnregisteredNotification());
      return;
    }

    int? line;
    if (event.fromNumber != null) {
      line = null;
    } else {
      line = state.retrieveIdleLine();
      if (line == null) {
        _logger.info('__onCallControlEventStarted no idle line');
        submitNotification(const CallUndefinedLineNotification());
        return;
      }
    }

    /// If there is an active call, the call should be put on hold before making a new call.
    /// Or it will be ended automatically by platform (via callkeep:performEndAction).
    await Future.forEach(state.activeCalls, (ActiveCall activeCall) async {
      final shouldHold = activeCall.held == false;
      if (shouldHold) await callkeep.setHeld(activeCall.callId, onHold: true);
    });

    final callId = WebtritSignalingClient.generateCallId();
    final contactName = await contactNameResolver.resolveWithNumber(event.handle.value);
    final displayName = contactName ?? event.displayName;

    final newCall = ActiveCall(
      direction: CallDirection.outgoing,
      line: line,
      callId: callId,
      handle: event.handle,
      displayName: displayName,
      video: event.video,
      createdTime: clock.now(),
      processingStatus: CallProcessingStatus.outgoingCreated,
      fromReplaces: event.replaces,
      fromNumber: event.fromNumber,
    );

    emit(state.copyWithPushActiveCall(newCall).copyWith(minimized: false));

    final callkeepError = await callkeep.startCall(
      callId,
      event.handle,
      displayNameOrContactIdentifier: displayName,
      hasVideo: event.video,
      proximityEnabled: !event.video,
    );

    if (callkeepError != null) {
      if (callkeepError == CallkeepCallRequestError.emergencyNumber) {
        final Uri telLaunchUri = Uri(scheme: 'tel', path: event.handle.value);
        launchUrl(telLaunchUri);
      } else if (callkeepError == CallkeepCallRequestError.selfManagedPhoneAccountNotRegistered) {
        _logger.warning('__onCallControlEventStarted selfManagedPhoneAccountNotRegistered');
        submitNotification(const CallErrorRegisteringSelfManagedPhoneAccountNotification());
      } else {
        _logger.warning('__onCallControlEventStarted callkeepError: $callkeepError');
        onDiagnosticReportRequested(callId, callkeepError);
      }
      emit(state.copyWithPopActiveCall(callId));

      return;
    }
  }

  /// Submitting the answer intent to system when answer button is pressed from app ui
  ///
  /// quick shortcut:
  /// call placed in [__onCallSignalingEventIncoming] or [__onCallPushEventIncoming]
  /// continues in [__onCallPerformEventAnswered]
  Future<void> __onCallControlEventAnswered(_CallControlEventAnswered event, Emitter<CallState> emit) async {
    final call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    // Prevents event doubling and race conditions
    final canSubmitAnswer = switch (call.processingStatus) {
      CallProcessingStatus.incomingFromPush => true,
      CallProcessingStatus.incomingFromOffer => true,
      _ => false,
    };

    if (canSubmitAnswer == false) {
      _logger.info('__onCallControlEventAnswered: skipping due stale status: ${call.processingStatus}');
      return;
    }

    emit(
      state.copyWithMappedActiveCall(
        event.callId,
        (call) => call.copyWith(processingStatus: CallProcessingStatus.incomingSubmittedAnswer),
      ),
    );

    final error = await callkeep.answerCall(event.callId);
    if (error != null) _logger.warning('__onCallControlEventAnswered error: $error');
  }

  Future<void> __onCallControlEventEnded(_CallControlEventEnded event, Emitter<CallState> emit) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(processingStatus: CallProcessingStatus.disconnecting);
      }),
    );

    final error = await callkeep.endCall(event.callId);
    // Handle the case where the local connection is no longer available,
    // sending the call completion event directly to the signaling.
    if (error == CallkeepCallRequestError.unknownCallUuid) {
      add(_CallPerformEvent.ended(event.callId));
    }
    if (error != null) {
      _logger.warning('__onCallControlEventEnded error: $error');
    }
  }

  Future<void> __onCallControlEventSetHeld(_CallControlEventSetHeld event, Emitter<CallState> emit) async {
    final error = await callkeep.setHeld(event.callId, onHold: event.onHold);
    if (error != null) {
      _logger.warning('__onCallControlEventSetHeld error: $error');
    }
  }

  Future<void> __onCallControlEventSetMuted(_CallControlEventSetMuted event, Emitter<CallState> emit) async {
    final error = await callkeep.setMuted(event.callId, muted: event.muted);
    if (error != null) {
      _logger.warning('__onCallControlEventSetMuted error: $error');
    }
  }

  Future<void> __onCallControlEventSentDTMF(_CallControlEventSentDTMF event, Emitter<CallState> emit) async {
    final error = await callkeep.sendDTMF(event.callId, event.key);
    if (error != null) {
      _logger.warning('__onCallControlEventSentDTMF error: $error');
    }
  }

  Future<void> _onCallControlEventCameraSwitched(_CallControlEventCameraSwitched event, Emitter<CallState> emit) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(frontCamera: null);
      }),
    );
    final frontCamera = await state.performOnActiveCall(event.callId, (activeCall) {
      final videoTrack = activeCall.localStream?.getVideoTracks()[0];
      if (videoTrack != null) {
        return Helper.switchCamera(videoTrack);
      }
    });
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(frontCamera: frontCamera);
      }),
    );
  }

  /// Enables or disables the camera for the active call, using local track enable state.
  ///
  /// If its audiocall, try to upgrade to videocal using renegotiation
  /// by adding the tracks to the peer connection.
  /// after success [_createPeerConnection].onRenegotiationNeeded will fired accordingly to webrtc state
  /// then [__onCallSignalingEventAccepted] will be called as acknowledge of [UpdateRequest] with new remote jsep.
  ///
  /// **Mute Implementation Note:**
  /// Currently, this method implements a **"Soft Mute"** strategy by toggling
  /// [MediaStreamTrack.enabled] instead of a **"Hard Mute"** (changing
  /// [RTCRtpTransceiver] direction to [TransceiverDirection.RecvOnly]).
  ///
  /// **Reason:** It was observed that switching to `RecvOnly` causes the server
  /// to stop sending the *incoming* video stream to the client.
  /// This behavior suggests that the server infrastructure might interpret the cessation
  /// of outgoing RTP packets as a connection timeout or does not correctly handle
  /// the session modification in the current configuration. "Soft Mute" avoids this
  /// by keeping the channel active (sending black/empty frames).
  Future<void> _onCallControlEventCameraEnabled(_CallControlEventCameraEnabled event, Emitter<CallState> emit) async {
    final activeCall = state.retrieveActiveCall(event.callId);
    if (activeCall == null) return;

    final localStream = activeCall.localStream;
    if (localStream == null) return;

    final currentVideoTrack = localStream.getVideoTracks().firstOrNull;
    if (currentVideoTrack != null) {
      currentVideoTrack.enabled = event.enabled;
      emit(state.copyWithMappedActiveCall(event.callId, (call) => call.copyWith(video: event.enabled)));
      return;
    }

    final peerConnection = await _peerConnectionManager.retrieve(event.callId);
    if (peerConnection == null) return;

    try {
      // Capture new audio and video pair together to avoid time sync issues
      // and avoid storing separate audio and video tracks to control them on mute, camera switch etc
      final newLocalStream = await userMediaBuilder.build(video: true, frontCamera: activeCall.frontCamera);

      final newAudioTrack = newLocalStream.getAudioTracks().firstOrNull;
      final newVideoTrack = newLocalStream.getVideoTracks().firstOrNull;

      final senders = await peerConnection.getSenders();
      final audioSender = senders.firstWhereOrNull((s) => s.track?.kind == 'audio');
      final videoSender = senders.firstWhereOrNull((s) => s.track?.kind == 'video');

      /// Replace audio/video tracks using existing senders to avoid adding new m= lines
      ///
      /// Alternatively, you can use (remove || stop) + add tracks flow
      /// but it has weak support on infrastructure level:
      /// - second audio m= line causes problems with call recordings and music on hold
      /// - second video m= line causes empty video stream
      ///
      /// So for best compatibility, use existing senders and control them via .enabled or .replaceTrack
      if (audioSender != null && newAudioTrack != null) {
        await audioSender.replaceTrack(newAudioTrack);
      } else if (newAudioTrack != null) {
        final audioSenderResult = await peerConnection.safeAddTrack(newAudioTrack, newLocalStream);
        _checkSenderResult(audioSenderResult, 'audio');
      }

      if (videoSender != null && newVideoTrack != null) {
        await videoSender.replaceTrack(newVideoTrack);
      } else if (newVideoTrack != null) {
        final videoSenderResult = await peerConnection.safeAddTrack(newVideoTrack, newLocalStream);
        _checkSenderResult(videoSenderResult, 'video');
      }

      emit(
        state.copyWithMappedActiveCall(event.callId, (call) => call.copyWith(localStream: newLocalStream, video: true)),
      );

      await callkeep.reportUpdateCall(event.callId, hasVideo: true);
    } on UserMediaError catch (e) {
      _logger.warning('_onCallControlEventCameraEnabled cant enable: $e');
      submitNotification(const CallUserMediaErrorNotification());
    }
  }

  Future<void> _onCallControlEventAudioDeviceSet(_CallControlEventAudioDeviceSet event, Emitter<CallState> emit) async {
    await state.performOnActiveCall(event.callId, (activeCall) async {
      if (Platform.isAndroid) {
        callkeep.setAudioDevice(event.callId, event.device.toCallkeep());
      } else if (Platform.isIOS) {
        if (event.device.type == CallAudioDeviceType.speaker) {
          Helper.setSpeakerphoneOn(true);
        } else {
          Helper.setSpeakerphoneOn(false);
          final deviceId = event.device.id;
          if (deviceId != null) Helper.selectAudioInput(deviceId);
        }
      }
    });
  }

  Future<void> _onCallControlEventFailureApproved(
    _CallControlEventFailureApproved event,
    Emitter<CallState> emit,
  ) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(failure: null);
      }),
    );
  }

  // procession call screen events

  Future<void> _onCallScreenEvent(CallScreenEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallScreenEventDidPush() => __onCallScreenEventDidPush(event, emit),
      _CallScreenEventDidPop() => __onCallScreenEventDidPop(event, emit),
    };
  }

  Future<void> __onCallScreenEventDidPush(_CallScreenEventDidPush event, Emitter<CallState> emit) async {
    final hasActiveCalls = state.activeCalls.isNotEmpty;
    var newState = state.copyWith(minimized: false);

    if (hasActiveCalls) {
      newState = newState.copyWithMappedActiveCalls((activeCall) {
        final transfer = activeCall.transfer;
        if (transfer != null && transfer is BlindTransferInitiated) {
          return activeCall.copyWith(transfer: null);
        } else {
          return activeCall;
        }
      });

      emit(newState);

      final currentCall = state.activeCalls.current;

      await callkeep.reportUpdateCall(currentCall.callId, proximityEnabled: state.shouldListenToProximity);

      if (currentCall.speakerOnBeforeMinimize == true) {
        add(CallControlEvent.audioDeviceSet(currentCall.callId, state.availableAudioDevices.getSpeaker));
      }
    } else {
      _logger.warning('__onCallScreenEventDidPush: activeCalls is empty');
    }
  }

  Future<void> __onCallScreenEventDidPop(_CallScreenEventDidPop event, Emitter<CallState> emit) async {
    final shouldMinimize = state.activeCalls.isNotEmpty;
    _logger.info('__onCallScreenEventDidPop: shouldMinimize: $shouldMinimize');

    if (shouldMinimize) {
      final currentCallId = state.activeCalls.current.callId;
      final isSpeakerOn = state.audioDevice?.type == CallAudioDeviceType.speaker;

      emit(
        state
            .copyWithMappedActiveCall(currentCallId, (call) {
              return call.copyWith(speakerOnBeforeMinimize: isSpeakerOn);
            })
            .copyWith(minimized: true),
      );

      await callkeep.reportUpdateCall(currentCallId, proximityEnabled: state.shouldListenToProximity);
    }
  }
}
