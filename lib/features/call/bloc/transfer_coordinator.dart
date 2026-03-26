part of 'call_bloc.dart';

final _transferLogger = Logger('TransferCoordinatorImpl');

/// Minimal interface that [TransferCoordinatorImpl] needs from [CallBloc] at
/// runtime. The static dependencies (callkeep, signalingModule, etc.) are
/// provided at construction time and do not change.
abstract interface class _TransferCoordinatorDelegate {
  CallState get currentState;

  void addTransferCallEvent(CallEvent event);
}

/// Handles all transfer-related [CallControlEvent] sub-types.
///
/// Receives static dependencies at construction and is wired to [CallBloc] via
/// [_delegate], set in [CallBloc]'s constructor body with the cascade pattern
/// (`transfer.._delegate = this`).
class TransferCoordinatorImpl {
  TransferCoordinatorImpl({
    required SignalingModule signalingModule,
    required Callkeep callkeep,
    required CallErrorReporter callErrorReporter,
    required void Function(Notification) submitNotification,
  }) : _signalingModule = signalingModule,
       _callkeep = callkeep,
       _callErrorReporter = callErrorReporter,
       _submitNotification = submitNotification;

  final SignalingModule _signalingModule;
  final Callkeep _callkeep;
  final CallErrorReporter _callErrorReporter;
  final void Function(Notification) _submitNotification;

  late _TransferCoordinatorDelegate _delegate;

  // ---------------------------------------------------------------------------
  // Handlers — called from CallBloc._onCallControlEvent
  // ---------------------------------------------------------------------------

  Future<void> onBlindTransferInitiated(String callId, Emitter<CallState> emit) async {
    final isSpeakerOn = _delegate.currentState.audioDevice?.type == CallAudioDeviceType.speaker;

    final holdError = await _callkeep.setHeld(callId, onHold: true);
    if (holdError != null) _transferLogger.warning('onBlindTransferInitiated setHeld error: $holdError');

    emit(
      _delegate.currentState.copyWith(minimized: true).copyWithMappedActiveCall(callId, (activeCall) {
        return activeCall.copyWith(
          transfer: const Transfer.blindTransferInitiated(),
          speakerOnBeforeMinimize: isSpeakerOn,
        );
      }),
    );

    await _callkeep.reportUpdateCall(callId, proximityEnabled: _delegate.currentState.shouldListenToProximity);
  }

  Future<void> onAttendedTransferInitiated(String callId, Emitter<CallState> emit) async {
    final isSpeakerOn = _delegate.currentState.audioDevice?.type == CallAudioDeviceType.speaker;

    var newState = _delegate.currentState.copyWith(minimized: true);
    newState = newState.copyWithMappedActiveCall(callId, (activeCall) {
      return activeCall.copyWith(speakerOnBeforeMinimize: isSpeakerOn);
    });
    emit(newState);

    final holdError = await _callkeep.setHeld(callId, onHold: true);
    if (holdError != null) _transferLogger.warning('onAttendedTransferInitiated setHeld error: $holdError');
  }

  Future<void> onBlindTransferSubmitted(String number, Emitter<CallState> emit) async {
    final currentState = _delegate.currentState;
    final activeCallBlindTransferInitiated = currentState.activeCalls.blindTransferInitiated;
    final currentCall = currentState.activeCalls.current;

    final line = activeCallBlindTransferInitiated?.line ?? currentCall.line;
    final callId = activeCallBlindTransferInitiated?.callId ?? currentCall.callId;

    final isNumberAlreadyConnected = currentState.activeCalls.any((call) => call.handle.normalizedValue() == number);
    if (isNumberAlreadyConnected) {
      _submitNotification(ActiveLineBlindTransferWarningNotification());
      return;
    }

    try {
      final transferRequest = TransferRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: line,
        callId: callId,
        number: number,
      );

      await _signalingModule.signalingClient?.execute(transferRequest);

      var newState = _delegate.currentState.copyWith(minimized: false);
      newState = newState.copyWithMappedActiveCall(callId, (activeCall) {
        final transfer = Transfer.blindTransferTransferSubmitted(toNumber: number);
        return activeCall.copyWith(transfer: transfer);
      });
      emit(newState);

      await _callkeep.reportUpdateCall(callId, proximityEnabled: _delegate.currentState.shouldListenToProximity);

      final callBeingTransferred = _delegate.currentState.retrieveActiveCall(callId);
      if (callBeingTransferred?.speakerOnBeforeMinimize == true) {
        _delegate.addTransferCallEvent(
          CallControlEvent.audioDeviceSet(callId, _delegate.currentState.availableAudioDevices.getSpeaker),
        );
      }
    } catch (e, s) {
      _callErrorReporter.handle(e, s, 'onBlindTransferSubmitted request error:');
    }
  }

  Future<void> onAttendedTransferSubmitted(
    ActiveCall referorCall,
    ActiveCall replaceCall,
    Emitter<CallState> emit,
  ) async {
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
        _delegate.currentState.copyWithMappedActiveCall(referorCall.callId, (activeCall) {
          final transfer = Transfer.attendedTransferTransferSubmitted(replaceCallId: replaceCall.callId);
          return activeCall.copyWith(transfer: transfer);
        }),
      );
    } catch (e, s) {
      _callErrorReporter.handle(e, s, 'onAttendedTransferSubmitted request error:');
    }
  }

  Future<void> onAttendedRequestApproved(String referId, String referTo, Emitter<CallState> emit) async {
    final newHandle = CallkeepHandle.number(referTo);
    final callId = WebtritSignalingClient.generateCallId();

    final error = await _callkeep.startCall(callId, newHandle, hasVideo: false, proximityEnabled: true);

    if (error != null) {
      _transferLogger.warning('onAttendedRequestApproved startCall error: $error');
      _submitNotification(ErrorMessageNotification(error.toString()));
      return;
    }

    final currentState = _delegate.currentState;
    final newCall = ActiveCall(
      direction: CallDirection.outgoing,
      line: currentState.retrieveIdleLine() ?? _kUndefinedLine,
      callId: callId,
      handle: newHandle,
      fromReferId: referId,
      video: false,
      createdTime: clock.now(),
      processingStatus: CallProcessingStatus.outgoingCreatedFromRefer,
    );

    emit(currentState.copyWithPushActiveCall(newCall).copyWith(minimized: false));
  }

  Future<void> onAttendedRequestDeclined(String callId, String referId, Emitter<CallState> emit) async {
    final call = _delegate.currentState.retrieveActiveCall(callId);
    if (call == null) return;

    try {
      final declineRequest = DeclineRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: call.line,
        callId: callId,
        referId: referId,
      );

      await _signalingModule.signalingClient?.execute(declineRequest);

      emit(
        _delegate.currentState.copyWithMappedActiveCall(callId, (activeCall) {
          return activeCall.copyWith(transfer: null);
        }),
      );
    } catch (e, s) {
      _callErrorReporter.handle(e, s, 'onAttendedRequestDeclined request error:');
    }
  }
}
