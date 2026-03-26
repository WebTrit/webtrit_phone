part of 'call_bloc.dart';

/// Owns all attended and blind transfer flows for [CallBloc].
///
/// Receives static dependencies via constructor and runtime state/event access
/// via [getCurrentState] / [addEvent] callbacks, which keeps the class
/// independently instantiable and testable without a full [CallBloc].
///
/// Methods receive [void Function(CallState) emit] rather than
/// [Emitter<CallState>] so that tests can supply a plain lambda instead of
/// a real Bloc emitter — matching the pattern used in [SignalingModule].
class TransferCoordinatorImpl {
  TransferCoordinatorImpl({
    required SignalingModule signalingModule,
    required Callkeep callkeep,
    required CallErrorReporter callErrorReporter,
    required void Function(Notification) submitNotification,
    required CallState Function() getCurrentState,
    required void Function(CallEvent) addEvent,
  }) : _signalingModule = signalingModule,
       _callkeep = callkeep,
       _callErrorReporter = callErrorReporter,
       _submitNotification = submitNotification,
       _getCurrentState = getCurrentState,
       _addEvent = addEvent;

  final SignalingModule _signalingModule;
  final Callkeep _callkeep;
  final CallErrorReporter _callErrorReporter;
  final void Function(Notification) _submitNotification;
  final CallState Function() _getCurrentState;
  final void Function(CallEvent) _addEvent;

  Future<void> _onBlindTransferInitiated(
    _CallControlEventBlindTransferInitiated event,
    void Function(CallState) emit,
  ) async {
    final isSpeakerOn = _getCurrentState().audioDevice?.type == CallAudioDeviceType.speaker;

    final heldError = await _callkeep.setHeld(event.callId, onHold: true);
    if (heldError != null) _logger.warning('onBlindTransferInitiated setHeld error: $heldError');

    emit(
      _getCurrentState().copyWith(minimized: true).copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(
          transfer: const Transfer.blindTransferInitiated(),
          speakerOnBeforeMinimize: isSpeakerOn,
        );
      }),
    );

    await _callkeep.reportUpdateCall(event.callId, proximityEnabled: _getCurrentState().shouldListenToProximity);
  }

  Future<void> _onAttendedTransferInitiated(
    _CallControlEventAttendedTransferInitiated event,
    void Function(CallState) emit,
  ) async {
    final state = _getCurrentState();
    final isSpeakerOn = state.audioDevice?.type == CallAudioDeviceType.speaker;

    emit(
      state.copyWith(minimized: true).copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(speakerOnBeforeMinimize: isSpeakerOn);
      }),
    );

    final heldError = await _callkeep.setHeld(event.callId, onHold: true);
    if (heldError != null) _logger.warning('onAttendedTransferInitiated setHeld error: $heldError');
  }

  Future<void> _onBlindTransferSubmitted(
    _CallControlEventBlindTransferSubmitted event,
    void Function(CallState) emit,
  ) async {
    final state = _getCurrentState();
    final activeCallBlindTransferInitiated = state.activeCalls.blindTransferInitiated;
    final currentCall = state.activeCalls.current;

    final line = activeCallBlindTransferInitiated?.line ?? currentCall.line;
    final callId = activeCallBlindTransferInitiated?.callId ?? currentCall.callId;

    final isNumberAlreadyConnected = state.activeCalls.any((call) => call.handle.normalizedValue() == event.number);
    if (isNumberAlreadyConnected) {
      _submitNotification(ActiveLineBlindTransferWarningNotification());
      return;
    }

    try {
      final transferRequest = TransferRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: line,
        callId: callId,
        number: event.number,
      );

      await _signalingModule.signalingClient?.execute(transferRequest);

      var newState = _getCurrentState().copyWith(minimized: false);
      newState = newState.copyWithMappedActiveCall(callId, (activeCall) {
        return activeCall.copyWith(transfer: Transfer.blindTransferTransferSubmitted(toNumber: event.number));
      });
      emit(newState);

      await _callkeep.reportUpdateCall(callId, proximityEnabled: _getCurrentState().shouldListenToProximity);

      final callBeingTransferred = _getCurrentState().retrieveActiveCall(callId);
      if (callBeingTransferred?.speakerOnBeforeMinimize == true) {
        _addEvent(CallControlEvent.audioDeviceSet(callId, _getCurrentState().availableAudioDevices.getSpeaker));
      }
    } on Error {
      rethrow;
    } catch (e, s) {
      _callErrorReporter.handle(e, s, 'onBlindTransferSubmitted request error:');
    }
  }

  Future<void> _onAttendedTransferSubmitted(
    _CallControlEventAttendedTransferSubmitted event,
    void Function(CallState) emit,
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

      await _signalingModule.signalingClient?.execute(transferRequest);

      emit(
        _getCurrentState().copyWithMappedActiveCall(referorCall.callId, (activeCall) {
          return activeCall.copyWith(
            transfer: Transfer.attendedTransferTransferSubmitted(replaceCallId: replaceCall.callId),
          );
        }),
      );
    } on Error {
      rethrow;
    } catch (e, s) {
      _callErrorReporter.handle(e, s, 'onAttendedTransferSubmitted request error:');
    }
  }

  Future<void> _onAttendedRequestApproved(
    _CallControlEventAttendedRequestApproved event,
    void Function(CallState) emit,
  ) async {
    final referId = event.referId;
    final referTo = event.referTo;

    final newHandle = CallkeepHandle.number(referTo);
    final callId = WebtritSignalingClient.generateCallId();

    final error = await _callkeep.startCall(callId, newHandle, hasVideo: false, proximityEnabled: true);

    if (error != null) {
      _logger.warning('onAttendedRequestApproved startCall error: $error');
      _submitNotification(ErrorMessageNotification(error.toString()));
      return;
    }

    final newCall = ActiveCall(
      direction: CallDirection.outgoing,
      line: _getCurrentState().retrieveIdleLine() ?? _kUndefinedLine,
      callId: callId,
      handle: newHandle,
      fromReferId: referId,
      video: false,
      createdTime: clock.now(),
      processingStatus: CallProcessingStatus.outgoingCreatedFromRefer,
    );

    emit(_getCurrentState().copyWithPushActiveCall(newCall).copyWith(minimized: false));
  }

  Future<void> _onAttendedRequestDeclined(
    _CallControlEventAttendedRequestDeclined event,
    void Function(CallState) emit,
  ) async {
    final state = _getCurrentState();
    final call = state.retrieveActiveCall(event.callId);
    if (call == null) return;

    try {
      final declineRequest = DeclineRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: call.line,
        callId: event.callId,
        referId: event.referId,
      );

      await _signalingModule.signalingClient?.execute(declineRequest);

      emit(
        _getCurrentState().copyWithMappedActiveCall(event.callId, (activeCall) {
          return activeCall.copyWith(transfer: null);
        }),
      );
    } on Error {
      rethrow;
    } catch (e, s) {
      _callErrorReporter.handle(e, s, 'onAttendedRequestDeclined request error:');
    }
  }
}
