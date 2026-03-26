part of 'call_bloc.dart';

extension _TransferCoordinator on CallBloc {
  Future<void> _onCallControlEventBlindTransferInitiated(
    _CallControlEventBlindTransferInitiated event,
    Emitter<CallState> emit,
  ) async {
    final isSpeakerOn = state.audioDevice?.type == CallAudioDeviceType.speaker;

    await __onCallControlEventSetHeld(_CallControlEventSetHeld(event.callId, true), emit);

    emit(
      state.copyWith(minimized: true).copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(
          transfer: const Transfer.blindTransferInitiated(),
          speakerOnBeforeMinimize: isSpeakerOn,
        );
      }),
    );

    await callkeep.reportUpdateCall(event.callId, proximityEnabled: state.shouldListenToProximity);
  }

  Future<void> _onCallControlEventAttendedTransferInitiated(
    _CallControlEventAttendedTransferInitiated event,
    Emitter<CallState> emit,
  ) async {
    final isSpeakerOn = state.audioDevice?.type == CallAudioDeviceType.speaker;

    var newState = state.copyWith(minimized: true);

    newState = newState.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(speakerOnBeforeMinimize: isSpeakerOn);
    });

    emit(newState);

    await __onCallControlEventSetHeld(_CallControlEventSetHeld(event.callId, true), emit);
  }

  Future<void> _onCallControlEventBlindTransferSubmitted(
    _CallControlEventBlindTransferSubmitted event,
    Emitter<CallState> emit,
  ) async {
    final activeCallBlindTransferInitiated = state.activeCalls.blindTransferInitiated;
    final currentCall = state.activeCalls.current;

    final line = activeCallBlindTransferInitiated?.line ?? currentCall.line;
    final callId = activeCallBlindTransferInitiated?.callId ?? currentCall.callId;

    // Check if the number is already in active calls
    final isNumberAlreadyConnected = state.activeCalls.any((call) => call.handle.value == event.number);
    if (isNumberAlreadyConnected) {
      submitNotification(ActiveLineBlindTransferWarningNotification());
      return;
    }

    try {
      final transferRequest = TransferRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: line,
        callId: callId,
        number: event.number,
      );

      await _signalingClient?.execute(transferRequest);

      var newState = state.copyWith(minimized: false);
      newState = newState.copyWithMappedActiveCall(callId, (activeCall) {
        final transfer = Transfer.blindTransferTransferSubmitted(toNumber: event.number);
        return activeCall.copyWith(transfer: transfer);
      });
      emit(newState);

      await callkeep.reportUpdateCall(callId, proximityEnabled: state.shouldListenToProximity);

      final callBeingTransferred = state.retrieveActiveCall(callId);

      if (callBeingTransferred?.speakerOnBeforeMinimize == true) {
        add(CallControlEvent.audioDeviceSet(callId, state.availableAudioDevices.getSpeaker));
      }

      // After request successfully submitted, the transfer flow continues via
      // TransferringEvent from Janus, handled in [__onCallSignalingEventTransferring],
      // which marks the call as transfer-in-progress.
    } catch (e, s) {
      callErrorReporter.handle(e, s, '_onCallControlEventBlindTransferSubmitted request error:');
    }
  }

  Future<void> _onCallControlEventAttendedTransferSubmitted(
    _CallControlEventAttendedTransferSubmitted event,
    Emitter<CallState> emit,
  ) async {
    final referorCall = event.referorCall;
    final replaceCall = event.replaceCall;

    try {
      final transferRequest = TransferRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: referorCall.line,
        callId: referorCall.callId,
        number: replaceCall.handle.normalizedValue(),
        replaceCallId: replaceCall.callId,
      );

      await _signalingClient?.execute(transferRequest);

      emit(
        state.copyWithMappedActiveCall(referorCall.callId, (activeCall) {
          final transfer = Transfer.attendedTransferTransferSubmitted(replaceCallId: replaceCall.callId);
          return activeCall.copyWith(transfer: transfer);
        }),
      );

      // After request successfully submitted, the transfer flow continues via
      // TransferringEvent from Janus, handled in [__onCallSignalingEventTransferring],
      // which marks the referor call as transfer-in-progress.
    } catch (e, s) {
      callErrorReporter.handle(e, s, '_onCallControlEventAttendedTransferSubmitted request error:');
    }
  }

  Future<void> _onCallControlEventAttendedRequestApproved(
    _CallControlEventAttendedRequestApproved event,
    Emitter<CallState> emit,
  ) async {
    final referId = event.referId;
    final referTo = event.referTo;

    final newHandle = CallkeepHandle.number(referTo);

    final callId = WebtritSignalingClient.generateCallId();

    final error = await callkeep.startCall(callId, newHandle, hasVideo: false, proximityEnabled: true);

    if (error != null) {
      _logger.warning('__onCallControlEventStarted error: $error');
      submitNotification(ErrorMessageNotification(error.toString()));
      return;
    }

    final newCall = ActiveCall(
      direction: CallDirection.outgoing,
      line: state.retrieveIdleLine() ?? _kUndefinedLine,
      callId: callId,
      handle: newHandle,
      fromReferId: referId,
      video: false,
      createdTime: clock.now(),
      processingStatus: CallProcessingStatus.outgoingCreatedFromRefer,
    );

    emit(state.copyWithPushActiveCall(newCall).copyWith(minimized: false));
  }

  Future<void> _onCallControlEventAttendedRequestDeclined(
    _CallControlEventAttendedRequestDeclined event,
    Emitter<CallState> emit,
  ) async {
    final referId = event.referId;
    final callId = event.callId;

    final call = state.retrieveActiveCall(callId);
    if (call == null) return;

    try {
      final declineRequest = DeclineRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: call.line,
        callId: callId,
        referId: referId,
      );

      await _signalingClient?.execute(declineRequest);

      emit(
        state.copyWithMappedActiveCall(callId, (activeCall) {
          return activeCall.copyWith(transfer: null);
        }),
      );
    } catch (e, s) {
      callErrorReporter.handle(e, s, '_onCallControlEventAttendedRequestDeclined request error:');
    }
  }
}
