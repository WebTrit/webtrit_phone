part of '../bloc/call_bloc.dart';

/// Interface that [CallSessionManager] uses to interact with the outside world.
///
/// Typed callbacks keep the manager decoupled from private BLoC event classes,
/// making it possible to instantiate and test [CallSessionManager] independently
/// via a fake delegate without constructing a [CallBloc].
abstract interface class _CallSessionDelegate {
  CallState get currentState;
  Stream<CallState> get stateStream;
  bool get isSessionClosed;

  /// Dispatches a [_PeerConnectionEvent] onto the BLoC event loop.
  void _dispatchPeerConnectionEvent(_PeerConnectionEvent event);

  /// Dispatches a complete-call reset for [callId] onto the BLoC event loop.
  void dispatchCompleteCall(String callId);

  /// Submits a UI notification.
  void showNotification(Notification notification);

  /// Provides access to the signaling module.
  SignalingModule get signalingModule;

  /// Provides access to the peer connection manager.
  PeerConnectionManagerProtocol get peerConnectionManager;

  /// Provides access to the call history recorder.
  CallHistoryRecorder get callHistoryRecorder;

  /// Provides access to the callkeep sound service.
  WebtritCallkeepSound get callkeepSound;

  /// Call capabilities and services.
  UserMediaBuilder get userMediaBuilder;
  SDPMunger? get sdpMunger;
  SdpSanitizer? get sdpSanitizer;
  IceFilter? get iceFilter;
  Callkeep get callkeep;
  CallErrorReporter get callErrorReporter;
}

/// Owns per-call WebRTC state machine logic and peer connection event handling.
///
/// Lives inside `part of '../bloc/call_bloc.dart'` so it shares the library
/// boundary (and thus access to private types such as [_CallPerformEvent] and
/// [_PeerConnectionEvent]), but it is a concrete, independently-instantiable
/// class rather than an extension on [CallBloc].
class _CallSessionManager {
  _CallSessionManager({required _CallSessionDelegate delegate}) : _delegate = delegate;

  final _CallSessionDelegate _delegate;

  // Public entry-point dispatchers called from BLoC on<> handlers.

  Future<void> onCallPerformEvent(_CallPerformEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallPerformEventStarted() => _onCallPerformEventStarted(event, emit),
      _CallPerformEventAnswered() => _onCallPerformEventAnswered(event, emit),
      _CallPerformEventEnded() => _onCallPerformEventEnded(event, emit),
      _CallPerformEventSetHeld() => _onCallPerformEventSetHeld(event, emit),
      _CallPerformEventSetMuted() => _onCallPerformEventSetMuted(event, emit),
      _CallPerformEventSentDTMF() => _onCallPerformEventSentDTMF(event, emit),
      _CallPerformEventAudioDeviceSet() => _onCallPerformEventAudioDeviceSet(event, emit),
      _CallPerformEventAudioDevicesUpdate() => _onCallPerformEventAudioDevicesUpdate(event, emit),
    };
  }

  Future<void> onPeerConnectionEvent(_PeerConnectionEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _PeerConnectionEventSignalingStateChanged() => _onPeerConnectionEventSignalingStateChanged(event, emit),
      _PeerConnectionEventConnectionStateChanged() => _onPeerConnectionEventConnectionStateChanged(event, emit),
      _PeerConnectionEventIceGatheringStateChanged() => _onPeerConnectionEventIceGatheringStateChanged(event, emit),
      _PeerConnectionEventIceConnectionStateChanged() => _onPeerConnectionEventIceConnectionStateChanged(event, emit),
      _PeerConnectionEventIceCandidateIdentified() => _onPeerConnectionEventIceCandidateIdentified(event, emit),
      _PeerConnectionEventStreamAdded() => _onPeerConnectionEventStreamAdded(event, emit),
      _PeerConnectionEventStreamRemoved() => _onPeerConnectionEventStreamRemoved(event, emit),
    };
  }

  // Private call perform event handlers

  Future<void> _onCallPerformEventStarted(_CallPerformEventStarted event, Emitter<CallState> emit) async {
    if (await _delegate.currentState.performOnActiveCall(
          event.callId,
          (activeCall) => activeCall.line != _kUndefinedLine,
        ) !=
        true) {
      event.fail();

      emit(_delegate.currentState.copyWithPopActiveCall(event.callId));

      _delegate.showNotification(const CallUndefinedLineNotification());
      return;
    }

    ///
    /// Ensuring that the signaling client is connected before attempting to make an outgoing call
    ///

    var currentState = _delegate.currentState;

    // Attempt to wait for the desired signaling client status within the signaling client connection timeout period
    if (!currentState.isHandshakeEstablished || !currentState.isSignalingEstablished) {
      emit(
        _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingConnectingToSignaling);
        }),
      );

      currentState = await _delegate.stateStream
          .firstWhere((next) {
            // Stop waiting as soon as signaling is fully ready or has failed;
            // avoids blocking for the full timeout on a definitive failure.
            final signalingReady = next.isHandshakeEstablished && next.isSignalingEstablished;
            final signalingFailed = next.callServiceState.signalingClientStatus.isFailure;
            return signalingReady || signalingFailed;
          }, orElse: () => _delegate.currentState)
          .timeout(kSignalingClientConnectionTimeout, onTimeout: () => _delegate.currentState);
      if (_delegate.isSessionClosed) return;
    }

    // If the signaling client is not connected, hung up the call and notify user
    if (!currentState.isSignalingEstablished) {
      event.fail();

      // Notice that the tube was already hung up to avoid sending an extra event to the server
      emit(
        _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(hungUpTime: clock.now());
        }),
      );

      // Remove local connection
      await _delegate.callkeep.endCall(event.callId);

      _delegate.showNotification(const CallWhileOfflineNotification());
      return;
    }

    // If registration status is not registered after signaling is established, notify user
    if (currentState.callServiceState.registration?.status.isRegistered != true) {
      _logger.info('_onCallPerformEventStarted account is not registered');
      _delegate.showNotification(CallWhileUnregisteredNotification());

      event.fail();
      return;
    }

    ///
    /// Initializing media streams
    ///
    ///
    emit(
      _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingInitializingMedia);
      }),
    );

    late final MediaStream localStream;
    try {
      localStream = await _delegate.userMediaBuilder.build(
        video: event.video,
        frontCamera: _delegate.currentState.retrieveActiveCall(event.callId)?.frontCamera,
      );
      event.fulfill();

      emit(
        _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(localStream: localStream);
        }),
      );
    } on Error {
      rethrow;
    } catch (e, stackTrace) {
      _logger.warning('_onCallPerformEventStarted _getUserMedia', e, stackTrace);

      event.fail();

      _delegate.peerConnectionManager.completeError(event.callId, e, stackTrace);

      emit(_delegate.currentState.copyWithPopActiveCall(event.callId));

      _delegate.showNotification(const CallUserMediaErrorNotification());
      return;
    }

    ///
    /// Initializing peer connection and sending outgoing offer
    ///
    emit(
      _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingOfferPreparing);
      }),
    );

    try {
      final activeCall = _delegate.currentState.retrieveActiveCall(event.callId);
      final peerConnection = await _createPeerConnection(event.callId, activeCall!.line);
      await Future.wait(localStream.getTracks().map((track) => peerConnection.addTrack(track, localStream)));

      final localDescription = await peerConnection.createOffer({});
      _delegate.sdpMunger?.apply(localDescription);
      _logger.infoPretty(localDescription.sdp, tag: '_onCallPerformEventStarted');

      // Need to initiate outgoing call before set localDescription to avoid races
      // between [OutgoingCallRequest] and [IceTrickleRequest]s.
      await _delegate.signalingModule.signalingClient?.execute(
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

      _delegate.peerConnectionManager.complete(event.callId, peerConnection);

      await _delegate.callkeep.reportConnectingOutgoingCall(event.callId);

      emit(
        _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(processingStatus: CallProcessingStatus.outgoingOfferSent);
        }),
      );
    } on Error {
      rethrow;
    } catch (e, stackTrace) {
      // Handles exceptions during the outgoing call perform event, sends a notification, stops the ringtone, and completes the peer connection with an error.
      // The specific error "Error setting ICE locally" indicates an issue with ICE (Interactive Connectivity Establishment) negotiation in the WebRTC signaling process.
      _delegate.callErrorReporter.handle(e, stackTrace, '_onCallPerformEventStarted error:');

      await _stopRingbackSound();
      _delegate.peerConnectionManager.completeError(event.callId, e, stackTrace);

      _delegate.dispatchCompleteCall(event.callId);
    }
  }

  /// Performs answer after incoming call accepted by ui call controls or native controls.
  /// quick shortcuts:
  /// ui control event - [_onCallControlEventAnswered]
  /// after success - [_onCallSignalingEventAccepted]
  /// jsep processing in - [_onCallSignalingEventIncoming]
  Future<void> _onCallPerformEventAnswered(_CallPerformEventAnswered event, Emitter<CallState> emit) async {
    event.fulfill();

    ActiveCall? call = _delegate.currentState.retrieveActiveCall(event.callId);
    if (call == null) return;

    // Prevent performing double answer and race conditions
    //
    // Main case happens when the call is answered from background(ios) or from the lock screen using native controls
    // In such case performAnswered called immediately and after signaling initialized via
    // [IncomingEvent] + (callAlreadyAnswered == true) > [callControlAnswered] > [performAnswered] called again
    //
    final canPerformAnswer = switch (call.processingStatus) {
      CallProcessingStatus.incomingFromPush => true,
      CallProcessingStatus.incomingFromOffer => true,
      CallProcessingStatus.incomingSubmittedAnswer => true,
      _ => false,
    };

    if (canPerformAnswer == false) {
      _logger.info('_onCallPerformEventAnswered: skipping due stale status: ${call.processingStatus}');
      return;
    }

    emit(
      _delegate.currentState.copyWithMappedActiveCall(event.callId, (call) {
        return call.copyWith(processingStatus: CallProcessingStatus.incomingPerformingStarted);
      }),
    );

    try {
      /// Prevent performing answer without offer
      ///
      /// Main case happens when the call is answered from push event while signaling is disconnected
      /// and main [IncomingEvent] with offer wasn't received yet
      ///
      if (call.incomingOffer == null) {
        _logger.info('_onCallPerformEventAnswered: wait for offer');

        await _delegate.stateStream
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

        call = _delegate.currentState.retrieveActiveCall(event.callId);
        if (call == null) return;
      }
      final offer = call.incomingOffer!;

      emit(
        _delegate.currentState.copyWithMappedActiveCall(event.callId, (call) {
          return call.copyWith(processingStatus: CallProcessingStatus.incomingInitializingMedia);
        }),
      );

      final localStream = await _delegate.userMediaBuilder.build(video: offer.hasVideo, frontCamera: call.frontCamera);
      final peerConnection = await _createPeerConnection(event.callId, call.line);
      await Future.forEach(localStream.getTracks(), (t) => peerConnection.addTrack(t, localStream));

      emit(
        _delegate.currentState.copyWithMappedActiveCall(event.callId, (call) {
          return call.copyWith(localStream: localStream, processingStatus: CallProcessingStatus.incomingAnswering);
        }),
      );

      final remoteDescription = offer.toDescription();
      _delegate.sdpSanitizer?.apply(remoteDescription);
      await peerConnection.setRemoteDescription(remoteDescription);
      final localDescription = await peerConnection.createAnswer({});
      _delegate.sdpMunger?.apply(localDescription);

      // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
      // localDescription should be set before sending the answer to transition into stable state.
      await peerConnection.setLocalDescription(localDescription).catchError((e) => throw SDPConfigurationError(e));

      await _delegate.signalingModule.signalingClient?.execute(
        AcceptRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: call.line,
          callId: call.callId,
          jsep: localDescription.toMap(),
        ),
      );

      _delegate.peerConnectionManager.complete(event.callId, peerConnection);
    } on Error {
      rethrow;
    } catch (e, stackTrace) {
      _delegate.peerConnectionManager.completeError(event.callId, e, stackTrace);
      _delegate.dispatchCompleteCall(event.callId);

      _addToRecents(call!);

      final declineId = WebtritSignalingClient.generateTransactionId();
      final declineRequest = DeclineRequest(transaction: declineId, line: call.line, callId: call.callId);
      _delegate.signalingModule.signalingClient?.execute(declineRequest).ignore();

      _delegate.callErrorReporter.handle(e, stackTrace, '_onCallPerformEventAnswered error:');
    }
  }

  Future<void> _onCallPerformEventEnded(_CallPerformEventEnded event, Emitter<CallState> emit) async {
    // Condition occur when the user interacts with a push notification before signaling is properly initialized.
    // In this case, the CallKeep method "reportNewIncomingCall" may return callIdAlreadyTerminated.
    if (_delegate.currentState.retrieveActiveCall(event.callId)?.line == _kUndefinedLine) {
      event.fail();
      _delegate.dispatchCompleteCall(event.callId);
      return;
    }

    if (_delegate.currentState.retrieveActiveCall(event.callId)?.wasHungUp == true) {
      // TODO: There's an issue where the user might have already ended the call, but the active call screen remains visible.
      if (_delegate.currentState.isActive) {
        emit(_delegate.currentState.copyWithPopActiveCall(event.callId));
      }
      event.fail();
      return;
    }

    event.fulfill();

    await _stopRingbackSound();

    emit(
      _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
        final activeCallUpdated = activeCall.copyWith(hungUpTime: clock.now());
        _addToRecents(activeCallUpdated);
        return activeCallUpdated;
      }),
    );

    await _delegate.currentState.performOnActiveCall(event.callId, (activeCall) async {
      if (activeCall.isIncoming && !activeCall.wasAccepted) {
        final declineRequest = DeclineRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId,
        );
        final declineFuture = _delegate.signalingModule.signalingClient?.execute(declineRequest);
        await declineFuture?.catchError((e, s) {
          _delegate.callErrorReporter.handle(e, s, '_onCallPerformEventEnded declineRequest error');
        });
      } else {
        final hangupRequest = HangupRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId,
        );
        final hangupFuture = _delegate.signalingModule.signalingClient?.execute(hangupRequest);
        await hangupFuture?.catchError((e, s) {
          _delegate.callErrorReporter.handle(e, s, '_onCallPerformEventEnded hangupRequest error');
        });
      }

      // Need to close peer connection after executing [HangupRequest]
      // to prevent "Simulate a "hangup" coming from the application"
      // because of "No WebRTC media anymore".
      await _delegate.peerConnectionManager.disposePeerConnection(activeCall.callId);
      await activeCall.localStream?.dispose();
    });

    emit(_delegate.currentState.copyWithPopActiveCall(event.callId));
  }

  Future<void> _onCallPerformEventSetHeld(_CallPerformEventSetHeld event, Emitter<CallState> emit) async {
    event.fulfill();

    try {
      await _delegate.currentState.performOnActiveCall(event.callId, (activeCall) {
        if (event.onHold) {
          return _delegate.signalingModule.signalingClient?.execute(
            HoldRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
              direction: HoldDirection.inactive,
            ),
          );
        } else {
          return _delegate.signalingModule.signalingClient?.execute(
            UnholdRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
            ),
          );
        }
      });

      emit(
        _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(held: event.onHold);
        }),
      );
    } on Error {
      rethrow;
    } catch (e, stackTrace) {
      _delegate.callErrorReporter.handle(e, stackTrace, '_onCallPerformEventSetHeld error');

      _delegate.peerConnectionManager.completeError(event.callId, e, stackTrace);

      _delegate.dispatchCompleteCall(event.callId);
    }
  }

  Future<void> _onCallPerformEventSetMuted(_CallPerformEventSetMuted event, Emitter<CallState> emit) async {
    event.fulfill();

    await _delegate.currentState.performOnActiveCall(event.callId, (activeCall) {
      final audioTrack = activeCall.localStream?.getAudioTracks()[0];
      if (audioTrack != null) {
        Helper.setMicrophoneMute(event.muted, audioTrack);
      }
    });

    emit(
      _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(muted: event.muted);
      }),
    );
  }

  Future<void> _onCallPerformEventSentDTMF(_CallPerformEventSentDTMF event, Emitter<CallState> emit) async {
    event.fulfill();

    await _delegate.currentState.performOnActiveCall(event.callId, (activeCall) async {
      final peerConnection = await _delegate.peerConnectionManager.retrieve(event.callId);
      if (peerConnection == null) {
        _logger.warning('_onCallPerformEventSentDTMF: peerConnection is null - most likely some permissions issue');
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
          _logger.warning('_onCallPerformEventSentDTMF can\'t send DTMF');
        }
      }
    });
  }

  Future<void> _onCallPerformEventAudioDeviceSet(_CallPerformEventAudioDeviceSet event, Emitter<CallState> emit) async {
    _logger.info('CallPerformEventAudioDeviceSet: ${event.device}');
    event.fulfill();
    emit(_delegate.currentState.copyWith(audioDevice: event.device));
  }

  Future<void> _onCallPerformEventAudioDevicesUpdate(
    _CallPerformEventAudioDevicesUpdate event,
    Emitter<CallState> emit,
  ) async {
    _logger.info('CallPerformEventAudioDevicesUpdate: ${event.devices}');
    event.fulfill();
    emit(_delegate.currentState.copyWith(availableAudioDevices: event.devices));
  }

  // Private peer connection event handlers

  Future<void> _onPeerConnectionEventSignalingStateChanged(
    _PeerConnectionEventSignalingStateChanged event,
    Emitter<CallState> emit,
  ) async {}

  Future<void> _onPeerConnectionEventConnectionStateChanged(
    _PeerConnectionEventConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {}

  Future<void> _onPeerConnectionEventIceGatheringStateChanged(
    _PeerConnectionEventIceGatheringStateChanged event,
    Emitter<CallState> emit,
  ) async {
    if (event.state == RTCIceGatheringState.RTCIceGatheringStateComplete) {
      try {
        await _delegate.currentState.performOnActiveCall(event.callId, (activeCall) {
          if (!activeCall.wasHungUp) {
            final iceTrickleRequest = IceTrickleRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              candidate: null,
            );
            return _delegate.signalingModule.signalingClient?.execute(iceTrickleRequest);
          }
        });
      } on Error {
        rethrow;
      } catch (e, stackTrace) {
        _delegate.callErrorReporter.handle(e, stackTrace, '_onPeerConnectionEventIceGatheringStateChanged error');

        _delegate.peerConnectionManager.completeError(event.callId, e, stackTrace);

        _delegate.dispatchCompleteCall(event.callId);
      }
    }
  }

  Future<void> _onPeerConnectionEventIceConnectionStateChanged(
    _PeerConnectionEventIceConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {
    if (event.state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
      try {
        await _delegate.currentState.performOnActiveCall(event.callId, (activeCall) async {
          final peerConnection = await _delegate.peerConnectionManager.retrieve(event.callId);
          if (peerConnection == null) {
            _logger.warning(
              '_onPeerConnectionEventIceConnectionStateChanged: peerConnection is null - most likely some state issue',
            );
          } else {
            await peerConnection.restartIce();
            final localDescription = await peerConnection.createOffer({});
            _delegate.sdpMunger?.apply(localDescription);

            // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
            // localDescription should be set before sending the answer to transition into stable state.
            await peerConnection.setLocalDescription(localDescription);

            final updateRequest = UpdateRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
              jsep: localDescription.toMap(),
            );
            await _delegate.signalingModule.signalingClient?.execute(updateRequest);
          }
        });
      } on Error {
        rethrow;
      } catch (e, stackTrace) {
        _delegate.callErrorReporter.handle(e, stackTrace, '_onPeerConnectionEventIceConnectionStateChanged error');

        _delegate.peerConnectionManager.completeError(event.callId, e, stackTrace);

        _delegate.dispatchCompleteCall(event.callId);
      }
    }
  }

  Future<void> _onPeerConnectionEventIceCandidateIdentified(
    _PeerConnectionEventIceCandidateIdentified event,
    Emitter<CallState> emit,
  ) async {
    if (_delegate.iceFilter?.filter(event.candidate) == true) {
      _logger.fine('_onPeerConnectionEventIceCandidateIdentified: skip by iceFilter');
      return;
    }

    try {
      await _delegate.currentState.performOnActiveCall(event.callId, (activeCall) {
        if (!activeCall.wasHungUp) {
          final iceTrickleRequest = IceTrickleRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            candidate: event.candidate.toMap(),
          );
          return _delegate.signalingModule.signalingClient?.execute(iceTrickleRequest);
        }
      });
    } on Error {
      rethrow;
    } catch (e, stackTrace) {
      _delegate.callErrorReporter.handle(e, stackTrace, '_onPeerConnectionEventIceCandidateIdentified error');

      _delegate.peerConnectionManager.completeError(event.callId, e, stackTrace);

      _delegate.dispatchCompleteCall(event.callId);
    }
  }

  Future<void> _onPeerConnectionEventStreamAdded(_PeerConnectionEventStreamAdded event, Emitter<CallState> emit) async {
    // Skip stub stream created by Janus on unidirectional video
    if (event.stream.id == 'janus') return;

    emit(
      _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(remoteStream: event.stream);
      }),
    );
  }

  Future<void> _onPeerConnectionEventStreamRemoved(
    _PeerConnectionEventStreamRemoved event,
    Emitter<CallState> emit,
  ) async {
    emit(
      _delegate.currentState.copyWithMappedActiveCall(event.callId, (activeCall) {
        final prevStream = activeCall.remoteStream;
        if (prevStream != null && prevStream.id == event.stream.id) {
          return activeCall.copyWith(remoteStream: null);
        }
        return activeCall;
      }),
    );
  }

  Future<RTCPeerConnection> _createPeerConnection(String callId, int? lineId) {
    return _delegate.peerConnectionManager.createPeerConnection(
      callId,
      observer: PeerConnectionObserver(
        onSignalingState: (state) =>
            _delegate._dispatchPeerConnectionEvent(_PeerConnectionEvent.signalingStateChanged(callId, state)),
        onConnectionState: (state) =>
            _delegate._dispatchPeerConnectionEvent(_PeerConnectionEvent.connectionStateChanged(callId, state)),
        onIceGatheringState: (state) =>
            _delegate._dispatchPeerConnectionEvent(_PeerConnectionEvent.iceGatheringStateChanged(callId, state)),
        onIceConnectionState: (state) =>
            _delegate._dispatchPeerConnectionEvent(_PeerConnectionEvent.iceConnectionStateChanged(callId, state)),
        onIceCandidate: (candidate) =>
            _delegate._dispatchPeerConnectionEvent(_PeerConnectionEvent.iceCandidateIdentified(callId, candidate)),
        onAddStream: (stream) =>
            _delegate._dispatchPeerConnectionEvent(_PeerConnectionEvent.streamAdded(callId, stream)),
        onRemoveStream: (stream) =>
            _delegate._dispatchPeerConnectionEvent(_PeerConnectionEvent.streamRemoved(callId, stream)),
        onRenegotiationNeeded: (pc) {
          unawaited(
            _handleRenegotiationNeeded(callId, lineId, pc).catchError(
              (e, s) => _delegate.callErrorReporter.handle(e, s, '_createPeerConnection:onRenegotiationNeeded error'),
            ),
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
      _delegate.sdpMunger?.apply(localDescription);

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
        await _delegate.signalingModule.signalingClient?.execute(updateRequest);
      } on Error {
        rethrow;
      } catch (e, s) {
        _delegate.callErrorReporter.handle(e, s, '_createPeerConnection:onRenegotiationNeeded error');
      }
    }
  }

  void _addToRecents(ActiveCall activeCall) {
    _delegate.callHistoryRecorder.record((
      direction: activeCall.direction,
      number: activeCall.handle.value,
      video: activeCall.video,
      username: activeCall.displayName,
      createdTime: activeCall.createdTime,
      acceptedTime: activeCall.acceptedTime,
      hungUpTime: activeCall.hungUpTime,
    ));
  }

  Future<void> _stopRingbackSound() => _delegate.callkeepSound.stopRingbackSound();
}
