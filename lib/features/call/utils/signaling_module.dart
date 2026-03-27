part of '../bloc/call_bloc.dart';

/// Interface that [SignalingModule] uses to interact with the outside world.
///
/// Typed callbacks keep the module decoupled from private BLoC event classes,
/// making it possible to instantiate and test [SignalingModule] independently
/// via a [FakeSignalingModuleDelegate] without constructing a [CallBloc].
abstract interface class SignalingModuleDelegate {
  CallState get currentState;
  bool get isModuleClosed;

  /// Schedules a [_SignalingClientEvent.connectInitiated] on the BLoC event loop.
  void requestConnect();

  /// Schedules a [_SignalingClientEvent.disconnectInitiated] on the BLoC event loop.
  void requestDisconnect();

  /// Schedules a [_SignalingClientEvent.disconnected] on the BLoC event loop.
  void notifyDisconnected(int? code, String? reason);

  /// Called when the signaling client receives a [StateHandshake].
  void onStateHandshake(StateHandshake stateHandshake);

  /// Called when the signaling client receives any [Event].
  void onSignalingEvent(Event event);

  /// Dispatches a registration-change signaling event.
  void dispatchRegistrationChange(RegistrationStatus status, {int? code, String? reason});

  /// Dispatches a complete-call reset for [callId].
  void dispatchCompleteCall(String callId);

  /// Submits a UI notification.
  void showNotification(Notification notification);
}

/// Owns the [WebtritSignalingClient] lifecycle and reconnect timer.
///
/// Lives inside `part of 'call_bloc.dart'` so it shares the library boundary
/// (and thus access to private types such as [_SignalingClientEvent]), but it
/// is a concrete, independently-instantiable class rather than an extension on
/// [CallBloc]. Tests can therefore exercise the connection lifecycle by
/// supplying a [FakeSignalingModuleDelegate] without constructing a full BLoC.
class SignalingModule {
  SignalingModule({
    required String coreUrl,
    required String tenantId,
    required String token,
    required TrustedCertificates trustedCertificates,
    required SignalingClientFactory signalingClientFactory,
    SignalingModuleDelegate? delegate,
  }) : _coreUrl = coreUrl,
       _tenantId = tenantId,
       _token = token,
       _trustedCertificates = trustedCertificates,
       _signalingClientFactory = signalingClientFactory {
    if (delegate != null) _delegate = delegate;
  }

  late SignalingModuleDelegate _delegate;
  final String _coreUrl;
  final String _tenantId;
  final String _token;
  final TrustedCertificates _trustedCertificates;
  final SignalingClientFactory _signalingClientFactory;

  WebtritSignalingClient? _client;
  Timer? _reconnectTimer;

  WebtritSignalingClient? get signalingClient => _client;

  /// Cancels any pending reconnect timer and schedules a new connect attempt
  /// after [delay].  The attempt is skipped when the app is backgrounded,
  /// connectivity is absent, or the signaling client is already connected —
  /// unless [force] is set.
  void reconnect({Duration delay = kSignalingClientFastReconnectDelay, bool force = false}) {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      final appActive = _delegate.currentState.currentAppLifecycleState == AppLifecycleState.resumed;
      final connectionActive = _delegate.currentState.callServiceState.networkStatus != NetworkStatus.none;
      final signalingRemains = _client != null;

      _logger.info(
        'SignalingModule.reconnect timer callback after $delay, '
        'isClosed: ${_delegate.isModuleClosed}, appActive: $appActive, '
        'connectionActive: $connectionActive',
      );

      if (_delegate.isModuleClosed) return;

      if (!appActive && !force) {
        _logger.info('SignalingModule.reconnect: skipped — app not active');
        return;
      }

      if (!connectionActive && !force) {
        _logger.info('SignalingModule.reconnect: skipped — no connectivity');
        return;
      }

      if (signalingRemains && !force) {
        _logger.info('SignalingModule.reconnect: skipped — client already connected');
        return;
      }

      _delegate.requestConnect();
    });
  }

  /// Cancels the reconnect timer and schedules a disconnect.
  void disconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _delegate.requestDisconnect();
  }

  /// Establishes a new [WebtritSignalingClient] connection.
  ///
  /// Called from the BLoC's [_SignalingClientEvent.connectInitiated] handler.
  /// [emit] and [isEmitDone] are forwarded from the BLoC's [Emitter] so that
  /// state updates reach the BLoC stream while keeping this class free of
  /// direct Bloc/Emitter dependencies (which simplifies testing).
  Future<void> performConnect(void Function(CallState) emit, bool Function() isEmitDone) async {
    emit(
      _delegate.currentState.copyWith(
        callServiceState: _delegate.currentState.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.connecting,
          lastSignalingClientDisconnectError: null,
        ),
      ),
    );

    try {
      {
        final signalingClient = _client;
        if (signalingClient != null) {
          _client = null;
          await signalingClient.disconnect();
        }
      }

      if (isEmitDone()) return;

      final signalingUrl = WebtritSignalingUtils.parseCoreUrlToSignalingUrl(_coreUrl);

      final signalingClient = await _signalingClientFactory(
        url: signalingUrl,
        tenantId: _tenantId,
        token: _token,
        connectionTimeout: kSignalingClientConnectionTimeout,
        certs: _trustedCertificates,
        force: true,
      );

      if (isEmitDone()) {
        await signalingClient.disconnect(SignalingDisconnectCode.goingAway.code);
        return;
      }

      signalingClient.listen(
        onStateHandshake: _onStateHandshake,
        onEvent: _onEvent,
        onError: _onError,
        onDisconnect: _onDisconnect,
      );
      _client = signalingClient;

      emit(
        _delegate.currentState.copyWith(
          callServiceState: _delegate.currentState.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.connect,
            lastSignalingClientConnectError: null,
            lastSignalingDisconnectCode: null,
          ),
        ),
      );
    } on Error {
      rethrow;
    } catch (e, s) {
      if (isEmitDone()) return;
      _logger.warning('SignalingModule.performConnect', e, s);

      // toString is important to compare low level exceptions like SocketException, HttpException, TlsException etc.
      final repeated =
          _delegate.currentState.callServiceState.lastSignalingClientConnectError.toString() == e.toString();
      if (!repeated) {
        _delegate.showNotification(const SignalingConnectFailedNotification());
      }

      emit(
        _delegate.currentState.copyWith(
          callServiceState: _delegate.currentState.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.failure,
            lastSignalingClientConnectError: e,
          ),
        ),
      );

      reconnect(delay: kSignalingClientReconnectDelay);
    }
  }

  /// Tears down the current [WebtritSignalingClient] connection.
  ///
  /// Called from the BLoC's [_SignalingClientEvent.disconnectInitiated] handler.
  Future<void> performDisconnect(void Function(CallState) emit, bool Function() isEmitDone) async {
    emit(
      _delegate.currentState.copyWith(
        callServiceState: _delegate.currentState.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnecting,
          lastSignalingClientConnectError: null,
        ),
      ),
    );

    try {
      final signalingClient = _client;
      if (signalingClient != null) {
        _client = null;
        await signalingClient.disconnect();
      }

      if (isEmitDone()) return;

      emit(
        _delegate.currentState.copyWith(
          callServiceState: _delegate.currentState.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.disconnect,
            lastSignalingClientDisconnectError: null,
            lastSignalingDisconnectCode: null,
          ),
        ),
      );
    } on Error {
      rethrow;
    } catch (e, s) {
      if (isEmitDone()) return;
      _logger.warning('SignalingModule.performDisconnect', e, s);

      emit(
        _delegate.currentState.copyWith(
          callServiceState: _delegate.currentState.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.failure,
            lastSignalingClientDisconnectError: e,
          ),
        ),
      );
    }
  }

  /// Processes a server-initiated disconnect (WebSocket close frame).
  ///
  /// Called from the BLoC's [_SignalingClientEvent.disconnected] handler.
  Future<void> handleDisconnected(
    int? code,
    String? reason,
    void Function(CallState) emit,
    bool Function() isEmitDone,
  ) async {
    final disconnectCode = SignalingDisconnectCode.values.byCode(code ?? -1);
    final repeated = code == _delegate.currentState.callServiceState.lastSignalingDisconnectCode;

    CallState newState = _delegate.currentState.copyWith(
      callServiceState: _delegate.currentState.callServiceState.copyWith(
        signalingClientStatus: SignalingClientStatus.disconnect,
        lastSignalingDisconnectCode: code,
      ),
    );
    Notification? notificationToShow;
    bool shouldReconnect = true;

    if (disconnectCode == SignalingDisconnectCode.appUnregisteredError) {
      _delegate.dispatchRegistrationChange(RegistrationStatus.unregistered);

      newState = _delegate.currentState.copyWith(
        callServiceState: _delegate.currentState.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: code,
        ),
      );
    } else if (disconnectCode == SignalingDisconnectCode.requestCallIdError) {
      _delegate.currentState.activeCalls
          .where((e) => e.wasHungUp)
          .forEach((e) => _delegate.dispatchCompleteCall(e.callId));
    } else if (disconnectCode == SignalingDisconnectCode.controllerExitError) {
      _logger.info('handleDisconnected: skipping expected system unregistration notification');
    } else if (disconnectCode == SignalingDisconnectCode.controllerForceAttachClose) {
      // Server closed the connection because a duplicate signaling session was detected
      // (e.g. background push isolate still connected when main engine reconnects).
      // Reconnect silently: don't set lastSignalingDisconnectCode so connectIssue is never shown.
      _logger.warning(
        'handleDisconnected: signaling race detected — '
        'server force-closed duplicate session (code=$code, reason="$reason"). '
        'Reconnecting silently without showing connectIssue.',
      );
      newState = _delegate.currentState.copyWith(
        callServiceState: _delegate.currentState.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: null,
        ),
      );
    } else if (disconnectCode == SignalingDisconnectCode.sessionMissedError) {
      notificationToShow = const SignalingSessionMissedNotification();
    } else if (disconnectCode.type == SignalingDisconnectCodeType.auxiliary) {
      _logger.info('handleDisconnected: socket goes down');

      /// Fun facts
      /// - in case of network disconnection on android this section is evaluating faster than [_onConnectivityResultChanged].
      /// - also in case of network disconnection error code is protocolError instead of normalClosure by unknown reason
      /// so we need to handle it here as regular disconnection
      if (disconnectCode == SignalingDisconnectCode.protocolError) {
        shouldReconnect = false;
      } else {
        notificationToShow = SignalingDisconnectNotification(
          knownCode: disconnectCode,
          systemCode: code,
          systemReason: reason,
        );
      }
    } else {
      notificationToShow = SignalingDisconnectNotification(
        knownCode: disconnectCode,
        systemCode: code,
        systemReason: reason,
      );
    }

    emit(newState);
    _client = null;
    if (notificationToShow != null && !repeated) _delegate.showNotification(notificationToShow);
    if (shouldReconnect) {
      final reconnectDelay = disconnectCode == SignalingDisconnectCode.controllerForceAttachClose
          ? kSignalingClientFastReconnectDelay
          : kSignalingClientReconnectDelay;
      reconnect(delay: reconnectDelay);
    }
  }

  /// Cancels the reconnect timer and disconnects the signaling client.
  Future<void> dispose() async {
    _reconnectTimer?.cancel();
    final client = _client;
    _client = null;
    await client?.disconnect();
  }

  void _onStateHandshake(StateHandshake stateHandshake) => _delegate.onStateHandshake(stateHandshake);

  void _onEvent(Event event) => _delegate.onSignalingEvent(event);

  void _onError(Object error, [StackTrace? stackTrace]) {
    _logger.severe('SignalingModule._onError', error, stackTrace);

    /// Important to reconnect on errors, especially on keepalive timeout and network issues.
    reconnect(force: true);
  }

  void _onDisconnect(int? code, String? reason) => _delegate.notifyDisconnected(code, reason);
}

extension _SignalingHandlers on CallBloc {
  // Processing handshake signaling events

  Future<void> _onHandshakeSignalingEventState(_HandshakeSignalingEventState event, Emitter<CallState> emit) async {
    emit(state.copyWith(linesCount: event.linesCount));

    add(_RegistrationChange(registration: event.registration));
  }

  // Processing call signaling events

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
      // TODO: implement correct incoming call hangup (take into account that _signalingModule.signalingClient could be disconnected)
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
    } on Error {
      rethrow;
    } catch (e, s) {
      _logger.warning('__onCallSignalingEventHangup', e, s);
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

            await _signalingModule.signalingClient?.execute(
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
    } on Error {
      rethrow;
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

  // TODO(Vlad): extract mapper, find better naming
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
              final hangupFuture = _signalingModule.signalingClient?.execute(hangupRequest);
              await hangupFuture?.catchError((e, s) {
                callErrorReporter.handle(e, s, '__onCallPerformEventEnded hangupRequest error');
              });

              continue;
            } else if (callEvent is IncomingCallEvent) {
              // Handle incoming calls. If the event is `IncomingCallEvent`, send a decline request to update the signaling state accordingly.
              final declineRequest = DeclineRequest(
                transaction: WebtritSignalingClient.generateTransactionId(),
                line: callEvent.line,
                callId: callEvent.callId,
              );
              final declineFuture = _signalingModule.signalingClient?.execute(declineRequest);
              await declineFuture?.catchError((e, s) {
                callErrorReporter.handle(e, s, '__onCallPerformEventEnded declineRequest error');
              });
              continue;
            }
          }
        }

        if (activeLine.callLogs.length == 1) {
          final singleCallLog = activeLine.callLogs.first;
          if (singleCallLog is CallEventLog && singleCallLog.callEvent is IncomingCallEvent) {
            _onSignalingEventMapper(singleCallLog.callEvent as IncomingCallEvent);
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
    } on Error {
      rethrow;
    } catch (e, s) {
      _logger.severe('_processHandshakeAsync error', e, s);
    }
  }

  void _onSignalingEventMapper(Event event) {
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
      add(
        _CallSignalingEvent.registration(
          RegistrationStatus.registration_failed,
          code: event.code,
          reason: event.reason,
        ),
      );
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
}
