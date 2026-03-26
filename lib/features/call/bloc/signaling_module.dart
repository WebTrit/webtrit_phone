part of 'call_bloc.dart';

extension _SignalingModule on CallBloc {
  void _reconnectInitiated({Duration delay = kSignalingClientFastReconnectDelay, bool force = false}) {
    _signalingClientReconnectTimer?.cancel();
    _signalingClientReconnectTimer = Timer(delay, () {
      final appActive = state.currentAppLifecycleState == AppLifecycleState.resumed;
      final connectionActive = state.callServiceState.networkStatus != NetworkStatus.none;
      final signalingRemains = _signalingClient != null;

      _logger.info(
        '_reconnectInitiated Timer callback after $delay, isClosed: $isClosed, appActive: $appActive, connectionActive: $connectionActive',
      );

      // Guard clause to prevent reconnection when the bloc was closed after delay.
      if (isClosed) return;

      // Guard clause to prevent reconnection when the app is in the background.
      // Coz reconnect can be triggered by another action e.g connectivity change.
      if (appActive == false && force == false) {
        _logger.info('__onSignalingClientEventConnectInitiated: skipped due to appActive: $appActive');
        return;
      }

      // Guard clause to prevent reconnection when there is no connectivity.
      // Coz reconnect can be triggered by another action e.g app lifecycle change.
      if (connectionActive == false && force == false) {
        _logger.info('__onSignalingClientEventConnectInitiated: skipped due to connectionActive: $connectionActive');
        return;
      }

      // Guard clause to prevent reconnection when the signaling client is already connected.
      //
      // Can be triggered by switching from wifi to mobile data.
      // In this case, the connection is recovers automatically, and signaling wasnt disposed.
      //
      // Or if app resumes from background or native call screen during active call,
      // in this case signaling wasnt disposed
      if (signalingRemains == true && force == false) {
        _logger.info('__onSignalingClientEventConnectInitiated: skipped due signalingRemains: $signalingRemains');
        return;
      }

      add(const _SignalingClientEvent.connectInitiated());
    });
  }

  void _disconnectInitiated() {
    _signalingClientReconnectTimer?.cancel();
    _signalingClientReconnectTimer = null;
    add(const _SignalingClientEvent.disconnectInitiated());
  }

  Future<void> _onSignalingClientEvent(_SignalingClientEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _SignalingClientEventConnectInitiated() => __onSignalingClientEventConnectInitiated(event, emit),
      _SignalingClientEventDisconnectInitiated() => __onSignalingClientEventDisconnectInitiated(event, emit),
      _SignalingClientEventDisconnected() => __onSignalingClientEventDisconnected(event, emit),
    };
  }

  Future<void> __onSignalingClientEventConnectInitiated(
    _SignalingClientEventConnectInitiated event,
    Emitter<CallState> emit,
  ) async {
    emit(
      state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.connecting,
          lastSignalingClientDisconnectError: null,
        ),
      ),
    );

    try {
      {
        final signalingClient = _signalingClient;
        if (signalingClient != null) {
          _signalingClient = null;
          await signalingClient.disconnect();
        }
      }

      if (emit.isDone) return;

      final signalingUrl = WebtritSignalingUtils.parseCoreUrlToSignalingUrl(coreUrl);

      final signalingClient = await _signalingClientFactory(
        url: signalingUrl,
        tenantId: tenantId,
        token: token,
        connectionTimeout: kSignalingClientConnectionTimeout,
        certs: trustedCertificates,
        force: true,
      );

      if (emit.isDone) {
        await signalingClient.disconnect(SignalingDisconnectCode.goingAway.code);
        return;
      }

      signalingClient.listen(
        onStateHandshake: _onSignalingStateHandshake,
        onEvent: _onSignalingEvent,
        onError: _onSignalingError,
        onDisconnect: _onSignalingDisconnect,
      );
      _signalingClient = signalingClient;

      emit(
        state.copyWith(
          callServiceState: state.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.connect,
            lastSignalingClientConnectError: null,
            lastSignalingDisconnectCode: null,
          ),
        ),
      );
    } catch (e, s) {
      if (emit.isDone) return;
      _logger.warning('__onSignalingClientEventConnectInitiated', e, s);

      // toString is important to compare low level exceptions like SocketException, HttpException, TlsException etc.
      final repeated = state.callServiceState.lastSignalingClientConnectError.toString() == e.toString();
      if (repeated == false) {
        submitNotification(const SignalingConnectFailedNotification());
      }

      emit(
        state.copyWith(
          callServiceState: state.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.failure,
            lastSignalingClientConnectError: e,
          ),
        ),
      );

      _reconnectInitiated(delay: kSignalingClientReconnectDelay);
    }
  }

  Future<void> __onSignalingClientEventDisconnectInitiated(
    _SignalingClientEventDisconnectInitiated event,
    Emitter<CallState> emit,
  ) async {
    emit(
      state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnecting,
          lastSignalingClientConnectError: null,
        ),
      ),
    );

    try {
      final signalingClient = _signalingClient;
      if (signalingClient != null) {
        _signalingClient = null;
        await signalingClient.disconnect();
      }

      if (emit.isDone) return;

      emit(
        state.copyWith(
          callServiceState: state.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.disconnect,
            lastSignalingClientDisconnectError: null,
            lastSignalingDisconnectCode: null,
          ),
        ),
      );
    } catch (e) {
      if (emit.isDone) return;

      emit(
        state.copyWith(
          callServiceState: state.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.failure,
            lastSignalingClientDisconnectError: e,
          ),
        ),
      );
    }
  }

  Future<void> __onSignalingClientEventDisconnected(
    _SignalingClientEventDisconnected event,
    Emitter<CallState> emit,
  ) async {
    final code = SignalingDisconnectCode.values.byCode(event.code ?? -1);
    final repeated = event.code == state.callServiceState.lastSignalingDisconnectCode;

    CallState newState = state.copyWith(
      callServiceState: state.callServiceState.copyWith(
        signalingClientStatus: SignalingClientStatus.disconnect,
        lastSignalingDisconnectCode: event.code,
      ),
    );
    Notification? notificationToShow;
    bool shouldReconnect = true;

    if (code == SignalingDisconnectCode.appUnregisteredError) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.unregistered));

      newState = state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: event.code,
        ),
      );
    } else if (code == SignalingDisconnectCode.requestCallIdError) {
      state.activeCalls.where((e) => e.wasHungUp).forEach((e) => add(_ResetStateEvent.completeCall(e.callId)));
    } else if (code == SignalingDisconnectCode.controllerExitError) {
      _logger.info('__onSignalingClientEventDisconnected: skipping expected system unregistration notification');
    } else if (code == SignalingDisconnectCode.controllerForceAttachClose) {
      // Server closed the connection because a duplicate signaling session was detected
      // (e.g. background push isolate still connected when main engine reconnects).
      // Reconnect silently: don't set lastSignalingDisconnectCode so connectIssue is never shown.
      _logger.warning(
        '__onSignalingClientEventDisconnected: signaling race detected — '
        'server force-closed duplicate session (code=${event.code}, reason="${event.reason}"). '
        'Reconnecting silently without showing connectIssue.',
      );
      newState = state.copyWith(
        callServiceState: state.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: null,
        ),
      );
    } else if (code == SignalingDisconnectCode.sessionMissedError) {
      notificationToShow = const SignalingSessionMissedNotification();
    } else if (code.type == SignalingDisconnectCodeType.auxiliary) {
      _logger.info('__onSignalingClientEventDisconnected: socket goes down');

      /// Fun facts
      /// - in case of network disconnection on android this section is evaluating faster than [_onConnectivityResultChanged].
      /// - also in case of network disconnection error code is protocolError instead of normalClosure by unknown reason
      /// so we need to handle it here as regular disconnection
      if (code == SignalingDisconnectCode.protocolError) {
        shouldReconnect = false;
      } else {
        notificationToShow = SignalingDisconnectNotification(
          knownCode: code,
          systemCode: event.code,
          systemReason: event.reason,
        );
      }
    } else {
      notificationToShow = SignalingDisconnectNotification(
        knownCode: code,
        systemCode: event.code,
        systemReason: event.reason,
      );
    }
    emit(newState);
    _signalingClient = null;
    if (notificationToShow != null && !repeated) submitNotification(notificationToShow);
    if (shouldReconnect) {
      final reconnectDelay = code == SignalingDisconnectCode.controllerForceAttachClose
          ? kSignalingClientFastReconnectDelay
          : kSignalingClientReconnectDelay;
      _reconnectInitiated(delay: reconnectDelay);
    }
  }

  // processing handshake signaling events

  Future<void> _onHandshakeSignalingEventState(_HandshakeSignalingEventState event, Emitter<CallState> emit) async {
    emit(state.copyWith(linesCount: event.linesCount));

    add(_RegistrationChange(registration: event.registration));
  }

  // processing call signaling events

  Future<void> _onCallSignalingEvent(_CallSignalingEvent event, Emitter<CallState> emit) {
    return switch (event) {
      _CallSignalingEventIncoming() => __onCallSignalingEventIncoming(event, emit),
      _CallSignalingEventRinging() => __onCallSignalingEventRinging(event, emit),
      _CallSignalingEventProgress() => __onCallSignalingEventProgress(event, emit),
      _CallSignalingEventAccepted() => __onCallSignalingEventAccepted(event, emit),
      _CallSignalingEventHangup() => __onCallSignalingEventHangup(event, emit),
      _CallSignalingEventUpdating() => __onCallSignalingEventUpdating(event, emit),
      _CallSignalingEventUpdated() => __onCallSignalingEventUpdated(event, emit),
      _CallSignalingEventTransfer() => __onCallSignalingEventTransfer(event, emit),
      _CallSignalingEventTransferring() => __onCallSignalingEventTransfering(event, emit),
      _CallSignalingEventNotifyDialog() => __onCallSignalingEventNotifyDialog(event, emit),
      _CallSignalingEventNotifyRefer() => __onCallSignalingEventNotifyRefer(event, emit),
      _CallSignalingEventNotifyPresence() => __onCallSignalingEventNotifyPresence(event, emit),
      _CallSignalingEventNotifyUnknown() => __onCallSignalingEventNotifyUnknown(event, emit),
      _CallSignalingEventRegistration() => __onCallSignalingEventRegistration(event, emit),
    };
  }

  /// Handles incoming call offer.
  ///
  /// - Creates a new full [ActiveCall] with offer and line.
  /// - Or enriches existing [ActiveCall] with line and offer if
  /// its placed by push [__onCallPushEventIncoming] before the signaling was initialized.
  ///
  /// - continues in  [__onCallControlEventAnswered], [__onCallPerformEventAnswered] or [__onCallControlEventEnded], [__onCallPerformEventEnded]
  ///
  /// Be aware the answering intent can be submitted before the full [ActiveCall].
  /// So the answering method [__onCallPerformEventAnswered] will wait until offer and line is assigned
  /// to the [ActiveCall] by logic below, do not change status in that case.
  Future<void> __onCallSignalingEventIncoming(_CallSignalingEventIncoming event, Emitter<CallState> emit) async {
    _logger.infoPretty(event.jsep?.sdp, tag: '__onCallSignalingEventIncoming');

    final video = event.jsep?.hasVideo ?? false;
    final handle = CallkeepHandle.number(event.caller);
    final contactName = await contactNameResolver.resolveWithNumber(handle.value);
    final displayName = contactName ?? event.callerDisplayName;

    final error = await callkeep.reportNewIncomingCall(event.callId, handle, displayName: displayName, hasVideo: video);

    // Check if a call instance already exists in the callkeep, which might have been added via push notifications
    // before the signaling was initialized.
    final callAlreadyExists = error == CallkeepIncomingCallError.callIdAlreadyExists;

    // Check if a call instance already exists in the callkeep, which might have been added via push notifications
    // before the signaling  was initialized. Also, check if the call status has been changed to "answered,"
    // indicating it can be triggered by pressing the answer button in the notification.
    final callAlreadyAnswered = error == CallkeepIncomingCallError.callIdAlreadyExistsAndAnswered;

    // Check if a call instance already terminated in the callkeep, which might have been added via push notifications
    // before the signaling  was initialized. Also, check if the call status has been changed to "terminated"
    // indicating it can be triggered by pressing the decline button in the notification or flutter ui.
    final callAlreadyTerminated = error == CallkeepIncomingCallError.callIdAlreadyTerminated;

    if (error != null && !callAlreadyExists && !callAlreadyAnswered && !callAlreadyTerminated) {
      _logger.warning('__onCallSignalingEventIncoming reportNewIncomingCall error: $error');
      // TODO: implement correct incoming call hangup (take into account that _signalingClient could be disconnected)
      return;
    }

    final transfer = (event.referredBy != null && event.replaceCallId != null)
        ? InviteToAttendedTransfer(replaceCallId: event.replaceCallId!, referredBy: event.referredBy!)
        : null;

    ActiveCall? activeCall = state.retrieveActiveCall(event.callId);

    if (activeCall != null) {
      activeCall = activeCall.copyWith(
        line: event.line,
        handle: handle,
        displayName: displayName,
        video: video,
        transfer: transfer,
        incomingOffer: event.jsep,
      );
      emit(state.copyWithMappedActiveCall(event.callId, (_) => activeCall!));
    } else {
      activeCall = ActiveCall(
        direction: CallDirection.incoming,
        line: event.line,
        callId: event.callId,
        handle: handle,
        displayName: displayName,
        video: video,
        createdTime: clock.now(),
        transfer: transfer,
        incomingOffer: event.jsep,
        processingStatus: CallProcessingStatus.incomingFromOffer,
      );
      emit(state.copyWithPushActiveCall(activeCall));
    }

    // Ensure to continue processing call if push action(answer, decline) pressed but app was'nt active at this moment
    // typically happens on android from terminated or background state,
    // on ios it produce second call of [__onCallPerformEventAnswered] or [__onCallPerformEventEnded]
    // so make sure to guard it from race conditions
    await Future.delayed(Duration.zero); // Defer execution to avoid exceptions like CallkeepCallRequestError.internal.
    if (callAlreadyAnswered) add(CallControlEvent.answered(event.callId));
    if (callAlreadyTerminated) add(CallControlEvent.ended(event.callId));
  }

  // no early media - play ringtone
  Future<void> __onCallSignalingEventRinging(_CallSignalingEventRinging event, Emitter<CallState> emit) async {
    await _playRingbackSound();

    emit(
      state.copyWithMappedActiveCall(event.callId, (call) {
        return call.copyWith(processingStatus: CallProcessingStatus.outgoingRinging);
      }),
    );
  }

  // early media - set specified session description
  Future<void> __onCallSignalingEventProgress(_CallSignalingEventProgress event, Emitter<CallState> emit) async {
    await _stopRingbackSound();

    final jsep = event.jsep;
    if (jsep != null) {
      final peerConnection = await _peerConnectionManager.retrieve(event.callId);
      if (peerConnection == null) {
        _logger.warning('__onCallSignalingEventProgress: peerConnection is null - most likely some permissions issue');
      } else {
        final remoteDescription = jsep.toDescription();
        sdpSanitizer?.apply(remoteDescription);
        await peerConnection.setRemoteDescription(remoteDescription);
      }
    } else {
      _logger.warning('__onCallSignalingEventProgress: jsep must not be null');
    }
  }

  /// Event fired when the call is accepted by any! user or call update request aplied.
  /// main cases:
  /// as call connected event after [__onCallPerformEventAnswered] or [__onCallPerformEventStarted]
  /// or as acknowledge of [UpdateRequest] with new jsep.
  Future<void> __onCallSignalingEventAccepted(_CallSignalingEventAccepted event, Emitter<CallState> emit) async {
    ActiveCall? call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    final initialAccept = call.acceptedTime == null;
    final outgoing = call.direction == CallDirection.outgoing;
    final jsep = event.jsep;

    if (initialAccept) {
      call = call.copyWith(processingStatus: CallProcessingStatus.connected, acceptedTime: clock.now());

      if (outgoing) {
        await _stopRingbackSound();
        await callkeep.reportConnectedOutgoingCall(event.callId);
      }
    }

    emit(state.copyWithMappedActiveCall(event.callId, (_) => call!));

    final peerConnection = await _peerConnectionManager.retrieve(event.callId);
    if (jsep != null && peerConnection != null) {
      final remoteDescription = jsep.toDescription();
      sdpSanitizer?.apply(remoteDescription);
      await peerConnection.setRemoteDescription(remoteDescription);
    }
  }

  Future<void> __onCallSignalingEventHangup(_CallSignalingEventHangup event, Emitter<CallState> emit) async {
    final code = SignalingResponseCode.values.byCode(event.code);
    _logger.fine('__onCallSignalingEventHangup code: ${code?.name} ${code?.code} ${code?.type.name}');

    switch (code) {
      case null:
        break;
      case SignalingResponseCode.declineCall:
        break;
      case SignalingResponseCode.normalUnspecified:
        break;
      case SignalingResponseCode.requestTerminated:
        break;
      case SignalingResponseCode.unauthorizedRequest:
        submitNotification(CallWhileUnregisteredNotification());
        break;
      default:
        final signalingHangupException = SignalingHangupFailure(code);
        final defaultErrorNotification = DefaultErrorNotification(signalingHangupException);
        submitNotification(defaultErrorNotification);
    }

    try {
      await _stopRingbackSound();

      ActiveCall? call = state.retrieveActiveCall(event.callId);

      if (call != null) {
        CallkeepEndCallReason endReason = CallkeepEndCallReason.remoteEnded;

        if (call.wasHungUp == false) {
          _addToRecents(call.copyWith(hungUpTime: clock.now()));
        }

        if (call.direction == CallDirection.incoming && !call.wasAccepted) {
          if (code == SignalingResponseCode.declineCall) endReason = CallkeepEndCallReason.declinedElsewhere;
          if (code == SignalingResponseCode.requestTerminated) endReason = CallkeepEndCallReason.unanswered;
        }

        // Updated: Delegate disposal to manager.
        // This handles closing the connection and removing the completer.
        await _peerConnectionManager.disposePeerConnection(event.callId);

        await call.localStream?.dispose();

        emit(state.copyWithPopActiveCall(event.callId));

        await callkeep.reportEndCall(event.callId, call.displayName ?? call.handle.value, endReason);
      }
    } catch (e) {
      _logger.warning('__onCallSignalingEventHangup: $e');
    }
  }

  Future<void> __onCallSignalingEventUpdating(_CallSignalingEventUpdating event, Emitter<CallState> emit) async {
    final handle = CallkeepHandle.number(event.caller);
    final contactName = await contactNameResolver.resolveWithNumber(handle.value);
    final displayName = contactName ?? event.callerDisplayName;

    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(
          handle: handle,
          displayName: displayName ?? activeCall.displayName,
          video: event.jsep?.hasVideo ?? activeCall.video,
          updating: true,
        );
      }),
    );

    final activeCall = state.retrieveActiveCall(event.callId)!;

    await callkeep.reportUpdateCall(
      event.callId,
      handle: handle,
      displayName: activeCall.displayName,
      hasVideo: activeCall.video,
      proximityEnabled: state.shouldListenToProximity,
    );

    try {
      final jsep = event.jsep;
      if (jsep != null) {
        final remoteDescription = jsep.toDescription();
        sdpSanitizer?.apply(remoteDescription);
        await state.performOnActiveCall(event.callId, (activeCall) async {
          final peerConnection = await _peerConnectionManager.retrieve(event.callId);
          if (peerConnection == null) {
            _logger.warning('__onCallSignalingEventUpdating: peerConnection is null - most likely some state issue');
          } else {
            await peerConnectionPolicyApplier?.apply(peerConnection, hasRemoteVideo: jsep.hasVideo);
            await peerConnection.setRemoteDescription(remoteDescription);
            final localDescription = await peerConnection.createAnswer({});
            sdpMunger?.apply(localDescription);

            // According to RFC 8829 5.6 (https://datatracker.ietf.org/doc/html/rfc8829#section-5.6),
            // localDescription should be set before sending the answer to transition into stable state.
            await peerConnection.setLocalDescription(localDescription);

            await _signalingClient?.execute(
              UpdateRequest(
                transaction: WebtritSignalingClient.generateTransactionId(),
                line: activeCall.line,
                callId: activeCall.callId,
                jsep: localDescription.toMap(),
              ),
            );
          }
        });
      }
    } catch (e, s) {
      callErrorReporter.handle(e, s, '__onCallSignalingEventUpdating && jsep error:');

      _peerConnectionManager.completeError(event.callId, e);
      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onCallSignalingEventUpdated(_CallSignalingEventUpdated event, Emitter<CallState> emit) async {
    emit(
      state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(updating: false);
      }),
    );
  }

  Future<void> __onCallSignalingEventTransfer(_CallSignalingEventTransfer event, Emitter<CallState> emit) async {
    final replaceCallId = event.replaceCallId;
    final referredBy = event.referredBy;
    final referId = event.referId;
    final referTo = event.referTo;

    // If replaceCallId exists, it means that the REFER request for attended transfer
    if (replaceCallId != null && referredBy != null) {
      // Find the active call that is should be replaced
      final callToReplace = state.retrieveActiveCall(replaceCallId);
      if (callToReplace == null) return;

      // Update call with confirmation request state
      final transfer = Transfer.attendedTransferConfirmationRequested(
        referId: referId,
        referTo: referTo,
        referredBy: referredBy,
      );
      final callUpdate = callToReplace.copyWith(transfer: transfer);
      emit(state.copyWithMappedActiveCall(replaceCallId, (_) => callUpdate));
    }
  }

  Future<void> __onCallSignalingEventTransfering(_CallSignalingEventTransferring event, Emitter<CallState> emit) async {
    final call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    final prev = call.transfer;
    final transfer = Transfer.transfering(
      fromAttendedTransfer: prev is AttendedTransferTransferSubmitted,
      fromBlindTransfer: prev is BlindTransferTransferSubmitted,
    );

    final callUpdate = call.copyWith(transfer: transfer);
    emit(state.copyWithMappedActiveCall(event.callId, (_) => callUpdate));
  }

  Future<void> __onCallSignalingEventNotifyDialog(
    _CallSignalingEventNotifyDialog event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('_CallSignalingEventNotifyDialogs: $event');
    await _assignUserActiveCalls(event.userActiveCalls);
  }

  Future<void> __onCallSignalingEventNotifyPresence(
    _CallSignalingEventNotifyPresence event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('_CallSignalingEventNotifyPresence: $event');
    await _assignNumberPresence(event.number, event.presenceInfo);
  }

  Future<void> __onCallSignalingEventNotifyRefer(_CallSignalingEventNotifyRefer event, Emitter<CallState> emit) async {
    _logger.fine('_CallSignalingEventNotifyRefer: $event');
    if (event.subscriptionState != SubscriptionState.terminated) return;
    if (event.state != ReferNotifyState.ok) return;

    // Verifies if the original call line is currently active in the state
    if (state.activeCalls.any((it) => it.callId == event.callId)) add(CallControlEvent.ended(event.callId));
  }

  Future<void> __onCallSignalingEventNotifyUnknown(
    _CallSignalingEventNotifyUnknown event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('_CallSignalingEventNotifyUnknown: $event');
  }

  Future<void> __onCallSignalingEventRegistration(
    _CallSignalingEventRegistration event,
    Emitter<CallState> emit,
  ) async {
    final registration = Registration(status: event.status, code: event.code, reason: event.reason);
    add(_RegistrationChange(registration: registration));
  }

  // WebtritSignalingClient listen handlers

  void _onSignalingStateHandshake(StateHandshake stateHandshake) {
    add(
      _HandshakeSignalingEventState(registration: stateHandshake.registration, linesCount: stateHandshake.lines.length),
    );

    unawaited(
      _assignUserActiveCalls(stateHandshake.userActiveCalls).catchError((e, s) {
        _logger.severe('_onSignalingStateHandshake _assignUserActiveCalls error', e, s);
      }),
    );
    stateHandshake.contactsPresenceInfo.forEach((number, data) {
      unawaited(
        _assignNumberPresence(number, data).catchError((e, s) {
          _logger.severe('_onSignalingStateHandshake _assignNumberPresence error', e, s);
        }),
      );
    });

    unawaited(
      _processHandshakeAsync(stateHandshake).catchError((e, s) {
        _logger.severe('_onSignalingStateHandshake _processHandshakeAsync error', e, s);
      }),
    );
  }

  Future<void> _processHandshakeAsync(StateHandshake stateHandshake) async {
    try {
      // Hang up all active calls that are not associated with any line
      // or guest line, indicating that they are no longer valid.
      //
      // This is needed to drop or retain calls after reconnecting to the signaling server
      activeCallsLoop:
      for (final activeCall in state.activeCalls) {
        // Ignore active calls that are already associated with a line or guest line
        //
        // If you have troubles with line position mismatch replace this with
        // following code that deal with it: https://gist.github.com/digiboridev/f7f1020731e8f247b5891983433bd159
        for (final line in [...stateHandshake.lines, stateHandshake.guestLine]) {
          if (line != null && line.callId == activeCall.callId) {
            continue activeCallsLoop;
          }
        }

        // Handles an outgoing active call that has not yet started, typically initiated
        // by the `continueStartCallIntent` callback of `CallkeepDelegate`.
        //
        // TODO: Implement a dedicated flag to confirm successful execution of
        // OutgoingCallRequest, ensuring reliable outgoing active call state tracking.
        if (activeCall.direction == CallDirection.outgoing &&
            activeCall.acceptedTime == null &&
            activeCall.hungUpTime == null) {
          continue activeCallsLoop;
        }

        _peerConnectionManager.conditionalCompleteError(activeCall.callId, 'Active call Request Terminated');

        add(
          _CallSignalingEvent.hangup(
            line: activeCall.line,
            callId: activeCall.callId,
            code: 487,
            reason: 'Request Terminated',
          ),
        );
      }

      final lines = [...stateHandshake.lines, stateHandshake.guestLine].whereType<Line>();
      final localConnections = await callkeepConnections.getConnections();

      for (final activeLine in lines) {
        // Get the first call event from the call logs, if any
        final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

        if (callEvent != null) {
          // Obtain the corresponding Callkeep connection for the line.
          // Callkeep maintains connection states even if the app's lifecycle has ended.
          final connection = await callkeepConnections.getConnection(callEvent.callId);

          // Check if the Callkeep connection exists and its state is `stateDisconnected`.
          // Indicates that the call has been terminated by the user or system (e.g., due to connectivity issues).
          // Synchronize the signaling state with the local state for such scenarios.
          if (connection?.state == CallkeepConnectionState.stateDisconnected) {
            // Handle outgoing or accepted calls. If the event is `AcceptedEvent` or `ProceedingEvent`,
            // initiate a hang-up request to align the signaling state.
            if (callEvent is AcceptedEvent || callEvent is ProceedingEvent) {
              // Handle outgoing or accepted calls. If the event is `AcceptedEvent` or `ProceedingEvent`,
              // initiate a hang-up request to align the signaling state.
              final hangupRequest = HangupRequest(
                transaction: WebtritSignalingClient.generateTransactionId(),
                line: callEvent.line,
                callId: callEvent.callId,
              );
              await _signalingClient?.execute(hangupRequest).catchError((e, s) {
                callErrorReporter.handle(e, s, '__onCallPerformEventEnded hangupRequest error');
              });

              return;
            } else if (callEvent is IncomingCallEvent) {
              // Handle incoming calls. If the event is `IncomingCallEvent`, send a decline request to update the signaling state accordingly.
              final declineRequest = DeclineRequest(
                transaction: WebtritSignalingClient.generateTransactionId(),
                line: callEvent.line,
                callId: callEvent.callId,
              );
              await _signalingClient?.execute(declineRequest).catchError((e, s) {
                callErrorReporter.handle(e, s, '__onCallPerformEventEnded declineRequest error');
              });
              return;
            }
          }
        }

        if (activeLine.callLogs.length == 1) {
          final singleCallLog = activeLine.callLogs.first;
          if (singleCallLog is CallEventLog && singleCallLog.callEvent is IncomingCallEvent) {
            _onSignalingEvent(singleCallLog.callEvent as IncomingCallEvent);
          }
        }
      }

      // Synchronize the signaling state with the local state for calls.
      // If a local connection exists that is not present in the signaling state, end the call to ensure consistency between the local and signaling states.
      for (var connection in localConnections) {
        if (!lines.map((e) => e.callId).contains(connection.callId)) {
          await callkeep.endCall(connection.callId);
        }
      }
    } catch (e, s) {
      _logger.severe('_processHandshakeAsync error', e, s);
    }
  }

  void _onSignalingEvent(Event event) {
    if (event is IncomingCallEvent) {
      add(
        _CallSignalingEvent.incoming(
          line: event.line,
          callId: event.callId,
          callee: event.callee,
          caller: event.caller,
          callerDisplayName: event.callerDisplayName,
          referredBy: event.referredBy,
          replaceCallId: event.replaceCallId,
          isFocus: event.isFocus,
          jsep: JsepValue.fromOptional(event.jsep),
        ),
      );
    } else if (event is RingingEvent) {
      add(_CallSignalingEvent.ringing(line: event.line, callId: event.callId));
    } else if (event is ProgressEvent) {
      add(
        _CallSignalingEvent.progress(
          line: event.line,
          callId: event.callId,
          callee: event.callee,
          jsep: JsepValue.fromOptional(event.jsep),
        ),
      );
    } else if (event is AcceptedEvent) {
      add(
        _CallSignalingEvent.accepted(
          line: event.line,
          callId: event.callId,
          callee: event.callee,
          jsep: JsepValue.fromOptional(event.jsep),
        ),
      );
    } else if (event is HangupEvent) {
      add(_CallSignalingEvent.hangup(line: event.line, callId: event.callId, code: event.code, reason: event.reason));
    } else if (event is UpdatingCallEvent) {
      add(
        _CallSignalingEvent.updating(
          line: event.line,
          callId: event.callId,
          callee: event.callee,
          caller: event.caller,
          callerDisplayName: event.callerDisplayName,
          referredBy: event.referredBy,
          replaceCallId: event.replaceCallId,
          isFocus: event.isFocus,
          jsep: JsepValue.fromOptional(event.jsep),
        ),
      );
    } else if (event is UpdatedEvent) {
      add(_CallSignalingEvent.updated(line: event.line, callId: event.callId));
    } else if (event is TransferEvent) {
      add(
        _CallSignalingEvent.transfer(
          line: event.line,
          referId: event.referId,
          referTo: event.referTo,
          referredBy: event.referredBy,
          replaceCallId: event.replaceCallId,
        ),
      );
    } else if (event is NotifyEvent) {
      add(switch (event) {
        DialogNotifyEvent event => _CallSignalingEvent.notifyDialog(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          userActiveCalls: event.userActiveCalls,
        ),
        ReferNotifyEvent event => _CallSignalingEvent.notifyRefer(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          state: event.state,
        ),
        PresenceNotifyEvent event => _CallSignalingEvent.notifyPresence(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          number: event.number,
          presenceInfo: event.presenceInfo,
        ),
        UnknownNotifyEvent event => _CallSignalingEvent.notifyUnknown(
          line: event.line,
          callId: event.callId,
          notify: event.notify,
          subscriptionState: event.subscriptionState,
          contentType: event.contentType,
          content: event.content,
        ),
      });
    } else if (event is RegisteringEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.registering));
    } else if (event is RegisteredEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.registered));
    } else if (event is RegistrationFailedEvent) {
      final registrationFailedEvent = _CallSignalingEvent.registration(
        RegistrationStatus.registration_failed,
        code: event.code,
        reason: event.reason,
      );
      add(registrationFailedEvent);
    } else if (event is UnregisteringEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.unregistering));
    } else if (event is UnregisteredEvent) {
      add(const _CallSignalingEvent.registration(RegistrationStatus.unregistered));
    } else if (event is TransferringEvent) {
      add(_CallSignalingEvent.transferring(line: event.line, callId: event.callId));
    } else {
      _logger.warning('unhandled signaling event $event');
    }
  }

  void _onSignalingError(Object error, [StackTrace? stackTrace]) {
    _logger.severe('_onErrorCallback', error, stackTrace);

    /// Important to reconnect signaling client on errors especially on keepalive timeout and pure network issues
    _reconnectInitiated(force: true);
  }

  void _onSignalingDisconnect(int? code, String? reason) {
    add(_SignalingClientEvent.disconnected(code, reason));
  }
}
