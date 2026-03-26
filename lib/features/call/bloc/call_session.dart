part of 'call_bloc.dart';

extension _CallSession on CallBloc {
  // processing call perform events

  Future<void> _onCallPerformEvent(_CallPerformEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallPerformEventStarted() => __onCallPerformEventStarted(event, emit),
      _CallPerformEventAnswered() => __onCallPerformEventAnswered(event, emit),
      _CallPerformEventEnded() => __onCallPerformEventEnded(event, emit),
      _CallPerformEventSetHeld() => __onCallPerformEventSetHeld(event, emit),
      _CallPerformEventSetMuted() => __onCallPerformEventSetMuted(event, emit),
      _CallPerformEventSentDTMF() => __onCallPerformEventSentDTMF(event, emit),
      _CallPerformEventAudioDeviceSet() => __onCallPerformEventAudioDeviceSet(event, emit),
      _CallPerformEventAudioDevicesUpdate() => __onCallPerformEventAudioDevicesUpdate(event, emit),
    };
  }

  Future<void> __onCallPerformEventStarted(_CallPerformEventStarted event, Emitter<CallState> emit) async {
    if (await state.performOnActiveCall(event.callId, (activeCall) => activeCall.line != _kUndefinedLine) != true) {
      event.fail();

      emit(state.copyWithPopActiveCall(event.callId));

      submitNotification(const CallUndefinedLineNotification());
      return;
    }

    ///
    /// Ensuring that the signaling client is connected before attempting to make an outgoing call
    ///

    var currentState = state;

    // Attempt to wait for the desired signaling client status within the signaling client connection timeout period
    if (!currentState.isHandshakeEstablished || !currentState.isSignalingEstablished) {
      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingConnectingToSignaling);
        }),
      );

      currentState = await stream
          .firstWhere((next) {
            // Stop waiting as soon as signaling is fully ready or has failed;
            // avoids blocking for the full timeout on a definitive failure.
            final signalingReady = next.isHandshakeEstablished && next.isSignalingEstablished;
            final signalingFailed = next.callServiceState.signalingClientStatus.isFailure;
            return signalingReady || signalingFailed;
          }, orElse: () => state)
          .timeout(kSignalingClientConnectionTimeout, onTimeout: () => state);
      if (isClosed) return;
    }

    // If the signaling client is not connected, hung up the call and notify user
    if (!currentState.isSignalingEstablished) {
      event.fail();

      // Notice that the tube was already hung up to avoid sending an extra event to the server
      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(hungUpTime: clock.now());
        }),
      );

      // Remove local connection
      await callkeep.endCall(event.callId);

      submitNotification(const CallWhileOfflineNotification());
      return;
    }

    // If registration status is not registered after signaling is established, notify user
    if (currentState.callServiceState.registration?.status.isRegistered != true) {
      _logger.info('__onCallPerformEventStarted account is not registered');
      submitNotification(CallWhileUnregisteredNotification());

      event.fail();
      return;
    }

    ///
    /// Initializing media streams
    ///
    ///
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingInitializingMedia);
      }),
    );

    late final MediaStream localStream;
    try {
      localStream = await userMediaBuilder.build(
        video: event.video,
        frontCamera: state.retrieveActiveCall(event.callId)?.frontCamera,
      );
      event.fulfill();

      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(localStream: localStream);
        }),
      );
    } catch (e, stackTrace) {
      _logger.warning('__onCallPerformEventStarted _getUserMedia', e, stackTrace);

      event.fail();

      _peerConnectionManager.completeError(event.callId, e, stackTrace);

      emit(state.copyWithPopActiveCall(event.callId));

      submitNotification(const CallUserMediaErrorNotification());
      return;
    }

    ///
    /// Initializing peer connection and sending outgoing offer
    ///
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingOfferPreparing);
      }),
    );

    try {
      final activeCall = state.retrieveActiveCall(event.callId);
      final peerConnection = await _createPeerConnection(event.callId, activeCall!.line);
      await Future.wait(localStream.getTracks().map((track) => peerConnection.addTrack(track, localStream)));

      final localDescription = await peerConnection.createOffer({});
      sdpMunger?.apply(localDescription);
      _logger.infoPretty(localDescription.sdp, tag: '__onCallPerformEventStarted');

      // Need to initiate outgoing call before set localDescription to avoid races
      // between [OutgoingCallRequest] and [IceTrickleRequest]s.
      await _signalingClient?.execute(
        OutgoingCallRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          from: activeCall.fromNumber,
          callId: activeCall.callId,
          number: activeCall.handle.normalizedValue(),
          jsep: localDescription.toMap(),
          referId: activeCall.fromReferId,
          replaces: activeCall.fromReplaces,
        ),
      );

      // In other cases setLocalDescription is called first; here it's delayed to avoid ICE race
      await peerConnection.setLocalDescription(localDescription);

      _peerConnectionManager.complete(event.callId, peerConnection);

      await callkeep.reportConnectingOutgoingCall(event.callId);

      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingOfferSent);
        }),
      );
    } catch (e, stackTrace) {
      // Handles exceptions during the outgoing call perform event, sends a notification, stops the ringtone, and completes the peer connection with an error.
      // The specific error "Error setting ICE locally" indicates an issue with ICE (Interactive Connectivity Establishment) negotiation in the WebRTC signaling process.
      callErrorReporter.handle(e, stackTrace, '__onCallPerformEventStarted error:');

      await _stopRingbackSound();
      _peerConnectionManager.completeError(event.callId, e, stackTrace);

      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  /// Performs answer after incoming call accepted by ui call controlls or native controls
  /// quick shortcuts:
  /// ui control event - [__onCallControlEventAnswered]
  /// after success - [__onCallSignalingEventAccepted]
  /// jsep processing in - [__onCallSignalingEventIncoming]
  Future<void> __onCallPerformEventAnswered(_CallPerformEventAnswered event, Emitter<CallState> emit) async {
    event.fulfill();

    ActiveCall? call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    // Prevent performing double answer and race conditions
    //
    // Main case happens when the call is answered from background(ios) or from the lock screen using navite controls
    // In such case performAnswered called emidiately and after signaling initialized via
    // [IncomingEvent] + (callAlreadyAnswered == true) > [callControlAnswered] > [performAnswered] called again
    //
    final canPerformAnswer = switch (call.processingStatus) {
      CallProcessingStatus.incomingFromPush => true,
      CallProcessingStatus.incomingFromOffer => true,
      CallProcessingStatus.incomingSubmittedAnswer => true,
      _ => false,
    };

    if (canPerformAnswer == false) {
      _logger.info('__onCallPerformEventAnswered: skipping due stale status: ${call.processingStatus}');
      return;
    }

    emit(
      state.copyWithMappedActiveCall(event.callId, (call) {
        return call.copyWith(processingStatus: CallProcessingStatus.incomingPerformingStarted);
      }),
    );

    try {
      /// Prevent performing answer without offer
      ///
      /// Main case happens when the call is answered from push event while signaling is disconnected
      /// and main [IncomingEvent] with offer wasnt received yet
      ///
      if (call.incomingOffer == null) {
        _logger.info('__onCallPerformEventAnswered: wait for offer');

        await stream
            .firstWhere((s) {
              final activeCall = s.retrieveActiveCall(event.callId);
              return activeCall?.incomingOffer != null;
            })
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                throw TimeoutException('Timed out waiting for offer');
              },
            );

        call = state.retrieveActiveCall(event.callId)!;
      }
      final offer = call.incomingOffer!;

      emit(
        state.copyWithMappedActiveCall(event.callId, (call) {
          return call.copyWith(processingStatus: CallProcessingStatus.incomingInitializingMedia);
        }),
      );

      final localStream = await userMediaBuilder.build(video: offer.hasVideo, frontCamera: call.frontCamera);
      final peerConnection = await _createPeerConnection(event.callId, call.line);
      await Future.forEach(localStream.getTracks(), (t) => peerConnection.addTrack(t, localStream));

      emit(
        state.copyWithMappedActiveCall(event.callId, (call) {
          return call.copyWith(localStream: localStream, processingStatus: CallProcessingStatus.incomingAnswering);
        }),
      );

      final remoteDescription = offer.toDescription();
      sdpSanitizer?.apply(remoteDescription);
      await peerConnection.setRemoteDescription(remoteDescription);
      final localDescription = await peerConnection.createAnswer({});
      sdpMunger?.apply(localDescription);

      // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
      // localDescription should be set before sending the answer to transition into stable state.
      await peerConnection.setLocalDescription(localDescription).catchError((e) => throw SDPConfigurationError(e));

      await _signalingClient?.execute(
        AcceptRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: call.line,
          callId: call.callId,
          jsep: localDescription.toMap(),
        ),
      );

      _peerConnectionManager.complete(event.callId, peerConnection);
    } catch (e, stackTrace) {
      _peerConnectionManager.completeError(event.callId, e, stackTrace);
      add(_ResetStateEvent.completeCall(event.callId));

      _addToRecents(call!);

      final declineId = WebtritSignalingClient.generateTransactionId();
      final declineRequest = DeclineRequest(transaction: declineId, line: call.line, callId: call.callId);
      _signalingClient?.execute(declineRequest).ignore();

      callErrorReporter.handle(e, stackTrace, '__onCallPerformEventAnswered error:');
    }
  }

  Future<void> __onCallPerformEventEnded(_CallPerformEventEnded event, Emitter<CallState> emit) async {
    // Condition occur when the user interacts with a push notification before signaling is properly initialized.
    // In this case, the CallKeep method "reportNewIncomingCall" may return callIdAlreadyTerminated.
    if (state.retrieveActiveCall(event.callId)?.line == _kUndefinedLine) {
      add(_ResetStateEvent.completeCall(event.callId));
      return;
    }

    if (state.retrieveActiveCall(event.callId)?.wasHungUp == true) {
      // TODO: There's an issue where the user might have already ended the call, but the active call screen remains visible.
      if (state.isActive) {
        emit(state.copyWithPopActiveCall(event.callId));
      }
      event.fail();
      return;
    }

    event.fulfill();

    await _stopRingbackSound();

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        final activeCallUpdated = activeCall.copyWith(hungUpTime: clock.now());
        _addToRecents(activeCallUpdated);
        return activeCallUpdated;
      }),
    );

    await state.performOnActiveCall(event.callId, (activeCall) async {
      if (activeCall.isIncoming && !activeCall.wasAccepted) {
        final declineRequest = DeclineRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId,
        );
        await _signalingClient?.execute(declineRequest).catchError((e, s) {
          callErrorReporter.handle(e, s, '__onCallPerformEventEnded declineRequest error');
        });
      } else {
        final hangupRequest = HangupRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId,
        );
        await _signalingClient?.execute(hangupRequest).catchError((e, s) {
          callErrorReporter.handle(e, s, '__onCallPerformEventEnded hangupRequest error');
        });
      }

      // Need to close peer connection after executing [HangupRequest]
      // to prevent "Simulate a "hangup" coming from the application"
      // because of "No WebRTC media anymore".
      await _peerConnectionManager.disposePeerConnection(activeCall.callId);
      await activeCall.localStream?.dispose();
    });

    emit(state.copyWithPopActiveCall(event.callId));
  }

  Future<void> __onCallPerformEventSetHeld(_CallPerformEventSetHeld event, Emitter<CallState> emit) async {
    event.fulfill();

    try {
      await state.performOnActiveCall(event.callId, (activeCall) {
        if (event.onHold) {
          return _signalingClient?.execute(
            HoldRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
              direction: HoldDirection.inactive,
            ),
          );
        } else {
          return _signalingClient?.execute(
            UnholdRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
            ),
          );
        }
      });

      emit(
        state.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(held: event.onHold);
        }),
      );
    } catch (e, stackTrace) {
      callErrorReporter.handle(e, stackTrace, '__onCallPerformEventSetHeld error');

      _peerConnectionManager.completeError(event.callId, e, stackTrace);

      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onCallPerformEventSetMuted(_CallPerformEventSetMuted event, Emitter<CallState> emit) async {
    event.fulfill();

    await state.performOnActiveCall(event.callId, (activeCall) {
      final audioTrack = activeCall.localStream?.getAudioTracks()[0];
      if (audioTrack != null) {
        Helper.setMicrophoneMute(event.muted, audioTrack);
      }
    });

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(muted: event.muted);
      }),
    );
  }

  Future<void> __onCallPerformEventSentDTMF(_CallPerformEventSentDTMF event, Emitter<CallState> emit) async {
    event.fulfill();

    await state.performOnActiveCall(event.callId, (activeCall) async {
      final peerConnection = await _peerConnectionManager.retrieve(event.callId);
      if (peerConnection == null) {
        _logger.warning('__onCallPerformEventSentDTMF: peerConnection is null - most likely some permissions issue');
      } else {
        final senders = await peerConnection.senders;
        try {
          final audioSender = senders.firstWhere((sender) {
            final track = sender.track;
            if (track != null) {
              return track.kind == 'audio';
            } else {
              return false;
            }
          });
          await audioSender.dtmfSender.insertDTMF(event.key);
        } on StateError catch (_) {
          _logger.warning('__onCallPerformEventSentDTMF can\'t send DTMF');
        }
      }
    });
  }

  Future<void> __onCallPerformEventAudioDeviceSet(
    _CallPerformEventAudioDeviceSet event,
    Emitter<CallState> emit,
  ) async {
    _logger.info('CallPerformEventAudioDeviceSet: ${event.device}');
    event.fulfill();
    emit(state.copyWith(audioDevice: event.device));
  }

  Future<void> __onCallPerformEventAudioDevicesUpdate(
    _CallPerformEventAudioDevicesUpdate event,
    Emitter<CallState> emit,
  ) async {
    _logger.info('CallPerformEventAudioDevicesUpdate: ${event.devices}');
    event.fulfill();
    emit(state.copyWith(availableAudioDevices: event.devices));
  }

  // processing peer connection events

  Future<void> _onPeerConnectionEvent(_PeerConnectionEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _PeerConnectionEventSignalingStateChanged() => __onPeerConnectionEventSignalingStateChanged(event, emit),
      _PeerConnectionEventConnectionStateChanged() => __onPeerConnectionEventConnectionStateChanged(event, emit),
      _PeerConnectionEventIceGatheringStateChanged() => __onPeerConnectionEventIceGatheringStateChanged(event, emit),
      _PeerConnectionEventIceConnectionStateChanged() => __onPeerConnectionEventIceConnectionStateChanged(event, emit),
      _PeerConnectionEventIceCandidateIdentified() => __onPeerConnectionEventIceCandidateIdentified(event, emit),
      _PeerConnectionEventStreamAdded() => __onPeerConnectionEventStreamAdded(event, emit),
      _PeerConnectionEventStreamRemoved() => __onPeerConnectionEventStreamRemoved(event, emit),
    };
  }

  Future<void> __onPeerConnectionEventSignalingStateChanged(
    _PeerConnectionEventSignalingStateChanged event,
    Emitter<CallState> emit,
  ) async {}

  Future<void> __onPeerConnectionEventConnectionStateChanged(
    _PeerConnectionEventConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {}

  Future<void> __onPeerConnectionEventIceGatheringStateChanged(
    _PeerConnectionEventIceGatheringStateChanged event,
    Emitter<CallState> emit,
  ) async {
    if (event.state == RTCIceGatheringState.RTCIceGatheringStateComplete) {
      try {
        await state.performOnActiveCall(event.callId, (activeCall) {
          if (!activeCall.wasHungUp) {
            final iceTrickleRequest = IceTrickleRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              candidate: null,
            );
            return _signalingClient?.execute(iceTrickleRequest);
          }
        });
      } catch (e, stackTrace) {
        callErrorReporter.handle(e, stackTrace, '__onPeerConnectionEventIceGatheringStateChanged error');

        _peerConnectionManager.completeError(event.callId, e, stackTrace);

        add(_ResetStateEvent.completeCall(event.callId));
      }
    }
  }

  Future<void> __onPeerConnectionEventIceConnectionStateChanged(
    _PeerConnectionEventIceConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {
    if (event.state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
      try {
        await state.performOnActiveCall(event.callId, (activeCall) async {
          final peerConnection = await _peerConnectionManager.retrieve(event.callId);
          if (peerConnection == null) {
            _logger.warning(
              '__onPeerConnectionEventIceConnectionStateChanged: peerConnection is null - most likely some state issue',
            );
          } else {
            await peerConnection.restartIce();
            final localDescription = await peerConnection.createOffer({});
            sdpMunger?.apply(localDescription);

            // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
            // localDescription should be set before sending the answer to transition into stable state.
            await peerConnection.setLocalDescription(localDescription);

            final updateRequest = UpdateRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
              jsep: localDescription.toMap(),
            );
            await _signalingClient?.execute(updateRequest);
          }
        });
      } catch (e, stackTrace) {
        callErrorReporter.handle(e, stackTrace, '__onPeerConnectionEventIceConnectionStateChanged error');

        _peerConnectionManager.completeError(event.callId, e, stackTrace);

        add(_ResetStateEvent.completeCall(event.callId));
      }
    }
  }

  Future<void> __onPeerConnectionEventIceCandidateIdentified(
    _PeerConnectionEventIceCandidateIdentified event,
    Emitter<CallState> emit,
  ) async {
    if (iceFilter?.filter(event.candidate) == true) {
      _logger.fine('__onPeerConnectionEventIceCandidateIdentified: skip by iceFilter');
      return;
    }

    try {
      await state.performOnActiveCall(event.callId, (activeCall) {
        if (!activeCall.wasHungUp) {
          final iceTrickleRequest = IceTrickleRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            candidate: event.candidate.toMap(),
          );
          return _signalingClient?.execute(iceTrickleRequest);
        }
      });
    } catch (e, stackTrace) {
      callErrorReporter.handle(e, stackTrace, '__onPeerConnectionEventIceCandidateIdentified error');

      _peerConnectionManager.completeError(event.callId, e, stackTrace);

      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onPeerConnectionEventStreamAdded(
    _PeerConnectionEventStreamAdded event,
    Emitter<CallState> emit,
  ) async {
    // Skip stub stream created by Janus on unidirectional video
    if (event.stream.id == 'janus') return;

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(remoteStream: event.stream);
      }),
    );
  }

  Future<void> __onPeerConnectionEventStreamRemoved(
    _PeerConnectionEventStreamRemoved event,
    Emitter<CallState> emit,
  ) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        final prevStream = activeCall.remoteStream;
        if (prevStream != null && prevStream.id == event.stream.id) {
          return activeCall.copyWith(remoteStream: null);
        }
        return activeCall;
      }),
    );
  }

  Future<RTCPeerConnection> _createPeerConnection(String callId, int? lineId) {
    return _peerConnectionManager.createPeerConnection(
      callId,
      observer: PeerConnectionObserver(
        onSignalingState: (state) => add(_PeerConnectionEvent.signalingStateChanged(callId, state)),
        onConnectionState: (state) => add(_PeerConnectionEvent.connectionStateChanged(callId, state)),
        onIceGatheringState: (state) => add(_PeerConnectionEvent.iceGatheringStateChanged(callId, state)),
        onIceConnectionState: (state) => add(_PeerConnectionEvent.iceConnectionStateChanged(callId, state)),
        onIceCandidate: (candidate) => add(_PeerConnectionEvent.iceCandidateIdentified(callId, candidate)),
        onAddStream: (stream) => add(_PeerConnectionEvent.streamAdded(callId, stream)),
        onRemoveStream: (stream) => add(_PeerConnectionEvent.streamRemoved(callId, stream)),
        onRenegotiationNeeded: (pc) {
          unawaited(
            _handleRenegotiationNeeded(
              callId,
              lineId,
              pc,
            ).catchError((e, s) => callErrorReporter.handle(e, s, '_createPeerConnection:onRenegotiationNeeded error')),
          );
        },
      ),
    );
  }

  Future<void> _handleRenegotiationNeeded(String callId, int? lineId, RTCPeerConnection peerConnection) async {
    // TODO(Serdun): Handle renegotiation needed
    // This implementation does not handle all possible signaling states.
    // Specifically, if the current state is `have-remote-offer`, calling
    // setLocalDescription with an offer will throw:
    //   WEBRTC_SET_LOCAL_DESCRIPTION_ERROR: Failed to set local offer sdp: Called in wrong state: have-remote-offer
    //
    // Known case: when CalleeVideoOfferPolicy.includeInactiveTrack is used,
    // the callee may trigger onRenegotiationNeeded before the current remote offer is processed.
    // This causes a race where the local peer is still in 'have-remote-offer' state,
    // leading to the above error. Currently this does not severely affect behavior,
    // since the offer includes only an inactive track, but it should still be handled correctly.
    //
    // Proper handling should include:
    // - Waiting until the signaling state becomes 'stable' before creating and setting a new offer
    // - Avoiding renegotiation if a remote offer is currently being processed
    // - Ensuring renegotiation is coordinated and state-aware

    final pcState = peerConnection.signalingState;
    _logger.fine(() => 'onRenegotiationNeeded signalingState: $pcState');
    if (pcState != null) {
      final localDescription = await peerConnection.createOffer({});
      sdpMunger?.apply(localDescription);

      // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
      // localDescription should be set before sending the offer to transition into have-local-offer state.
      await peerConnection.setLocalDescription(localDescription);

      try {
        final updateRequest = UpdateRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: lineId,
          callId: callId,
          jsep: localDescription.toMap(),
        );
        await _signalingClient?.execute(updateRequest);
      } catch (e, s) {
        callErrorReporter.handle(e, s, '_createPeerConnection:onRenegotiationNeeded error');
      }
    }
  }

  void _addToRecents(ActiveCall activeCall) {
    _callHistoryRecorder.record((
      direction: activeCall.direction,
      number: activeCall.handle.value,
      video: activeCall.video,
      username: activeCall.displayName,
      createdTime: activeCall.createdTime,
      acceptedTime: activeCall.acceptedTime,
      hungUpTime: activeCall.hungUpTime,
    ));
  }

  Future<void> _playRingbackSound() => _callkeepSound.playRingbackSound();

  Future<void> _stopRingbackSound() => _callkeepSound.stopRingbackSound();

  // TODO(Vlad): extract mapper,find better naming
  Future<void> _assignUserActiveCalls(List<UserActiveCall> userActiveCalls) async {
    final pullableCalls = userActiveCalls
        .map(
          (call) => PullableCall(
            id: call.id,
            state: PullableCallState.values.byName(call.state.name),
            callId: call.callId,
            localTag: call.localTag,
            remoteTag: call.remoteTag,
            remoteNumber: call.remoteNumber,
            remoteDisplayName: call.remoteDisplayName,
            direction: PullableCallDirection.values.byName(call.direction.name),
          ),
        )
        .toList();

    List<PullableCall> pullableCallsToSet = [];

    for (final pullableCall in pullableCalls) {
      // Skip calls that are already active
      if (state.activeCalls.any((call) => call.callId == pullableCall.callId)) continue;

      // Resolve contact name for the call's remote number
      final contactName = await contactNameResolver.resolveWithNumber(pullableCall.remoteNumber);
      pullableCallsToSet.add(pullableCall.copyWith(remoteDisplayName: contactName));
    }

    callPullRepository.setPullableCalls(pullableCallsToSet);
  }

  Future<void> _assignNumberPresence(String number, List<SignalingPresenceInfo> data) async {
    final presenceInfo = data.map(SignalingPresenceInfoMapper.fromSignaling).toList();
    presenceInfoRepository.setNumberPresence(number, presenceInfo);
  }

  void _checkSenderResult(RTCRtpSender? senderResult, String kind) {
    if (senderResult == null) {
      _logger.warning('safeAddTrack for $kind returned null: track not added, possibly due to closed connection');
    }
  }
}
