import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' hide Notification;

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:clock/clock.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/models/models.dart';

import '../extensions/extensions.dart';
import '../models/models.dart';
import '../services/services.dart';

export 'package:webtrit_callkeep/webtrit_callkeep.dart' show CallkeepHandle, CallkeepHandleType;

part 'call_bloc.freezed.dart';

part 'call_event.dart';

part 'call_state.dart';

const int _kUndefinedLine = -1;

final _logger = Logger('CallBloc');

class CallBloc extends Bloc<CallEvent, CallState> with WidgetsBindingObserver implements CallkeepDelegate {
  final String coreUrl;
  final String tenantId;
  final String token;
  final TrustedCertificates trustedCertificates;

  final CallLogsRepository callLogsRepository;
  final NotificationsBloc notificationsBloc;

  final Callkeep callkeep;
  final CallkeepConnections callkeepConnections;

  final SDPMunger? sdpMunger;

  StreamSubscription<List<ConnectivityResult>>? _connectivityChangedSubscription;
  StreamSubscription<PendingCall>? _pendingCallHandlerSubscription;

  WebtritSignalingClient? _signalingClient;
  Timer? _signalingClientReconnectTimer;

  final _peerConnectionCompleters = <String, Completer<RTCPeerConnection>>{};

  final _callkeepSound = WebtritCallkeepSound();

  CallBloc({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.trustedCertificates,
    required this.callLogsRepository,
    required this.notificationsBloc,
    required this.callkeep,
    required this.callkeepConnections,
    this.sdpMunger,
  }) : super(const CallState()) {
    on<CallStarted>(
      _onCallStarted,
      transformer: sequential(),
    );
    on<_AppLifecycleStateChanged>(
      _onAppLifecycleStateChanged,
      transformer: sequential(),
    );
    on<_ConnectivityResultChanged>(
      _onConnectivityResultChanged,
      transformer: sequential(),
    );
    on<_NavigatorMediaDevicesChange>(
      _onNavigatorMediaDevicesChange,
      transformer: droppable(),
    );
    on<_RegistrationChange>(
      _onRegistrationChange,
      transformer: droppable(),
    );
    on<_ResetStateEvent>(
      _onResetStateEvent,
      transformer: droppable(),
    );
    on<_SignalingClientEvent>(
      _onSignalingClientEvent,
      transformer: restartable(),
    );
    on<_HandshakeSignalingEvent>(
      _onHandshakeSignalingEvent,
      transformer: sequential(),
    );
    on<_CallSignalingEvent>(
      _onCallSignalingEvent,
      transformer: sequential(),
    );
    on<_CallPushEvent>(
      _onCallPushEvent,
      transformer: sequential(),
    );
    on<CallControlEvent>(
      _onCallControlEvent,
      transformer: sequential(),
    );
    on<_CallPerformEvent>(
      _onCallPerformEvent,
      transformer: sequential(),
    );
    on<_PeerConnectionEvent>(
      _onPeerConnectionEvent,
      transformer: sequential(),
    );
    on<CallScreenEvent>(
      _onCallScreenEvent,
      transformer: sequential(),
    );

    navigator.mediaDevices.ondevicechange = (event) {
      add(const _NavigatorMediaDevicesChange());
    };

    WidgetsBinding.instance.addObserver(this);

    callkeep.setDelegate(this);
  }

  @override
  Future<void> close() async {
    callkeep.setDelegate(null);

    WidgetsBinding.instance.removeObserver(this);

    navigator.mediaDevices.ondevicechange = null;

    await _connectivityChangedSubscription?.cancel();

    await _pendingCallHandlerSubscription?.cancel();

    _signalingClientReconnectTimer?.cancel();
    await _signalingClient?.disconnect();

    await _stopRingbackSound();

    await super.close();
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    _logger.warning('onError', error, stackTrace);
    // TODO: analise error and finalize necessary active call
  }

  @override
  void onChange(Change<CallState> change) {
    super.onChange(change);

    if (change.currentState.isActive != change.nextState.isActive) {
      final appLifecycleState = WidgetsFlutterBinding.ensureInitialized().lifecycleState;
      if (appLifecycleState == AppLifecycleState.paused ||
          appLifecycleState == AppLifecycleState.detached ||
          appLifecycleState == AppLifecycleState.inactive) {
        if (change.nextState.isActive) {
          if (_signalingClient == null) {
            _reconnectInitiated();
          }
        } else {
          if (_signalingClient != null) {
            _disconnectInitiated();
          }
        }
      }
    }

    final currentActiveCallUuids = Set.from(change.currentState.activeCalls.map((e) => e.callId));
    final nextActiveCallUuids = Set.from(change.nextState.activeCalls.map((e) => e.callId));
    for (final removeUuid in currentActiveCallUuids.difference(nextActiveCallUuids)) {
      assert(_peerConnectionCompleters.containsKey(removeUuid) == true);
      _logger.finer(() => 'Remove peerConnection completer with uuid: $removeUuid');
      _peerConnectionCompleters.remove(removeUuid);
    }
    for (final addUuid in nextActiveCallUuids.difference(currentActiveCallUuids)) {
      assert(_peerConnectionCompleters.containsKey(addUuid) == false);
      _logger.finer(() => 'Add peerConnection completer with uuid: $addUuid');
      final completer = Completer<RTCPeerConnection>();
      completer.future.ignore(); // prevent escalating possible error that was not awaited to the error zone level
      _peerConnectionCompleters[addUuid] = completer;
    }
  }

  //

  void _peerConnectionComplete(String callId, RTCPeerConnection peerConnection) {
    try {
      _logger.finer(() => 'Complete peerConnection completer with callId: $callId');
      final peerConnectionCompleter = _peerConnectionCompleters[callId]!;
      peerConnectionCompleter.complete(peerConnection);
    } catch (e) {
      // Handle the exception for correct functionality, for example, when the peer connection has already been completed.
      _logger.warning('_peerConnectionComplete: $e');
    }
  }

  void _peerConnectionCompleteError(String callId, Object error, [StackTrace? stackTrace]) {
    try {
      _logger.finer(() => 'CompleteError peerConnection completer with callId: $callId');
      final peerConnectionCompleter = _peerConnectionCompleters[callId]!;
      peerConnectionCompleter.completeError(error, stackTrace);
    } catch (e) {
      // Handle the exception for correct functionality, for example, when the peer connection has already been completed.
      _logger.warning('_peerConnectionCompleteError: $e');
    }
  }

  void _peerConnectionConditionalCompleteError(String callId, Object error, [StackTrace? stackTrace]) {
    try {
      final peerConnectionCompleter = _peerConnectionCompleters[callId]!;
      if (peerConnectionCompleter.isCompleted) {
        _logger
            .finer(() => 'ConditionalCompleteError peerConnection completer with callId: $callId - already completed');
      } else {
        _logger.finer(() => 'ConditionalCompleteError peerConnection completer with callId: $callId');
        peerConnectionCompleter.completeError(error, stackTrace);
      }
    } catch (e) {
      // Handle the exception for correct functionality, for example, when the peer connection has already been completed.
      _logger.warning('_peerConnectionConditionalCompleteError: $e');
    }
  }

  Future<RTCPeerConnection?> _peerConnectionRetrieve(String callId) async {
    final peerConnectionCompleter = _peerConnectionCompleters[callId];
    if (peerConnectionCompleter == null) {
      _logger.finer(() => 'Retrieve peerConnection completer with callId: $callId - null');
      return null;
    } else {
      try {
        _logger.finer(() => 'Retrieve peerConnection completer with callId: $callId - await');
        // Timeout to handle scenarios where `complete` is never called.
        // This can occur, for example, when a push is received for an incorrect account
        // after a forced logout.
        final peerConnection = await peerConnectionCompleter.future.timeout(
          kPeerConnectionRetrieveTimeout,
          onTimeout: () => throw TimeoutException('Timeout while retrieving peer connection for callId: $callId'),
        );
        _logger.finer(() => 'Retrieve peerConnection completer with callId: $callId - value');
        return peerConnection;
      } catch (e, stackTrace) {
        _logger.finer(() => 'Retrieve peerConnection completer with uuid: $callId - error', e, stackTrace);
        return null;
      }
    }
  }

  //

  void _reconnectInitiated([Duration delay = kSignalingClientFastReconnectDelay, bool reconnecting = false]) {
    _signalingClientReconnectTimer?.cancel();
    _signalingClientReconnectTimer = Timer(delay, () {
      _logger.info('_reconnectInitiated Timer callback after $delay, isClosed: $isClosed');
      if (isClosed) return; // to eliminate possible [StateError] in [add]
      add(_SignalingClientEvent.connectInitiated(reconnecting: reconnecting));
    });
  }

  void _disconnectInitiated() {
    _signalingClientReconnectTimer?.cancel();
    _signalingClientReconnectTimer = null;
    add(const _SignalingClientEvent.disconnectInitiated());
  }

  //

  Future<void> _onCallStarted(
    CallStarted event,
    Emitter<CallState> emit,
  ) async {
    _connectivityChangedSubscription = Connectivity().onConnectivityChanged.listen((result) {
      _logger.finer('onConnectivityChanged: $result');
      // this check is necessary because of issue on iOS with doubling the same connectivity result
      // todo [onConnectivityChanged] now used .distinct(), maybe not necessary anymore
      final currentConnectivityResult = result.first;
      if (state.currentConnectivityResult != currentConnectivityResult) {
        add(_ConnectivityResultChanged(currentConnectivityResult));
      }
    });
    if (state.currentConnectivityResult == null) {
      final result = await Connectivity().checkConnectivity();
      _logger.finer('checkConnectivity: $result');
      final currentConnectivityResult = result.first;
      add(_ConnectivityResultChanged(currentConnectivityResult));
    }

    AppleNativeAudioManagement.setUseManualAudio(true);
  }

  Future<void> _onAppLifecycleStateChanged(
    _AppLifecycleStateChanged event,
    Emitter<CallState> emit,
  ) async {
    final appLifecycleState = event.state;
    _logger.fine('_onAppLifecycleStateChanged: $appLifecycleState');
    if (appLifecycleState == AppLifecycleState.paused || appLifecycleState == AppLifecycleState.detached) {
      if (_signalingClient != null && !state.isActive) {
        _disconnectInitiated();
      }
    } else if (appLifecycleState == AppLifecycleState.resumed) {
      if (_signalingClient == null) {
        _reconnectInitiated();
      }
    }
  }

  Future<void> _onConnectivityResultChanged(
    _ConnectivityResultChanged event,
    Emitter<CallState> emit,
  ) async {
    final connectivityResult = event.result;
    _logger.fine('_onConnectivityResultChanged: $connectivityResult');
    if (connectivityResult == ConnectivityResult.none) {
      _disconnectInitiated();
    } else {
      _reconnectInitiated();
    }
    emit(state.copyWith(currentConnectivityResult: connectivityResult));
  }

  Future<void> _onNavigatorMediaDevicesChange(
    _NavigatorMediaDevicesChange event,
    Emitter<CallState> emit,
  ) async {
    final devices = await navigator.mediaDevices.enumerateDevices();
    final audioOutputDevices = devices.where((d) => d.kind == 'audiooutput').toList();
    if (audioOutputDevices.isNotEmpty) {
      emit(state.copyWith(speaker: audioOutputDevices.first.groupId == 'Speaker'));
    }
  }

  // processing the registration event change

  Future<void> _onRegistrationChange(
    _RegistrationChange event,
    Emitter<CallState> emit,
  ) async {
    final newRegistrationStatus = event.registration.status;
    final previousRegistrationStatus = state.registrationStatus;

    if (newRegistrationStatus != previousRegistrationStatus) {
      _logger.fine('_onRegistrationChange: $previousRegistrationStatus to $newRegistrationStatus');
      emit(state.copyWith(registrationStatus: newRegistrationStatus));
    } else {
      _logger.fine('_onRegistrationChange: no change in status ($newRegistrationStatus)');
      return;
    }

    if (newRegistrationStatus.isRegistered) {
      notificationsBloc.add(NotificationsSubmitted(AppOnlineNotification()));
      return;
    }

    if (newRegistrationStatus.isRegistering || newRegistrationStatus.isFailed || newRegistrationStatus.isUnregistered) {
      add(const _ResetStateEvent.completeCalls());
    }

    if (newRegistrationStatus.isUnregistered) {
      notificationsBloc.add(NotificationsSubmitted(AppOfflineNotification()));
      return;
    }

    if (newRegistrationStatus.isFailed) {
      final code = SignalingRegistrationFailedCode.values.byCode(event.registration.code);
      final reason = event.registration.reason ?? code.toString();

      switch (code) {
        case SignalingRegistrationFailedCode.sipServerUnavailable:
          notificationsBloc.add(NotificationsSubmitted(SipServerUnavailable()));
          return;
        default:
          notificationsBloc.add(NotificationsSubmitted(ErrorMessageNotification(reason)));
      }
    }
  }

  // processing the handling of the app state
  Future<void> _onResetStateEvent(
    _ResetStateEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      completeCalls: (event) => __onResetStateEventCompleteCalls(event, emit),
      completeCall: (event) => __onResetStateEventCompleteCall(event, emit),
    );
  }

  Future<void> __onResetStateEventCompleteCalls(
    _ResetStateEventCompleteCalls event,
    Emitter<CallState> emit,
  ) async {
    _logger.warning('__onResetStateEventCompleteCalls: ${state.activeCalls}');

    for (var element in state.activeCalls) {
      add(_ResetStateEvent.completeCall(element.callId));
    }
  }

  Future<void> __onResetStateEventCompleteCall(
    _ResetStateEventCompleteCall event,
    Emitter<CallState> emit,
  ) async {
    _logger.warning('__onResetStateEventCompleteCall: ${event.callId}');

    try {
      emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(status: ActiveCallStatus.disconnecting);
      }));

      await state.performOnActiveCall(event.callId, (activeCall) async {
        await (await _peerConnectionRetrieve(activeCall.callId))?.close();
        await activeCall.localStream?.dispose();
      });
      emit(state.copyWithPopActiveCall(event.callId));
    } catch (e) {
      _logger.warning('__onResetStateEventCompleteCall: $e');
    }
  }

  // processing signaling client events

  Future<void> _onSignalingClientEvent(
    _SignalingClientEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      connectInitiated: (event) => __onSignalingClientEventConnectInitiated(event, emit),
      disconnectInitiated: (event) => __onSignalingClientEventDisconnectInitiated(event, emit),
      disconnected: (event) => __onSignalingClientEventDisconnected(event, emit),
    );
  }

  Future<void> __onSignalingClientEventConnectInitiated(
    _SignalingClientEventConnectInitiated event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWith(
      signalingClientStatus: SignalingClientStatus.connecting,
      lastSignalingClientDisconnectError: null,
    ));
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
      final signalingClient = await WebtritSignalingClient.connect(
        signalingUrl,
        tenantId,
        token,
        true,
        connectionTimeout: kSignalingClientConnectionTimeout,
        certs: trustedCertificates,
      );

      if (emit.isDone) {
        await signalingClient.disconnect(SignalingDisconnectCode.goingAway.code);
        return;
      }

      signalingClient.listen(
        onStateHandshake: _onSignalingStateHandshake,
        onEvent: _onSignalingEvent,
        onError: _onSignalingError,
        onDisconnect: (c, r) => _onSignalingDisconnect(c, r, event.reconnecting),
      );
      _signalingClient = signalingClient;

      emit(state.copyWith(
        signalingClientStatus: SignalingClientStatus.connect,
        lastSignalingClientConnectError: null,
        lastSignalingDisconnectCode: null,
      ));
    } catch (e) {
      if (emit.isDone) return;

      if (state.lastSignalingClientConnectError == null) {
        notificationsBloc.add(const NotificationsSubmitted(CallConnectErrorNotification()));
      }

      emit(state.copyWith(
        signalingClientStatus: SignalingClientStatus.failure,
        lastSignalingClientConnectError: e,
      ));

      _reconnectInitiated(kSignalingClientReconnectDelay);
    }
  }

  Future<void> __onSignalingClientEventDisconnectInitiated(
    _SignalingClientEventDisconnectInitiated event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWith(
      signalingClientStatus: SignalingClientStatus.disconnecting,
      lastSignalingClientConnectError: null,
    ));
    try {
      final signalingClient = _signalingClient;
      if (signalingClient != null) {
        _signalingClient = null;
        await signalingClient.disconnect();
      }

      if (emit.isDone) return;

      emit(state.copyWith(
        signalingClientStatus: SignalingClientStatus.disconnect,
        lastSignalingClientDisconnectError: null,
        lastSignalingDisconnectCode: null,
      ));
    } catch (e) {
      if (emit.isDone) return;

      emit(state.copyWith(
        signalingClientStatus: SignalingClientStatus.failure,
        lastSignalingClientDisconnectError: e,
      ));
    }
  }

  Future<void> __onSignalingClientEventDisconnected(
    _SignalingClientEventDisconnected event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWith(
      signalingClientStatus: SignalingClientStatus.disconnect,
      lastSignalingDisconnectCode: event.code,
    ));

    _signalingClient = null;

    final code = SignalingDisconnectCode.values.byCode(event.code ?? -1);
    final afterReconnect = event.afterReconnect;
    Notification? notificationToShow;

    if (code == SignalingDisconnectCode.appUnregisteredError) {
      add(const _RegistrationChange(registration: Registration(status: RegistrationStatus.unregistered)));
    } else if (code == SignalingDisconnectCode.requestCallIdError) {
      state.activeCalls.where((e) => e.wasHungUp).forEach((e) => add(_ResetStateEvent.completeCall(e.callId)));
    } else if (code == SignalingDisconnectCode.controllerExitError) {
      _logger.info('__onSignalingClientEventDisconnected: skipping expected system unregistration notification');
    } else if (code == SignalingDisconnectCode.sessionMissedError) {
      notificationToShow = const CallSignalingClientSessionMissedErrorNotification();
    } else {
      final errorText = event.reason?.isNotEmpty == true ? event.reason! : code.name;
      notificationToShow = ErrorMessageNotification(errorText);
    }

    if (notificationToShow != null && !afterReconnect) {
      notificationsBloc.add(NotificationsSubmitted(notificationToShow));
    }

    _reconnectInitiated(kSignalingClientReconnectDelay, true);
  }

  // processing call push events

  Future<void> _onCallPushEvent(
    _CallPushEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      incoming: (event) => __onCallPushEventIncoming(event, emit),
    );
  }

  Future<void> __onCallPushEventIncoming(
    _CallPushEventIncoming event,
    Emitter<CallState> emit,
  ) async {
    final eventError = event.error;
    if (eventError != null) {
      _logger.warning('__onCallPushEventIncoming event.error: $eventError');
      // TODO: implement correct incoming call hangup (take into account that _signalingClient is disconnected)
      return;
    }

    emit(state.copyWithPushActiveCall(ActiveCall(
      direction: CallDirection.incoming,
      line: _kUndefinedLine,
      callId: event.callId,
      handle: event.handle,
      displayName: event.displayName,
      video: event.video,
      createdTime: clock.now(),
      status: ActiveCallStatus.incomingPushedFromCallKeep,
    )));

    // Function to verify speaker availability for the upcoming event, ensuring the speaker button is correctly enabled or disabled
    add(const _NavigatorMediaDevicesChange());

    // the rest logic implemented within _onSignalingStateHandshake on IncomingCallEvent from call logs processing
  }

  // processing handshake signaling events

  Future<void> _onHandshakeSignalingEvent(
    _HandshakeSignalingEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      state: (event) => __onHandshakeSignalingEventState(event, emit),
    );
  }

  Future<void> __onHandshakeSignalingEventState(
    _HandshakeSignalingEventState event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWith(linesCount: event.linesCount));

    add(_RegistrationChange(registration: event.registration));
  }

  // processing call signaling events

  Future<void> _onCallSignalingEvent(
    _CallSignalingEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      incoming: (event) => __onCallSignalingEventIncoming(event, emit),
      ringing: (event) => __onCallSignalingEventRinging(event, emit),
      progress: (event) => __onCallSignalingEventProgress(event, emit),
      accepted: (event) => __onCallSignalingEventAccepted(event, emit),
      hangup: (event) => __onCallSignalingEventHangup(event, emit),
      updating: (event) => __onCallSignalingEventUpdating(event, emit),
      updated: (event) => __onCallSignalingEventUpdated(event, emit),
      transfer: (value) => __onCallSignalingEventTransfer(value, emit),
      transferring: (value) => __onCallSignalingEventTransfering(value, emit),
      notify: (value) => __onCallSignalingEventNotify(value, emit),
      registering: (event) => __onCallSignalingEventRegistering(event, emit),
      registered: (event) => __onCallSignalingEventRegistered(event, emit),
      registrationFailed: (event) => __onCallSignalingEventRegistrationFailed(event, emit),
      unregistering: (event) => __onCallSignalingEventUnregistering(event, emit),
      unregistered: (event) => __onCallSignalingEventUnregistered(event, emit),
    );
  }

  Future<void> __onCallSignalingEventIncoming(
    _CallSignalingEventIncoming event,
    Emitter<CallState> emit,
  ) async {
    final video = event.jsep?.hasVideo ?? false;

    final handle = CallkeepHandle.number(event.caller);

    final error = await callkeep.reportNewIncomingCall(
      event.callId,
      handle,
      displayName: event.callerDisplayName,
      hasVideo: video,
    );

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

    final newActiveCall = ActiveCall(
      direction: CallDirection.incoming,
      line: event.line,
      callId: event.callId,
      handle: handle,
      displayName: event.callerDisplayName,
      video: video,
      createdTime: clock.now(),
      transfer: transfer,
    );

    if (state.retrieveActiveCall(event.callId) != null) {
      emit(state.copyWithMappedActiveCall(event.callId, (activeCall) => newActiveCall));
    } else {
      emit(state.copyWithPushActiveCall(newActiveCall));
    }

    final activeCall = state.retrieveActiveCall(event.callId)!;

    try {
      final localStream = await _getUserMedia(video: video, frontCamera: activeCall.frontCamera);

      final peerConnection = await _createPeerConnection(event.callId);
      localStream.getTracks().forEach((track) async {
        await peerConnection.addTrack(track, localStream);
      });

      final jsep = event.jsep;
      if (jsep != null) {
        final remoteDescription = jsep.toDescription();
        await peerConnection.setRemoteDescription(remoteDescription);
      }

      _peerConnectionComplete(event.callId, peerConnection);

      emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(localStream: localStream, status: ActiveCallStatus.incomingJsepProcessed);
      }));

      // Defer the event execution to the end of the event loop to avoid exceptions like CallkeepCallRequestError.internal.
      // Can occur when the user quickly answers or ends a call.
      // TODO(Serdun): Investigate how it can be improved without using Future.delayed.
      Future.delayed(Duration.zero, () {
        if (callAlreadyAnswered) {
          add(CallControlEvent.answered(activeCall.callId));
        } else if (callAlreadyTerminated) {
          add(CallControlEvent.ended(activeCall.callId));
        }
      });
    } catch (e, stackTrace) {
      _logger.warning('__onCallSignalingEventIncoming _getUserMedia', e, stackTrace);

      await callkeep.reportEndCall(
        event.callId,
        activeCall.displayName ?? activeCall.handle.value,
        CallkeepEndCallReason.failed,
      );

      _addToRecents(activeCall.copyWith(hungUpTime: clock.now()));

      _peerConnectionCompleteError(event.callId, e, stackTrace);

      notificationsBloc.add(const NotificationsSubmitted(CallUserMediaErrorNotification()));

      emit(state.copyWithPopActiveCall(event.callId));

      var declineRequest = DeclineRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: activeCall.line,
        callId: activeCall.callId,
      );

      _signalingClient?.execute(declineRequest).catchError((e) {
        _logger.warning('__onCallSignalingEventIncoming declineRequest error: $e');
      });
    }
  }

  // no early media - play ringtone
  Future<void> __onCallSignalingEventRinging(
    _CallSignalingEventRinging event,
    Emitter<CallState> emit,
  ) async {
    await _playRingbackSound();
  }

  // early media - set specified session description
  Future<void> __onCallSignalingEventProgress(
    _CallSignalingEventProgress event,
    Emitter<CallState> emit,
  ) async {
    await _stopRingbackSound();

    final jsep = event.jsep;
    if (jsep != null) {
      final peerConnection = await _peerConnectionRetrieve(event.callId);
      if (peerConnection == null) {
        _logger.warning('__onCallSignalingEventProgress: peerConnection is null - most likely some permissions issue');
      } else {
        final remoteDescription = jsep.toDescription();
        await peerConnection.setRemoteDescription(remoteDescription);
      }
    } else {
      _logger.warning('__onCallSignalingEventProgress: jsep must not be null');
    }
  }

  Future<void> __onCallSignalingEventAccepted(
    _CallSignalingEventAccepted event,
    Emitter<CallState> emit,
  ) async {
    await _stopRingbackSound();

    await callkeep.reportConnectedOutgoingCall(event.callId);

    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      if (activeCall.acceptedTime == null) {
        return activeCall.copyWith(acceptedTime: clock.now());
      } else {
        return activeCall;
      }
    }));

    final jsep = event.jsep;
    if (jsep != null) {
      final peerConnection = await _peerConnectionRetrieve(event.callId);
      if (peerConnection == null) {
        _logger.warning('__onCallSignalingEventAccepted: peerConnection is null - most likely some permissions issue');
      } else {
        final remoteDescription = jsep.toDescription();
        await peerConnection.setRemoteDescription(remoteDescription);
      }
    }
  }

  Future<void> __onCallSignalingEventHangup(
    _CallSignalingEventHangup event,
    Emitter<CallState> emit,
  ) async {
    final code = SignalingResponseCode.values.byCode(event.code);

    switch (code) {
      case null:
        break;
      case SignalingResponseCode.unauthorizedRequest:
        notificationsBloc.add(NotificationsSubmitted(AppUnregisteredNotification()));
      default:
        final signalingHangupException = SignalingHangupFailure(code);
        final defaultErrorNotification = DefaultErrorNotification(signalingHangupException);
        notificationsBloc.add(NotificationsSubmitted(defaultErrorNotification));
    }

    try {
      _stopRingbackSound();

      ActiveCall? call = state.retrieveActiveCall(event.callId);

      if (call != null) {
        CallkeepEndCallReason endReason = CallkeepEndCallReason.remoteEnded;

        if (call.wasHungUp == false) {
          _addToRecents(call.copyWith(hungUpTime: clock.now()));
        }
        if (call.direction == CallDirection.incoming && !call.wasAccepted) {
          endReason = CallkeepEndCallReason.unanswered;
        }

        await (await _peerConnectionRetrieve(event.callId))?.close();
        await call.localStream?.dispose();

        emit(state.copyWithPopActiveCall(event.callId));

        await callkeep.reportEndCall(event.callId, call.displayName ?? call.handle.value, endReason);
      }
    } catch (e) {
      _logger.warning('__onCallSignalingEventHangup: $e');
    }
  }

  Future<void> __onCallSignalingEventUpdating(
    _CallSignalingEventUpdating event,
    Emitter<CallState> emit,
  ) async {
    final video = event.jsep?.hasVideo ?? false;

    final handle = CallkeepHandle.number(event.caller);

    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(
        handle: handle,
        displayName: event.callerDisplayName,
        video: video,
        updating: true,
      );
    }));

    await callkeep.reportUpdateCall(
      event.callId,
      handle: handle,
      displayName: event.callerDisplayName,
      hasVideo: video,
      proximityEnabled: state.shouldListenToProximity,
    );

    try {
      final jsep = event.jsep;
      if (jsep != null) {
        final remoteDescription = jsep.toDescription();
        await state.performOnActiveCall(event.callId, (activeCall) async {
          final peerConnection = await _peerConnectionRetrieve(activeCall.callId);
          if (peerConnection == null) {
            _logger.warning('__onCallSignalingEventUpdating: peerConnection is null - most likely some state issue');
          } else {
            await peerConnection.setRemoteDescription(remoteDescription);
            final localDescription = await peerConnection.createAnswer({});
            sdpMunger?.modify(localDescription);

            await _signalingClient?.execute(UpdateRequest(
              transaction: WebtritSignalingClient.generateTransactionId(),
              line: activeCall.line,
              callId: activeCall.callId,
              jsep: localDescription.toMap(),
            ));
            await peerConnection.setLocalDescription(localDescription);
          }
        });
      }
    } catch (e) {
      _logger.warning('__onCallSignalingEventUpdating && jsep error: $e');
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));

      _peerConnectionCompleteError(event.callId, e);
      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onCallSignalingEventUpdated(
    _CallSignalingEventUpdated event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(updating: false);
    }));
  }

  Future<void> __onCallSignalingEventTransfer(
    _CallSignalingEventTransfer event,
    Emitter<CallState> emit,
  ) async {
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

  Future<void> __onCallSignalingEventTransfering(
    _CallSignalingEventTransferring event,
    Emitter<CallState> emit,
  ) async {
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

  Future<void> __onCallSignalingEventNotify(
    _CallSignalingEventNotify event,
    Emitter<CallState> emit,
  ) async {
    _logger.fine('__onCallSignalingEventNotify: $event');

    _handleSignalingEventCompleteTransferNotification(event);
  }

  // Handles NOTIFY events indicating the completion of a call transfer.
  // Triggered when a 'refer' NOTIFY message with 'SIP/2.0 200 OK' content and
  // 'terminated' subscription state is received, indicating a successful transfer.
  // This was the original call (call A) that was transferred. Notify events indicate
  // the transfer status ('100 Trying', '200 OK'), but the call may not close
  // automatically as it could be transferred to another session or line.
  void _handleSignalingEventCompleteTransferNotification(_CallSignalingEventNotify event) {
    if (event.notify == NotifyType.refer &&
        event.contentType == NotifyContentType.messageSipfrag &&
        NotifyContent.match200OK(event.content) &&
        event.subscriptionState == SubscriptionState.terminated) {
      // Verifies if the original call line is currently active in the state
      if (state.activeCalls.any((it) => it.callId == event.callId)) {
        add(CallControlEvent.ended(event.callId));
      }
    }
  }

  Future<void> __onCallSignalingEventRegistering(
    _CallSignalingEventRegistering event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationChange(registration: Registration(status: RegistrationStatus.registering)));
  }

  Future<void> __onCallSignalingEventRegistered(
    _CallSignalingEventRegistered event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationChange(registration: Registration(status: RegistrationStatus.registered)));
  }

  Future<void> __onCallSignalingEventRegistrationFailed(
    _CallSignalingEventRegisterationFailed event,
    Emitter<CallState> emit,
  ) async {
    add(_RegistrationChange(
      registration: Registration(
        status: RegistrationStatus.registration_failed,
        code: event.code,
        reason: event.reason,
      ),
    ));
  }

  Future<void> __onCallSignalingEventUnregistering(
    _CallSignalingEventUnregistering event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationChange(registration: Registration(status: RegistrationStatus.unregistering)));
  }

  Future<void> __onCallSignalingEventUnregistered(
    _CallSignalingEventUnregistered event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationChange(registration: Registration(status: RegistrationStatus.unregistered)));
  }

  // processing call control events

  Future<void> _onCallControlEvent(
    CallControlEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      started: (event) => __onCallControlEventStarted(event, emit),
      answered: (event) => __onCallControlEventAnswered(event, emit),
      ended: (event) => __onCallControlEventEnded(event, emit),
      setHeld: (event) => __onCallControlEventSetHeld(event, emit),
      setMuted: (event) => __onCallControlEventSetMuted(event, emit),
      sentDTMF: (event) => __onCallControlEventSentDTMF(event, emit),
      cameraSwitched: (event) => _onCallControlEventCameraSwitched(event, emit),
      cameraEnabled: (event) => _onCallControlEventCameraEnabled(event, emit),
      speakerEnabled: (event) => _onCallControlEventSpeakerEnabled(event, emit),
      failureApproved: (event) => _onCallControlEventFailureApproved(event, emit),
      blindTransferInitiated: (event) => _onCallControlEventBlindTransferInitiated(event, emit),
      attendedTransferInitiated: (event) => _onCallControlEventAttendedTransferInitiated(event, emit),
      blindTransferSubmitted: (event) => _onCallControlEventBlindTransferSubmitted(event, emit),
      attendedTransferSubmitted: (event) => _onCallControlEventAttendedTransferSubmitted(event, emit),
      attendedRequestApproved: (value) => _onCallControlEventAttendedRequestApproved(value, emit),
      attendedRequestDeclined: (value) => _onCallControlEventAttendedRequestDeclined(value, emit),
    );
  }

  Future<void> __onCallControlEventStarted(
    _CallControlEventStarted event,
    Emitter<CallState> emit,
  ) async {
    if (!state.registrationStatus.isRegistered) {
      _logger.info('__onCallControlEventStarted account is not registered');
      notificationsBloc.add(NotificationsSubmitted(AppUnregisteredNotification()));

      return;
    }

    final callId = WebtritSignalingClient.generateCallId();

    final error = await callkeep.startCall(
      callId,
      event.handle,
      displayNameOrContactIdentifier: event.displayName,
      hasVideo: event.video,
      proximityEnabled: !event.video,
    );
    if (error != null) {
      if (error == CallkeepCallRequestError.emergencyNumber) {
        final Uri telLaunchUri = Uri(scheme: 'tel', path: event.handle.value);
        launchUrl(telLaunchUri);
      } else {
        _logger.warning('__onCallControlEventStarted error: $error');
      }
    } else {
      final newCall = ActiveCall(
        direction: CallDirection.outgoing,
        line: event.line ?? state.retrieveIdleLine() ?? _kUndefinedLine,
        callId: callId,
        handle: event.handle,
        displayName: event.displayName,
        video: event.video,
        createdTime: clock.now(),
      );

      emit(state.copyWithPushActiveCall(newCall).copyWith(minimized: false));
    }
  }

  Future<void> __onCallControlEventAnswered(
    _CallControlEventAnswered event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(
      event.callId,
      (call) => call.copyWith(status: ActiveCallStatus.answering),
    ));

    final error = await callkeep.answerCall(event.callId);
    if (error != null) {
      _logger.warning('__onCallControlEventAnswered error: $error');
    }
  }

  Future<void> __onCallControlEventEnded(
    _CallControlEventEnded event,
    Emitter<CallState> emit,
  ) async {
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

  Future<void> __onCallControlEventSetHeld(
    _CallControlEventSetHeld event,
    Emitter<CallState> emit,
  ) async {
    final error = await callkeep.setHeld(event.callId, onHold: event.onHold);
    if (error != null) {
      _logger.warning('__onCallControlEventSetHeld error: $error');
    }
  }

  Future<void> __onCallControlEventSetMuted(
    _CallControlEventSetMuted event,
    Emitter<CallState> emit,
  ) async {
    final error = await callkeep.setMuted(event.callId, muted: event.muted);
    if (error != null) {
      _logger.warning('__onCallControlEventSetMuted error: $error');
    }
  }

  Future<void> __onCallControlEventSentDTMF(
    _CallControlEventSentDTMF event,
    Emitter<CallState> emit,
  ) async {
    final error = await callkeep.sendDTMF(event.callId, event.key);
    if (error != null) {
      _logger.warning('__onCallControlEventSentDTMF error: $error');
    }
  }

  Future<void> _onCallControlEventCameraSwitched(
    _CallControlEventCameraSwitched event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(frontCamera: null);
    }));
    final frontCamera = await state.performOnActiveCall(event.callId, (activeCall) {
      final videoTrack = activeCall.localStream?.getVideoTracks()[0];
      if (videoTrack != null) {
        return Helper.switchCamera(videoTrack);
      }
    });
    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(frontCamera: frontCamera);
    }));
  }

  Future<void> _onCallControlEventCameraEnabled(
    _CallControlEventCameraEnabled event,
    Emitter<CallState> emit,
  ) async {
    await state.performOnActiveCall(event.callId, (activeCall) {
      final videoTrack = activeCall.localStream?.getVideoTracks()[0];
      if (videoTrack != null) {
        videoTrack.enabled = event.enabled;
      }
    });
  }

  Future<void> _onCallControlEventSpeakerEnabled(
    _CallControlEventSpeakerEnabled event,
    Emitter<CallState> emit,
  ) async {
    await state.performOnActiveCall(event.callId, (activeCall) async {
      if (Platform.isAndroid) {
        callkeep.setSpeaker(event.callId, enabled: event.enabled);
      } else if (Platform.isIOS) {
        await Helper.setSpeakerphoneOn(event.enabled);
      }
    });
  }

  Future<void> _onCallControlEventFailureApproved(
    _CallControlEventFailureApproved event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(failure: null);
    }));
  }

  Future<void> _onCallControlEventBlindTransferInitiated(
    _CallControlEventBlindTransferInitiated event,
    Emitter<CallState> emit,
  ) async {
    var newState = state.copyWith(minimized: true);

    newState = newState.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(
        transfer: const Transfer.blindTransferInitiated(),
      );
    });

    emit(newState);

    await callkeep.reportUpdateCall(
      state.activeCalls.current.callId,
      proximityEnabled: state.shouldListenToProximity,
    );
  }

  Future<void> _onCallControlEventAttendedTransferInitiated(
    _CallControlEventAttendedTransferInitiated event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWith(minimized: true));
    await __onCallControlEventSetHeld(_CallControlEventSetHeld(event.callId, true), emit);
  }

  Future<void> _onCallControlEventBlindTransferSubmitted(
    _CallControlEventBlindTransferSubmitted event,
    Emitter<CallState> emit,
  ) async {
    final activeCallBlindTransferInitiated = state.activeCalls.blindTransferInitiated;
    if (activeCallBlindTransferInitiated == null) return;

    // Check if the number is already in active calls
    final isNumberAlreadyConnected = state.activeCalls.any((call) => call.handle.value == event.number);
    if (isNumberAlreadyConnected) {
      notificationsBloc.add(NotificationsSubmitted(ActiveLineBlindTransferWarningNotification()));
      return;
    }

    try {
      final transferRequest = TransferRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: activeCallBlindTransferInitiated.line,
        callId: activeCallBlindTransferInitiated.callId,
        number: event.number,
      );

      await _signalingClient?.execute(transferRequest);

      var newState = state.copyWith(minimized: false);
      newState = newState.copyWithMappedActiveCall(activeCallBlindTransferInitiated.callId, (activeCall) {
        final transfer = Transfer.blindTransferTransferSubmitted(toNumber: event.number);
        return activeCall.copyWith(transfer: transfer);
      });
      emit(newState);

      await callkeep.reportUpdateCall(
        state.activeCalls.current.callId,
        proximityEnabled: state.shouldListenToProximity,
      );

      // After request succesfully submitted, transfer flow will continue
      // by TransferringEvent event from anus and handled in [_CallSignalingEventTransferring]
      // that means that call transfering is now in progress
    } catch (e) {
      _logger.warning('_onCallControlEventBlindTransferSubmitted request error: $e');
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));
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

      emit(state.copyWithMappedActiveCall(referorCall.callId, (activeCall) {
        final transfer = Transfer.attendedTransferTransferSubmitted(replaceCallId: replaceCall.callId);
        return activeCall.copyWith(transfer: transfer);
      }));

      // After request succesfully submitted, transfer flow will continue
      // by TransferringEvent event from anus and handled in [_CallSignalingEventTransferring]
      // that means that call transfering is now in progress
    } catch (e) {
      _logger.warning('_onCallControlEventAttendedTransferSubmitted request error: $e');
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));
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

    final error = await callkeep.startCall(
      callId,
      newHandle,
      hasVideo: false,
      proximityEnabled: true,
    );

    if (error != null) {
      _logger.warning('__onCallControlEventStarted error: $error');
      notificationsBloc.add(NotificationsSubmitted(ErrorMessageNotification(error.toString())));
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

      emit(state.copyWithMappedActiveCall(callId, (activeCall) {
        return activeCall.copyWith(transfer: null);
      }));
    } catch (e) {
      _logger.warning('_onCallControlEventAttendedRequestDeclined request error: $e');
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));
    }
  }

  // processing call perform events

  Future<void> _onCallPerformEvent(
    _CallPerformEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      started: (event) => __onCallPerformEventStarted(event, emit),
      answered: (event) => __onCallPerformEventAnswered(event, emit),
      ended: (event) => __onCallPerformEventEnded(event, emit),
      setHeld: (event) => __onCallPerformEventSetHeld(event, emit),
      setMuted: (event) => __onCallPerformEventSetMuted(event, emit),
      sentDTMF: (event) => __onCallPerformEventSentDTMF(event, emit),
      setSpeaker: (event) => __onCallPerformEventSetSpeaker(event, emit),
    );
  }

  Future<void> __onCallPerformEventStarted(
    _CallPerformEventStarted event,
    Emitter<CallState> emit,
  ) async {
    if (!state.registrationStatus.isRegistered) {
      _logger.info('__onCallPerformEventStarted account is not registered');
      notificationsBloc.add(NotificationsSubmitted(AppUnregisteredNotification()));

      event.fail();
      return;
    }

    if (await state.performOnActiveCall(event.callId, (activeCall) => activeCall.line != _kUndefinedLine) != true) {
      event.fail();

      emit(state.copyWithPopActiveCall(event.callId));

      notificationsBloc.add(const NotificationsSubmitted(CallUndefinedLineErrorNotification()));
      return;
    }
    if (!state.signalingClientStatus.isConnect &&
        // attempt to wait for the desired signaling client status within the signaling client connection timeout period
        !(await stream
                .firstWhere((state) => state.signalingClientStatus.isConnect || state.signalingClientStatus.isFailure,
                    orElse: () => state)
                .timeout(kSignalingClientConnectionTimeout, onTimeout: () => state))
            .signalingClientStatus
            .isConnect) {
      event.fail();

      // Notice that the tube was already hung up to avoid sending an extra event to the server
      emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(hungUpTime: clock.now());
      }));

      // Remove local connection
      callkeep.endCall(event.callId);

      notificationsBloc.add(const NotificationsSubmitted(CallSignalingClientNotConnectErrorNotification()));
      return;
    }
    late final MediaStream localStream;
    try {
      localStream = await _getUserMedia(
        video: event.video,
        frontCamera: state.retrieveActiveCall(event.callId)?.frontCamera,
      );
    } catch (e, stackTrace) {
      _logger.warning('__onCallPerformEventStarted _getUserMedia', e, stackTrace);

      event.fail();

      _peerConnectionCompleteError(event.callId, e, stackTrace);

      emit(state.copyWithPopActiveCall(event.callId));

      notificationsBloc.add(const NotificationsSubmitted(CallUserMediaErrorNotification()));
      return;
    }
    event.fulfill();

    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(localStream: localStream);
    }));

    final peerConnection = await _createPeerConnection(event.callId);
    localStream.getTracks().forEach((track) async {
      await peerConnection.addTrack(track, localStream);
    });

    try {
      final localDescription = await peerConnection.createOffer({});
      sdpMunger?.modify(localDescription);

      // Need to initiate outgoing call before set localDescription to avoid races
      // between [OutgoingCallRequest] and [IceTrickleRequest]s.
      await state.performOnActiveCall(event.callId, (activeCall) {
        return _signalingClient?.execute(OutgoingCallRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId,
          number: activeCall.handle.normalizedValue(),
          jsep: localDescription.toMap(),
          referId: activeCall.fromReferId,
        ));
      });
      await peerConnection.setLocalDescription(localDescription);

      _peerConnectionComplete(event.callId, peerConnection);

      await callkeep.reportConnectingOutgoingCall(event.callId);
    } catch (e) {
      // Handles exceptions during the outgoing call perform event, sends a notification, stops the ringtone, and completes the peer connection with an error.
      // The specific error "Error setting ICE locally" indicates an issue with ICE (Interactive Connectivity Establishment) negotiation in the WebRTC signaling process.
      _logger.warning('__onCallPerformEventStarted: $e');
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));

      await _stopRingbackSound();
      _peerConnectionCompleteError(event.callId, e);

      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onCallPerformEventAnswered(
    _CallPerformEventAnswered event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();
    try {
      await _stopRingbackSound();

      // Try to wait until signaling is properly initialized and processed incoming call.
      //
      // 1 May occur when the user interacts with a push notification before signaling is properly initialized.
      // In this case, the CallKeep method "reportNewIncomingCall" may return callIdAlreadyAnswered, and processing can be skipped.
      //
      // 2 Or in case when the user answers the call before incoming jsep and offer processed
      // e.g in race condition between [_CallPerformEventAnswered], [_CallSignalingEventIncoming] and [_CallSignalingEventProgress].
      //
      // 3 Or in case when the user answers the call multiple times (coz ui didnt blocked),
      // the first answer is processed, and the second answer is ignored.
      //
      // Reproduce cases -
      // ios app in foreground + screen locked, answer the call from the lock screen as fast as possible
      // ios app in terminated state pressing push, but this case cant be debugged.
      // android app in foreground/background state + screen locked, press button(flutter ui) multiple times to trigger concurrent events
      final doTime = clock.now();
      bool canAnswer = false;
      await Future.doWhile(() async {
        final call = state.retrieveActiveCall(event.callId);
        final jsepProcessed =
            call?.status == ActiveCallStatus.incomingJsepProcessed || call?.status == ActiveCallStatus.answering;

        final pc = await _peerConnectionRetrieve(event.callId);
        final offerReceived = pc?.signalingState == RTCSignalingState.RTCSignalingStateHaveRemoteOffer;

        final alreadyAnswered = call?.status == ActiveCallStatus.incomingAnswered;
        final timedOut = clock.now().difference(doTime).inSeconds > 5;

        _logger.fine(
            '__onCallPerformEventAnswered: jsepProcessed: $jsepProcessed, offerReceived: $offerReceived, alreadyAnswered:$alreadyAnswered , timedOut: $timedOut');
        canAnswer = jsepProcessed && offerReceived && !alreadyAnswered;
        if (alreadyAnswered || timedOut || canAnswer) return false;
        return await Future.delayed(const Duration(milliseconds: 100), () => true);
      });

      if (canAnswer == false) return;
      final call = state.retrieveActiveCall(event.callId)!;
      final peerConnection = (await _peerConnectionRetrieve(call.callId))!;

      final localDescription = await peerConnection.createAnswer({});
      sdpMunger?.modify(localDescription);

      await _signalingClient?.execute(AcceptRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: call.line,
        callId: call.callId,
        jsep: localDescription.toMap(),
      ));
      await peerConnection.setLocalDescription(localDescription);

      emit(state.copyWithMappedActiveCall(
        event.callId,
        (call) => call.copyWith(acceptedTime: clock.now(), status: ActiveCallStatus.incomingAnswered),
      ));
    } catch (e) {
      _logger.warning('__onCallPerformEventAnswered: $e');
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));

      _peerConnectionCompleteError(event.callId, e);
      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onCallPerformEventEnded(
    _CallPerformEventEnded event,
    Emitter<CallState> emit,
  ) async {
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

    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      final activeCallUpdated = activeCall.copyWith(hungUpTime: clock.now());
      _addToRecents(activeCallUpdated);
      return activeCallUpdated;
    }));

    await state.performOnActiveCall(event.callId, (activeCall) async {
      if (activeCall.isIncoming && !activeCall.wasAccepted) {
        final declineRequest = DeclineRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId,
        );
        await _signalingClient?.execute(declineRequest).catchError((e) {
          _logger.warning('__onCallPerformEventEnded declineRequest error: $e');
        });
      } else {
        final hangupRequest = HangupRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId,
        );
        await _signalingClient?.execute(hangupRequest).catchError((e) {
          _logger.warning('__onCallPerformEventEnded hangupRequest error: $e');
        });
      }

      // Need to close peer connection after executing [HangupRequest]
      // to prevent "Simulate a "hangup" coming from the application"
      // because of "No WebRTC media anymore".
      await (await _peerConnectionRetrieve(activeCall.callId))?.close();
      await activeCall.localStream?.dispose();
    });

    emit(state.copyWithPopActiveCall(event.callId));
  }

  Future<void> __onCallPerformEventSetHeld(
    _CallPerformEventSetHeld event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();

    try {
      await state.performOnActiveCall(event.callId, (activeCall) {
        if (event.onHold) {
          return _signalingClient?.execute(HoldRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            callId: activeCall.callId,
            direction: HoldDirection.inactive,
          ));
        } else {
          return _signalingClient?.execute(UnholdRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            callId: activeCall.callId,
          ));
        }
      });

      emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
        return activeCall.copyWith(held: event.onHold);
      }));
    } catch (e) {
      _logger.warning('__onCallPerformEventSetHeld: $e');
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));

      _peerConnectionCompleteError(event.callId, e);
      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onCallPerformEventSetMuted(
    _CallPerformEventSetMuted event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();

    await state.performOnActiveCall(event.callId, (activeCall) {
      final audioTrack = activeCall.localStream?.getAudioTracks()[0];
      if (audioTrack != null) {
        Helper.setMicrophoneMute(event.muted, audioTrack);
      }
    });

    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(muted: event.muted);
    }));
  }

  Future<void> __onCallPerformEventSentDTMF(
    _CallPerformEventSentDTMF event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();

    await state.performOnActiveCall(event.callId, (activeCall) async {
      final peerConnection = await _peerConnectionRetrieve(activeCall.callId);
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

  Future<void> __onCallPerformEventSetSpeaker(
    _CallPerformEventSetSpeaker event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();
    emit(state.copyWith(speaker: event.enabled));
  }

  // processing peer connection events

  Future<void> _onPeerConnectionEvent(
    _PeerConnectionEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      signalingStateChanged: (event) => __onPeerConnectionEventSignalingStateChanged(event, emit),
      connectionStateChanged: (event) => __onPeerConnectionEventConnectionStateChanged(event, emit),
      iceGatheringStateChanged: (event) => __onPeerConnectionEventIceGatheringStateChanged(event, emit),
      iceConnectionStateChanged: (event) => __onPeerConnectionEventIceConnectionStateChanged(event, emit),
      iceCandidateIdentified: (event) => __onPeerConnectionEventIceCandidateIdentified(event, emit),
      streamAdded: (event) => __onPeerConnectionEventStreamAdded(event, emit),
      streamRemoved: (event) => __onPeerConnectionEventStreamRemoved(event, emit),
    );
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
      } catch (e) {
        _logger.warning('__onPeerConnectionEventIceGatheringStateChanged: $e');
        notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));

        _peerConnectionCompleteError(event.callId, e);
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
          final peerConnection = await _peerConnectionRetrieve(activeCall.callId);
          if (peerConnection == null) {
            _logger.warning(
                '__onPeerConnectionEventIceConnectionStateChanged: peerConnection is null - most likely some state issue');
          } else {
            await peerConnection.restartIce();
            final localDescription = await peerConnection.createOffer({});
            sdpMunger?.modify(localDescription);

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
      } catch (e) {
        _logger.warning('__onPeerConnectionEventIceConnectionStateChanged: $e');
        notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));

        _peerConnectionCompleteError(event.callId, e);
        add(_ResetStateEvent.completeCall(event.callId));
      }
    }
  }

  Future<void> __onPeerConnectionEventIceCandidateIdentified(
    _PeerConnectionEventIceCandidateIdentified event,
    Emitter<CallState> emit,
  ) async {
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
    } catch (e) {
      _logger.warning('__onPeerConnectionEventIceCandidateIdentified error: $e');
      notificationsBloc.add(NotificationsSubmitted(DefaultErrorNotification(e)));

      _peerConnectionCompleteError(event.callId, e);
      add(_ResetStateEvent.completeCall(event.callId));
    }
  }

  Future<void> __onPeerConnectionEventStreamAdded(
    _PeerConnectionEventStreamAdded event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(remoteStream: event.stream);
    }));
  }

  Future<void> __onPeerConnectionEventStreamRemoved(
    _PeerConnectionEventStreamRemoved event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.callId, (activeCall) {
      return activeCall.copyWith(remoteStream: null);
    }));
  }

  // procession call screen events

  Future<void> _onCallScreenEvent(
    CallScreenEvent event,
    Emitter<CallState> emit,
  ) {
    return event.map(
      didPush: (event) => __onCallScreenEventDidPush(event, emit),
      didPop: (event) => __onCallScreenEventDidPop(event, emit),
    );
  }

  Future<void> __onCallScreenEventDidPush(
    _CallScreenEventDidPush event,
    Emitter<CallState> emit,
  ) async {
    final hasActiveCalls = state.activeCalls.isNotEmpty;
    var newState = state.copyWith(minimized: false);

    if (hasActiveCalls) {
      newState = newState.copyWithMappedActiveCalls((activeCall) {
        final transfer = activeCall.transfer;
        if (transfer != null && transfer is BlindTransferInitiated) {
          return activeCall.copyWith(
            transfer: null,
          );
        } else {
          return activeCall;
        }
      });

      emit(newState);

      await callkeep.reportUpdateCall(
        state.activeCalls.current.callId,
        proximityEnabled: state.shouldListenToProximity,
      );
    } else {
      _logger.warning('__onCallScreenEventDidPush: activeCalls is empty');
    }
  }

  Future<void> __onCallScreenEventDidPop(
    _CallScreenEventDidPop event,
    Emitter<CallState> emit,
  ) async {
    final hasActiveCalls = state.activeCalls.isNotEmpty;
    emit(state.copyWith(minimized: hasActiveCalls ? true : null));

    if (hasActiveCalls) {
      await callkeep.reportUpdateCall(
        state.activeCalls.current.callId,
        proximityEnabled: state.shouldListenToProximity,
      );
    } else {
      _logger.warning('__onCallScreenEventDidPop: activeCalls is empty');
    }
  }

  // WebtritSignalingClient listen handlers

  void _onSignalingStateHandshake(StateHandshake stateHandshake) async {
    add(_HandshakeSignalingEvent.state(
      registration: stateHandshake.registration,
      linesCount: stateHandshake.lines.length,
    ));

    activeCallsLoop:
    for (final activeCall in state.activeCalls) {
      if (activeCall.line == _kUndefinedLine) {
        for (final line in stateHandshake.lines) {
          if (line != null && line.callId == activeCall.callId) {
            continue activeCallsLoop;
          }
        }
      } else if (activeCall.line < stateHandshake.lines.length) {
        final line = stateHandshake.lines[activeCall.line];
        if (line != null && line.callId == activeCall.callId) {
          continue activeCallsLoop;
        }
      }
      if (activeCall.direction == CallDirection.outgoing &&
          activeCall.acceptedTime == null &&
          activeCall.hungUpTime == null) {
        // Handles an outgoing active call that has not yet started, typically initiated
        // by the `continueStartCallIntent` callback of `CallkeepDelegate`.
        // TODO: Implement a dedicated flag to confirm successful execution of
        // OutgoingCallRequest, ensuring reliable outgoing active call state tracking.
        continue activeCallsLoop;
      }

      _peerConnectionConditionalCompleteError(activeCall.callId, 'Active call Request Terminated');

      add(_CallSignalingEvent.hangup(
        line: activeCall.line,
        callId: activeCall.callId,
        code: 487,
        reason: 'Request Terminated',
      ));
    }

    for (final activeLine in stateHandshake.lines.whereType<Line>()) {
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
            await _signalingHungUpCall(callEvent.line, callEvent.callId);
            return;
          } else if (callEvent is IncomingCallEvent) {
            // Handle incoming calls. If the event is `IncomingCallEvent`, send a decline request to update the signaling state accordingly.
            await _signalingDeclineCall(callEvent.line, callEvent.callId);
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
  }

  void _onSignalingEvent(Event event) {
    if (event is IncomingCallEvent) {
      add(_CallSignalingEvent.incoming(
        line: event.line,
        callId: event.callId,
        callee: event.callee,
        caller: event.caller,
        callerDisplayName: event.callerDisplayName,
        referredBy: event.referredBy,
        replaceCallId: event.replaceCallId,
        isFocus: event.isFocus,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is RingingEvent) {
      add(_CallSignalingEvent.ringing(
        line: event.line,
        callId: event.callId,
      ));
    } else if (event is ProgressEvent) {
      add(_CallSignalingEvent.progress(
        line: event.line,
        callId: event.callId,
        callee: event.callee,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is AcceptedEvent) {
      add(_CallSignalingEvent.accepted(
        line: event.line,
        callId: event.callId,
        callee: event.callee,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is HangupEvent) {
      add(_CallSignalingEvent.hangup(
        line: event.line,
        callId: event.callId,
        code: event.code,
        reason: event.reason,
      ));
    } else if (event is UpdatingCallEvent) {
      add(_CallSignalingEvent.updating(
        line: event.line,
        callId: event.callId,
        callee: event.callee,
        caller: event.caller,
        callerDisplayName: event.callerDisplayName,
        referredBy: event.referredBy,
        replaceCallId: event.replaceCallId,
        isFocus: event.isFocus,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is UpdatedEvent) {
      add(_CallSignalingEvent.updated(
        line: event.line,
        callId: event.callId,
      ));
    } else if (event is TransferEvent) {
      add(_CallSignalingEvent.transfer(
        line: event.line,
        referId: event.referId,
        referTo: event.referTo,
        referredBy: event.referredBy,
        replaceCallId: event.replaceCallId,
      ));
    } else if (event is NotifyEvent) {
      add(_CallSignalingEvent.notify(
        line: event.line,
        callId: event.callId,
        notify: event.notify,
        subscriptionState: event.subscriptionState,
        contentType: event.contentType,
        content: event.content,
      ));
    } else if (event is RegisteringEvent) {
      add(const _CallSignalingEvent.registering());
    } else if (event is RegisteredEvent) {
      add(const _CallSignalingEvent.registered());
    } else if (event is RegistrationFailedEvent) {
      add(_CallSignalingEvent.registrationFailed(event.code, event.reason));
    } else if (event is UnregisteringEvent) {
      add(const _CallSignalingEvent.unregistering());
    } else if (event is UnregisteredEvent) {
      add(const _CallSignalingEvent.unregistered());
    } else if (event is TransferringEvent) {
      add(_CallSignalingEvent.transferring(line: event.line, callId: event.callId));
    } else {
      _logger.warning('unhandled signaling event $event');
    }
  }

  void _onSignalingError(error, [StackTrace? stackTrace]) {
    _logger.severe('_onErrorCallback', error, stackTrace);

    _reconnectInitiated();
  }

  void _onSignalingDisconnect(int? code, String? reason, bool afterReconnect) {
    add(_SignalingClientEvent.disconnected(code, reason, afterReconnect: afterReconnect));
  }

  // WidgetsBindingObserver

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _logger.finer('didChangeAppLifecycleState: $state');
    add(_AppLifecycleStateChanged(state));
  }

  // CallkeepDelegate

  @override
  void continueStartCallIntent(
    CallkeepHandle handle,
    String? displayName,
    bool video,
  ) {
    _logger.fine(() => 'continueStartCallIntent handle: $handle displayName: $displayName video: $video');

    add(CallControlEvent.started(
      generic: handle.isGeneric ? handle.value : null,
      number: handle.isNumber ? handle.value : null,
      email: handle.isEmail ? handle.value : null,
      displayName: displayName,
      video: video,
    ));
  }

  @override
  void didPushIncomingCall(
    CallkeepHandle handle,
    String? displayName,
    bool video,
    String callId,
    CallkeepIncomingCallError? error,
  ) {
    _logger.fine(() => 'didPushIncomingCall handle: $handle displayName: $displayName video: $video'
        ' callId: $callId error: $error');

    add(_CallPushEvent.incoming(
      callId: callId,
      handle: handle,
      displayName: displayName,
      video: video,
      error: error,
    ));
  }

  @override
  Future<bool> performStartCall(
    String callId,
    CallkeepHandle handle,
    String? displayNameOrContactIdentifier,
    bool video,
  ) {
    return _perform(_CallPerformEvent.started(
      callId,
      handle: handle,
      displayName: displayNameOrContactIdentifier,
      video: video,
    ));
  }

  @override
  Future<bool> performAnswerCall(String callId) {
    return _perform(_CallPerformEvent.answered(callId));
  }

  @override
  Future<bool> performEndCall(String callId) {
    return _perform(_CallPerformEvent.ended(callId));
  }

  @override
  Future<bool> performSetHeld(String callId, bool onHold) {
    return _perform(_CallPerformEvent.setHeld(callId, onHold));
  }

  @override
  Future<bool> performSetMuted(String callId, bool muted) {
    return _perform(_CallPerformEvent.setMuted(callId, muted));
  }

  @override
  Future<bool> performSendDTMF(String callId, String key) {
    return _perform(_CallPerformEvent.sentDTMF(callId, key));
  }

  @override
  Future<bool> performSetSpeaker(String callId, bool enabled) {
    return _perform(_CallPerformEvent.setSpeaker(callId, enabled));
  }

  @override
  void didActivateAudioSession() {
    _logger.fine('didActivateAudioSession');
    () async {
      await AppleNativeAudioManagement.audioSessionDidActivate();
      await AppleNativeAudioManagement.setIsAudioEnabled(true);
    }();
  }

  @override
  void didDeactivateAudioSession() {
    _logger.fine('didDeactivateAudioSession');
    () async {
      await AppleNativeAudioManagement.setIsAudioEnabled(false);
      await AppleNativeAudioManagement.audioSessionDidDeactivate();
    }();
  }

  @override
  void didReset() {
    _logger.warning('didReset');
  }

  // helpers

  Future<bool> _perform(_CallPerformEvent callPerformEvent) {
    add(callPerformEvent);
    return callPerformEvent.future;
  }

  Future<MediaStream> _getUserMedia({
    required bool video,
    bool? frontCamera,
  }) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': video
          ? {
              'mandatory': {
                'minWidth': '640',
                'minHeight': '480',
                'minFrameRate': '30',
              },
              if (frontCamera != null) 'facingMode': frontCamera ? 'user' : 'environment',
              'optional': [],
            }
          : false,
    };
    final localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    if (!kIsWeb) {
      await Helper.setAppleAudioConfiguration(AppleAudioConfiguration(
        appleAudioMode: video ? AppleAudioMode.videoChat : AppleAudioMode.voiceChat,
      ));
      await Helper.setSpeakerphoneOn(video);
    }

    return localStream;
  }

  Future<RTCPeerConnection> _createPeerConnection(String callId) async {
    final peerConnection = await createPeerConnection(
      {
        'iceServers': [
          {
            'url': 'stun:stun.l.google.com:19302',
          },
        ],
      },
      {},
    );
    final logger = Logger(peerConnection.toString());

    return peerConnection
      ..onSignalingState = (signalingState) {
        logger.fine(() => 'onSignalingState state: $signalingState');

        add(_PeerConnectionEvent.signalingStateChanged(callId, signalingState));
      }
      ..onConnectionState = (connectionState) {
        logger.fine(() => 'onConnectionState state: $connectionState');

        add(_PeerConnectionEvent.connectionStateChanged(callId, connectionState));
      }
      ..onIceGatheringState = (iceGatheringState) {
        logger.fine(() => 'onIceGatheringState state: $iceGatheringState');

        add(_PeerConnectionEvent.iceGatheringStateChanged(callId, iceGatheringState));
      }
      ..onIceConnectionState = (iceConnectionState) {
        logger.fine(() => 'onIceConnectionState state: $iceConnectionState');

        add(_PeerConnectionEvent.iceConnectionStateChanged(callId, iceConnectionState));
      }
      ..onIceCandidate = (candidate) {
        logger.fine(() => 'onIceCandidate candidate: $candidate');

        add(_PeerConnectionEvent.iceCandidateIdentified(callId, candidate));
      }
      ..onAddStream = (stream) {
        logger.fine(() => 'onAddStream stream: $stream');

        add(_PeerConnectionEvent.streamAdded(callId, stream));
      }
      ..onRemoveStream = (stream) {
        logger.fine(() => 'onRemoveStream stream: $stream');

        add(_PeerConnectionEvent.streamRemoved(callId, stream));
      }
      ..onAddTrack = (stream, track) {
        logger.fine(() => 'onAddTrack stream: $stream track: $track');
      }
      ..onRemoveTrack = (stream, track) {
        logger.fine(() => 'onRemoveTrack stream: $stream track: $track');
      }
      ..onDataChannel = (channel) {
        logger.fine(() => 'onDataChannel channel: $channel');
      }
      ..onRenegotiationNeeded = () {
        logger.fine(() => 'onRenegotiationNeeded');
      }
      ..onTrack = (event) {
        logger.fine(() {
          final sb = StringBuffer('onTrack');
          sb.write(' receiver: ${event.receiver}');
          sb.write(' streams: [');
          final streamsLength = event.streams.length;
          for (var i = 0; i < streamsLength; i++) {
            sb.write('$stream');
            if (i + 1 < streamsLength) {
              sb.write(', ');
            }
          }
          sb.write(']');
          sb.write(' track: ${event.track}');
          sb.write(' transceiver: ${event.transceiver}');
          return sb;
        });
      };
  }

  void _addToRecents(ActiveCall activeCall) {
    NewCall call = (
      direction: activeCall.direction,
      number: activeCall.handle.value,
      video: activeCall.video,
      createdTime: activeCall.createdTime,
      acceptedTime: activeCall.acceptedTime,
      hungUpTime: activeCall.hungUpTime,
    );
    callLogsRepository.add(call);
  }

  Future<void> _playRingbackSound() => _callkeepSound.playRingbackSound();

  Future<void> _stopRingbackSound() => _callkeepSound.stopRingbackSound();

  // Signaling base requests

  // TODO(Serdun): Replace other hangup request calls with this method for consistency.
  Future<void> _signalingHungUpCall(int line, String callId) async {
    final hangupRequest = HangupRequest(
      transaction: WebtritSignalingClient.generateTransactionId(),
      line: line,
      callId: callId,
    );
    // Attempt to execute the hangup request to synchronize the signaling state.
    await _signalingClient?.execute(hangupRequest).catchError((e) {
      _logger.warning('_signalingHungUpCall hangupRequest error: $e');
    });
  }

  // TODO(Serdun): Replace other decline request calls with this method for consistency.
  Future<void> _signalingDeclineCall(int line, String callId) async {
    final hangupRequest = DeclineRequest(
      transaction: WebtritSignalingClient.generateTransactionId(),
      line: line,
      callId: callId,
    );
    // Attempt to execute the hangup request to synchronize the signaling state.
    await _signalingClient?.execute(hangupRequest).catchError((e) {
      _logger.warning('_signalingDeclineCall hangupRequest error: $e');
    });
  }
}
