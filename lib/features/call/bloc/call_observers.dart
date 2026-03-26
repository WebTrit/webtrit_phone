part of 'call_bloc.dart';

extension _CallObservers on CallBloc {
  void _syncCallkeepSignalingStatus(Change<CallState> change) {
    callkeepConnections.updateActivitySignalingStatus(
      change.nextState.callServiceState.signalingClientStatus.toCallkeepSignalingStatus(),
    );
  }

  // TODO: add detailed explanation of the following code and why it is necessary to initialize signaling client in background
  void _handleBackgroundConnectivity(Change<CallState> change) {
    if (change.currentState.isActive == change.nextState.isActive) return;

    final appLifecycleState = change.nextState.currentAppLifecycleState;
    final appInactive =
        appLifecycleState == AppLifecycleState.paused ||
        appLifecycleState == AppLifecycleState.detached ||
        appLifecycleState == AppLifecycleState.inactive;
    final hasActiveCalls = change.nextState.isActive;
    final connected = _signalingModule.signalingClient != null;

    if (appInactive) {
      if (hasActiveCalls && !connected) {
        _signalingModule.reconnect(delay: kSignalingClientFastReconnectDelay, force: true);
      }
      if (!hasActiveCalls && connected) {
        _signalingModule.disconnect();
      }
    }
  }

  void _syncPeerConnections(Change<CallState> change) {
    final currentActiveCallUuids = Set.from(change.currentState.activeCalls.map((e) => e.callId));
    final nextActiveCallUuids = Set.from(change.nextState.activeCalls.map((e) => e.callId));

    for (final removeUuid in currentActiveCallUuids.difference(nextActiveCallUuids)) {
      // Disposal is intentionally not awaited to avoid blocking the Bloc processing loop.
      // The PeerConnectionManager implements an internal "disposal barrier" (via _pendingDisposals)
      // which guarantees that any subsequent createPeerConnection() for this CallId will
      // automatically wait for this disposal to finish before proceeding.
      _peerConnectionManager.disposePeerConnection(removeUuid).catchError((error, stackTrace) {
        _logger.warning('Error disposing peer connection for $removeUuid', error, stackTrace);
      });
    }

    for (final addUuid in nextActiveCallUuids.difference(currentActiveCallUuids)) {
      _peerConnectionManager.add(addUuid);
    }
  }

  void _logProcessingStatusTransitions(Change<CallState> change) {
    final currentProcessingStatuses = Set.from(
      change.currentState.activeCalls.map((e) => '${e.line}:${e.processingStatus.name}'),
    ).join(', ');
    final nextProcessingStatuses = Set.from(
      change.nextState.activeCalls.map((e) => '${e.line}:${e.processingStatus.name}'),
    ).join(', ');
    if (currentProcessingStatuses != nextProcessingStatuses) {
      _logger.info(() => 'status transitions: $currentProcessingStatuses -> $nextProcessingStatuses');
    }
  }

  /// RegistrationStatus can be null if the signaling state was not yet fully
  /// initialized. This scenario is particularly relevant when a call is
  /// triggered before the app is fully active, such as via
  /// [CallkeepDelegate.continueStartCallIntent] (e.g. from phone recents).
  void _handleRegistrationChange(Change<CallState> change) {
    final newRegistration = change.nextState.callServiceState.registration;
    final previousRegistration = change.currentState.callServiceState.registration;

    if (newRegistration == previousRegistration || newRegistration == null) return;

    _logger.fine('_onRegistrationChange: $newRegistration to $previousRegistration');

    final newRegistrationStatus = newRegistration.status;
    final previousRegistrationStatus = previousRegistration?.status;

    if (previousRegistrationStatus?.isRegistered == false && newRegistrationStatus.isRegistered == true) {
      presenceSettingsRepository.resetLastSettingsSync();
      submitNotification(AppOnlineNotification());
    }

    if (previousRegistrationStatus?.isRegistered == true && newRegistrationStatus.isRegistered == false) {
      submitNotification(AppOfflineNotification());
    }

    if (newRegistrationStatus.isFailed == true || newRegistrationStatus.isUnregistered == true) {
      add(const _ResetStateEvent.completeCalls());
    }

    if (newRegistrationStatus.isFailed == true) {
      submitNotification(
        SipRegistrationFailedNotification(
          knownCode: SignalingRegistrationFailedCode.values.byCode(newRegistration.code),
          systemCode: newRegistration.code,
          systemReason: newRegistration.reason,
        ),
      );
    }
  }

  void _syncLinesState(Change<CallState> change) {
    final linesCount = change.nextState.linesCount;
    final activeCalls = change.nextState.activeCalls;
    final List<LineState> mainLinesState = [];
    for (var i = 0; i < linesCount; i++) {
      final inUse = activeCalls.any((e) => e.line == i);
      mainLinesState.add(inUse ? LineState.inUse : LineState.idle);
    }
    final guestLineInUse = activeCalls.any((e) => e.line == null);
    final guestLineState = guestLineInUse ? LineState.inUse : LineState.idle;

    linesStateRepository.setState(LinesState(mainLines: mainLinesState, guestLine: guestLineState));
  }

  void _handleCallEndedCallback(Change<CallState> change) {
    if (change.nextState.activeCalls.length < change.currentState.activeCalls.length) {
      onCallEnded?.call();
    }
  }

  void _handleCallLifecycleTransitions({
    required List<ActiveCall> previousCalls,
    required List<ActiveCall> currentCalls,
  }) {
    _audioDeviceManager.handleCallListChange(wasEmpty: previousCalls.isEmpty, isEmpty: currentCalls.isEmpty);
  }

  void _handleSignalingSessionError({required CallServiceState previous, required CallServiceState current}) {
    final signalingChanged =
        previous.signalingClientStatus != current.signalingClientStatus ||
        previous.lastSignalingDisconnectCode != current.lastSignalingDisconnectCode;

    if (!signalingChanged) return;

    if (current.signalingClientStatus == SignalingClientStatus.disconnect &&
        current.lastSignalingDisconnectCode is int) {
      final code = SignalingDisconnectCode.values.byCode(current.lastSignalingDisconnectCode as int);

      if (code == SignalingDisconnectCode.sessionMissedError) {
        _logger.info('Signaling session listener: session is missing ${current.lastSignalingDisconnectCode}');

        unawaited(_notifyAccountErrorSafely());
        onSessionInvalidated();
      }
    }
  }

  // TODO: Consider moving this method to a separate repository
  Future<void> _notifyAccountErrorSafely() async {
    try {
      await userRepository.getRemoteInfo();
    } on RequestFailure catch (e) {
      final errorCode = AccountErrorCode.values.firstWhereOrNull((it) => it.value == e.error?.code);
      _logger.warning('Account error code: $errorCode');

      if (errorCode != null) {
        submitNotification(AccountErrorNotification(errorCode));
      } else {
        _logger.fine('Account error code not mapped: ${e.error?.code}', e);
      }
    } on Error {
      rethrow;
    } catch (e, st) {
      _logger.warning('Unexpected error during account info refresh', e, st);
    }
  }
}
