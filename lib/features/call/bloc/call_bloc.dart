import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:clock/clock.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/extensions/extensions.dart';
import 'package:webtrit_phone/features/notifications/notifications.dart';
import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../models/models.dart';

export 'package:webtrit_callkeep/webtrit_callkeep.dart' show CallkeepHandle, CallkeepHandleType;

part 'call_bloc.freezed.dart';

part 'call_event.dart';

part 'call_state.dart';

const int _kUndefinedLine = -1;

final _logger = Logger('CallBloc');

class CallBloc extends Bloc<CallEvent, CallState> with WidgetsBindingObserver implements CallkeepDelegate {
  final RecentsRepository recentsRepository;
  final NotificationsBloc notificationsBloc;
  final AppBloc appBloc;
  final Callkeep callkeep;

  StreamSubscription<ConnectivityResult>? _connectivityChangedSubscription;

  WebtritSignalingClient? _signalingClient;
  Timer? _signalingClientReconnectTimer;

  final _peerConnectionCompleters = <UuidValue, Completer<RTCPeerConnection>>{};

  final _audioPlayer = AudioPlayer();

  CallBloc({
    required this.recentsRepository,
    required this.notificationsBloc,
    required this.appBloc,
    required this.callkeep,
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
    on<_RegistrationAccountChange>(
      _onRegistrationAccountChange,
      transformer: droppable(),
    );
    on<_CompleteCallsAndResetState>(
      _completeCallsAndResetState,
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

    WidgetsBinding.instance.addObserver(this);

    callkeep.setDelegate(this);
  }

  @override
  Future<void> close() async {
    callkeep.setDelegate(null);

    WidgetsBinding.instance.removeObserver(this);

    await _connectivityChangedSubscription?.cancel();

    _signalingClientReconnectTimer?.cancel();
    await _signalingClient?.disconnect();

    await _audioPlayer.dispose();

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
      if (appLifecycleState == AppLifecycleState.paused || appLifecycleState == AppLifecycleState.detached) {
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

    final currentActiveCallUuids = Set.from(change.currentState.activeCalls.map((e) => e.callId.uuid));
    final nextActiveCallUuids = Set.from(change.nextState.activeCalls.map((e) => e.callId.uuid));
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

  void _peerConnectionComplete(UuidValue uuid, RTCPeerConnection peerConnection) {
    _logger.finer(() => 'Complete peerConnection completer with uuid: $uuid');
    final peerConnectionCompleter = _peerConnectionCompleters[uuid]!;
    peerConnectionCompleter.complete(peerConnection);
  }

  void _peerConnectionCompleteError(UuidValue uuid, Object error, [StackTrace? stackTrace]) {
    _logger.finer(() => 'CompleteError peerConnection completer with uuid: $uuid');
    final peerConnectionCompleter = _peerConnectionCompleters[uuid]!;
    peerConnectionCompleter.completeError(error, stackTrace);
  }

  void _peerConnectionConditionalCompleteError(UuidValue uuid, Object error, [StackTrace? stackTrace]) {
    final peerConnectionCompleter = _peerConnectionCompleters[uuid]!;
    if (peerConnectionCompleter.isCompleted) {
      _logger.finer(() => 'ConditionalCompleteError peerConnection completer with uuid: $uuid - already completed');
    } else {
      _logger.finer(() => 'ConditionalCompleteError peerConnection completer with uuid: $uuid');
      peerConnectionCompleter.completeError(error, stackTrace);
    }
  }

  Future<RTCPeerConnection?> _peerConnectionRetrieve(UuidValue uuid) async {
    final peerConnectionCompleter = _peerConnectionCompleters[uuid];
    if (peerConnectionCompleter == null) {
      _logger.finer(() => 'Retrieve peerConnection completer with uuid: $uuid - null');
      return null;
    } else {
      try {
        _logger.finer(() => 'Retrieve peerConnection completer with uuid: $uuid - await');
        final peerConnection = await peerConnectionCompleter.future;
        _logger.finer(() => 'Retrieve peerConnection completer with uuid: $uuid - value');
        return peerConnection;
      } catch (e, stackTrace) {
        _logger.finer(() => 'Retrieve peerConnection completer with uuid: $uuid - error', e, stackTrace);
        return null;
      }
    }
  }

  //

  void _reconnectInitiated([Duration delay = Duration.zero]) {
    _signalingClientReconnectTimer?.cancel();
    _signalingClientReconnectTimer = Timer(delay, () {
      _logger.info('_reconnectInitiated Timer callback after $delay');
      add(const _SignalingClientEvent.connectInitiated());
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
      if (state.currentConnectivityResult != result) {
        add(_ConnectivityResultChanged(result));
      }
    });
    if (state.currentConnectivityResult == null) {
      final result = await Connectivity().checkConnectivity();
      _logger.finer('checkConnectivity: $result');
      add(_ConnectivityResultChanged(result));
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
      if (state.isActive) {
        // in case of paused app state and active call disconnect will be initiated
        // after call end within [onChange] method of [CallBloc]
      } else {
        if (_signalingClient != null) {
          _disconnectInitiated();
        }
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

  Future<void> _onRegistrationAccountChange(
    _RegistrationAccountChange event,
    Emitter<CallState> emit,
  ) async {
    final newRegistrationAccountStatus = event.registrationAccountStatus;
    final previousRegistrationAccountStatus = state.registrationAccountStatus;
    if (newRegistrationAccountStatus != previousRegistrationAccountStatus) {
      _logger.fine('_onRegistrationAccountChange: $previousRegistrationAccountStatus to $newRegistrationAccountStatus');
      emit(state.copyWith(registrationAccountStatus: newRegistrationAccountStatus));
    } else {
      _logger.fine('_onRegistrationAccountChange: status is already the same');
      return;
    }

    switch (newRegistrationAccountStatus) {
      case RegistrationAccountStatus.registering:
        add(const _CompleteCallsAndResetState());
      case RegistrationAccountStatus.registered:
      case RegistrationAccountStatus.failed:
        add(const _CompleteCallsAndResetState());
      case RegistrationAccountStatus.unregistering:
      case RegistrationAccountStatus.unregistered:
        add(const _CompleteCallsAndResetState());
    }
  }

  // processing the handling of the app state

  Future<void> _completeCallsAndResetState(
    _CompleteCallsAndResetState event,
    Emitter<CallState> emit,
  ) async {
    for (var element in state.activeCalls) {
      try {
        callkeep.endCall(element.callId.uuid);
        await state.performOnActiveCall(element.callId.uuid, (activeCall) async {
          // Need to close peer connection after executing [HangupRequest]
          // to prevent "Simulate a "hangup" coming from the application"
          // because of "No WebRTC media anymore".
          await (await _peerConnectionRetrieve(activeCall.callId.uuid))?.close();
          await activeCall.renderers.dispose();
          await activeCall.renderers.local.srcObject?.dispose();
        });
      } catch (e) {
        _logger.warning('_completeCallsAndResetState: $e');
      }

      emit(state.copyWithPopActiveCall(element.callId.uuid));
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

      final signalingUrl = _parseCoreUrlToSignalingUrl(appBloc.state.coreUrl!);
      final tenantId = appBloc.state.tenantId!;
      final token = appBloc.state.token!;
      final signalingClient = await WebtritSignalingClient.connect(
        signalingUrl,
        tenantId,
        token,
        true,
        connectionTimeout: kSignalingClientConnectionTimeout,
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

      emit(state.copyWith(
        signalingClientStatus: SignalingClientStatus.connect,
        lastSignalingClientConnectError: null,
        lastSignalingDisconnectCode: null,
      ));
    } catch (e) {
      if (emit.isDone) return;

      if (state.lastSignalingClientConnectError == null) {
        notificationsBloc.add(const NotificationsIssued(CallConnectErrorNotification()));
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

    final signalingDisconnectCode = event.code;
    if (signalingDisconnectCode != null) {
      final code = SignalingDisconnectCode.values.byCode(signalingDisconnectCode);
      if (code == SignalingDisconnectCode.sessionMissedError) {
        notificationsBloc.add(const NotificationsIssued(CallSignalingClientSessionMissedErrorNotification()));
        appBloc.add(const AppLogouted());
      } else if (code == SignalingDisconnectCode.appUnregisteredError) {
        add(const _RegistrationAccountChange(RegistrationAccountStatus.unregistered));
      }
    }

    _reconnectInitiated(kSignalingClientReconnectDelay);
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
      direction: Direction.incoming,
      line: _kUndefinedLine,
      callId: event.callId,
      handle: event.handle,
      displayName: event.displayName,
      video: event.video,
      createdTime: clock.now(),
      renderers: RTCVideoRenderers()..initialize(),
    )));

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

    add(_RegistrationAccountChange(event.registrationStatus.toRegistrationAccountStatus()));
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
      event.callId.uuid,
      handle,
      event.callerDisplayName,
      video,
    );

    if (error != null) {
      if (error == CallkeepIncomingCallError.callUuidAlreadyExists) {
        _logger.info('__onCallSignalingEventIncoming reportNewIncomingCall with already existed call uuid');
        emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
          return activeCall.copyWith(line: event.line);
        }));
      } else {
        _logger.warning('__onCallSignalingEventIncoming reportNewIncomingCall error: $error');
        // TODO: implement correct incoming call hangup (take into account that _signalingClient could be disconnected)
        return;
      }
    } else {
      emit(state.copyWithPushActiveCall(ActiveCall(
        direction: Direction.incoming,
        line: event.line,
        callId: event.callId,
        handle: handle,
        displayName: event.callerDisplayName,
        video: video,
        createdTime: clock.now(),
        renderers: RTCVideoRenderers()..initialize(),
      )));
    }

    late final MediaStream localStream;
    try {
      localStream = await _getUserMedia(
        video: video,
        frontCamera: state.retrieveActiveCall(event.callId.uuid)?.frontCamera,
      );
    } catch (e, stackTrace) {
      _logger.warning('__onCallSignalingEventIncoming _getUserMedia', e, stackTrace);

      await callkeep.reportEndCall(event.callId.uuid, CallkeepEndCallReason.failed);

      emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
        final activeCallUpdated = activeCall.copyWith(hungUpTime: clock.now());
        _addToRecents(activeCallUpdated);
        return activeCallUpdated;
      }));

      await state.performOnActiveCall(event.callId.uuid, (activeCall) {
        return _signalingClient?.execute(DeclineRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId.toString(),
        ));
      });

      _peerConnectionCompleteError(event.callId.uuid, e, stackTrace);

      emit(state.copyWithPopActiveCall(event.callId.uuid));

      notificationsBloc.add(const NotificationsIssued(CallUserMediaErrorNotification()));
      return;
    }

    await state.performOnActiveCall(event.callId.uuid, (activeCall) {
      activeCall.renderers.local.srcObject = localStream;
    });

    final peerConnection = await _createPeerConnection(event.callId.uuid);
    localStream.getTracks().forEach((track) async {
      await peerConnection.addTrack(track, localStream);
    });

    final jsep = event.jsep;
    if (jsep != null) {
      final remoteDescription = jsep.toDescription();
      await peerConnection.setRemoteDescription(remoteDescription);
    }

    _peerConnectionComplete(event.callId.uuid, peerConnection);
  }

  // no early media - play ringtone
  Future<void> __onCallSignalingEventRinging(
    _CallSignalingEventRinging event,
    Emitter<CallState> emit,
  ) async {
    await _ringtoneOutgoingPlay();
  }

  // early media - set specified session description
  Future<void> __onCallSignalingEventProgress(
    _CallSignalingEventProgress event,
    Emitter<CallState> emit,
  ) async {
    await _ringtoneStop();

    final jsep = event.jsep;
    if (jsep != null) {
      final peerConnection = await _peerConnectionRetrieve(event.callId.uuid);
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
    await _ringtoneStop();

    await callkeep.reportConnectedOutgoingCall(event.callId.uuid);

    emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
      if (activeCall.acceptedTime == null) {
        return activeCall.copyWith(acceptedTime: clock.now());
      } else {
        return activeCall;
      }
    }));

    final jsep = event.jsep;
    if (jsep != null) {
      final peerConnection = await _peerConnectionRetrieve(event.callId.uuid);
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
    if (state.retrieveActiveCall(event.callId.uuid)?.wasHungUp == true) return;

    await _ringtoneStop();

    emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
      final activeCallUpdated = activeCall.copyWith(hungUpTime: clock.now());
      _addToRecents(activeCallUpdated);
      return activeCallUpdated;
    }));

    await state.performOnActiveCall(event.callId.uuid, (activeCall) async {
      await (await _peerConnectionRetrieve(activeCall.callId.uuid))?.close();
      await activeCall.renderers.dispose();
      await activeCall.renderers.local.srcObject?.dispose();
    });

    emit(state.copyWithPopActiveCall(event.callId.uuid));

    await callkeep.reportEndCall(event.callId.uuid, CallkeepEndCallReason.remoteEnded);
  }

  Future<void> __onCallSignalingEventUpdating(
    _CallSignalingEventUpdating event,
    Emitter<CallState> emit,
  ) async {
    final video = event.jsep?.hasVideo ?? false;

    final handle = CallkeepHandle.number(event.caller);

    await callkeep.reportUpdateCall(
      event.callId.uuid,
      handle,
      event.callerDisplayName,
      video,
    );

    emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
      return activeCall.copyWith(
        handle: handle,
        displayName: event.callerDisplayName,
        video: video,
        updating: true,
      );
    }));

    final jsep = event.jsep;
    if (jsep != null) {
      final remoteDescription = jsep.toDescription();
      await state.performOnActiveCall(event.callId.uuid, (activeCall) async {
        final peerConnection = await _peerConnectionRetrieve(activeCall.callId.uuid);
        if (peerConnection == null) {
          _logger.warning('__onCallSignalingEventUpdating: peerConnection is null - most likely some state issue');
        } else {
          await peerConnection.setRemoteDescription(remoteDescription);
          final localDescription = await peerConnection.createAnswer({});
          await _signalingClient?.execute(UpdateRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            callId: activeCall.callId.toString(),
            jsep: localDescription.toMap(),
          ));
          await peerConnection.setLocalDescription(localDescription);
        }
      });
    }
  }

  Future<void> __onCallSignalingEventUpdated(
    _CallSignalingEventUpdated event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
      return activeCall.copyWith(
        updating: false,
      );
    }));
  }

  Future<void> __onCallSignalingEventRegistering(
    _CallSignalingEventRegistering event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationAccountChange(RegistrationAccountStatus.registering));
  }

  Future<void> __onCallSignalingEventRegistered(
    _CallSignalingEventRegistered event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationAccountChange(RegistrationAccountStatus.registered));
  }

  Future<void> __onCallSignalingEventRegistrationFailed(
    _CallSignalingEventRegisterationFailed event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationAccountChange(RegistrationAccountStatus.failed));
  }

  Future<void> __onCallSignalingEventUnregistering(
    _CallSignalingEventUnregistering event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationAccountChange(RegistrationAccountStatus.unregistering));
  }

  Future<void> __onCallSignalingEventUnregistered(
    _CallSignalingEventUnregistered event,
    Emitter<CallState> emit,
  ) async {
    add(const _RegistrationAccountChange(RegistrationAccountStatus.unregistered));
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
      blindTransferred: (event) => _onCallControlEventBlindTransferred(event, emit),
    );
  }

  Future<void> __onCallControlEventStarted(
    _CallControlEventStarted event,
    Emitter<CallState> emit,
  ) async {
    if (!state.registrationAccountStatus.isRegistered) {
      _logger.info('__onCallControlEventStarted account is not registered');
      return;
    }

    final callId = CallIdValue(WebtritSignalingClient.generateCallId());

    final error = await callkeep.startCall(
      callId.uuid,
      event.handle,
      event.displayName,
      event.video,
    );
    if (error != null) {
      _logger.warning('__onCallControlEventStarted error: $error');
    } else {
      emit(state.copyWithPushActiveCall(ActiveCall(
        direction: Direction.outgoing,
        line: event.line ?? state.retrieveIdleLine() ?? _kUndefinedLine,
        callId: callId,
        handle: event.handle,
        displayName: event.displayName,
        video: event.video,
        createdTime: clock.now(),
        renderers: RTCVideoRenderers()..initialize(),
      )));
    }
  }

  Future<void> __onCallControlEventAnswered(
    _CallControlEventAnswered event,
    Emitter<CallState> emit,
  ) async {
    final error = await callkeep.answerCall(event.uuid);
    if (error != null) {
      _logger.warning('__onCallControlEventAnswered error: $error');
    }
  }

  Future<void> __onCallControlEventEnded(
    _CallControlEventEnded event,
    Emitter<CallState> emit,
  ) async {
    final error = await callkeep.endCall(event.uuid);
    if (error != null) {
      _logger.warning('__onCallControlEventEnded error: $error');
    }
  }

  Future<void> __onCallControlEventSetHeld(
    _CallControlEventSetHeld event,
    Emitter<CallState> emit,
  ) async {
    final error = await callkeep.setHeld(event.uuid, event.onHold);
    if (error != null) {
      _logger.warning('__onCallControlEventSetHeld error: $error');
    }
  }

  Future<void> __onCallControlEventSetMuted(
    _CallControlEventSetMuted event,
    Emitter<CallState> emit,
  ) async {
    final error = await callkeep.setMuted(event.uuid, event.muted);
    if (error != null) {
      _logger.warning('__onCallControlEventSetMuted error: $error');
    }
  }

  Future<void> __onCallControlEventSentDTMF(
    _CallControlEventSentDTMF event,
    Emitter<CallState> emit,
  ) async {
    final error = await callkeep.sendDTMF(event.uuid, event.key);
    if (error != null) {
      _logger.warning('__onCallControlEventSentDTMF error: $error');
    }
  }

  Future<void> _onCallControlEventCameraSwitched(
    _CallControlEventCameraSwitched event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(frontCamera: null);
    }));
    final frontCamera = await state.performOnActiveCall(event.uuid, (activeCall) {
      final videoTrack = activeCall.renderers.local.srcObject?.getVideoTracks()[0];
      if (videoTrack != null) {
        return Helper.switchCamera(videoTrack);
      }
    });
    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(frontCamera: frontCamera);
    }));
  }

  Future<void> _onCallControlEventCameraEnabled(
    _CallControlEventCameraEnabled event,
    Emitter<CallState> emit,
  ) async {
    await state.performOnActiveCall(event.uuid, (activeCall) {
      final videoTrack = activeCall.renderers.local.srcObject?.getVideoTracks()[0];
      if (videoTrack != null) {
        videoTrack.enabled = event.enabled;
      }
    });
  }

  Future<void> _onCallControlEventSpeakerEnabled(
    _CallControlEventSpeakerEnabled event,
    Emitter<CallState> emit,
  ) async {
    await state.performOnActiveCall(event.uuid, (activeCall) async {
      await Helper.setSpeakerphoneOn(event.enabled);
    });
  }

  Future<void> _onCallControlEventFailureApproved(
    _CallControlEventFailureApproved event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(failure: null);
    }));
  }

  Future<void> _onCallControlEventBlindTransferInitiated(
    _CallControlEventBlindTransferInitiated event,
    Emitter<CallState> emit,
  ) async {
    var newState = state.copyWith(minimized: true);

    newState = newState.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(
        transfer: const Transfer(
          type: TransferType.blind,
          state: TransferState.initiated,
        ),
      );
    });

    emit(newState);
  }

  Future<void> _onCallControlEventBlindTransferred(
    _CallControlEventBlindTransferred event,
    Emitter<CallState> emit,
  ) async {
    var newState = state.copyWith(minimized: false);

    final activeCallBlindTransferInitiated = state.activeCalls.blindTransferInitiated;
    if (activeCallBlindTransferInitiated == null) {
      emit(newState);
      return;
    }

    newState = newState.copyWithMappedActiveCall(activeCallBlindTransferInitiated.callId.uuid, (activeCall) {
      return activeCall.copyWith(
        transfer: const Transfer(
          type: TransferType.blind,
          state: TransferState.processing,
        ),
      );
    });

    emit(newState);

    await _signalingClient?.execute(TransferRequest(
      transaction: WebtritSignalingClient.generateTransactionId(),
      line: activeCallBlindTransferInitiated.line,
      callId: activeCallBlindTransferInitiated.callId.toString(),
      number: event.number,
    ));
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
    );
  }

  Future<void> __onCallPerformEventStarted(
    _CallPerformEventStarted event,
    Emitter<CallState> emit,
  ) async {
    if (!state.registrationAccountStatus.isRegistered) {
      _logger.info('__onCallPerformEventStarted account is not registered');
      event.fail();
      return;
    }

    if (await state.performOnActiveCall(event.uuid, (activeCall) => activeCall.line != _kUndefinedLine) != true) {
      event.fail();

      emit(state.copyWithPopActiveCall(event.uuid));

      notificationsBloc.add(const NotificationsIssued(CallUndefinedLineErrorNotification()));
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

      emit(state.copyWithPopActiveCall(event.uuid));

      notificationsBloc.add(const NotificationsIssued(CallSignalingClientNotConnectErrorNotification()));
      return;
    }
    late final MediaStream localStream;
    try {
      localStream = await _getUserMedia(
        video: event.video,
        frontCamera: state.retrieveActiveCall(event.uuid)?.frontCamera,
      );
    } catch (e, stackTrace) {
      _logger.warning('__onCallPerformEventStarted _getUserMedia', e, stackTrace);

      event.fail();

      _peerConnectionCompleteError(event.uuid, e, stackTrace);

      emit(state.copyWithPopActiveCall(event.uuid));

      notificationsBloc.add(const NotificationsIssued(CallUserMediaErrorNotification()));
      return;
    }
    event.fulfill();

    await state.performOnActiveCall(event.uuid, (activeCall) {
      activeCall.renderers.local.srcObject = localStream;
    });

    final peerConnection = await _createPeerConnection(event.uuid);
    localStream.getTracks().forEach((track) async {
      await peerConnection.addTrack(track, localStream);
    });

    final localDescription = await peerConnection.createOffer({});
    // Need to initiate outgoing call before set localDescription to avoid races
    // between [OutgoingCallRequest] and [IceTrickleRequest]s.
    await state.performOnActiveCall(event.uuid, (activeCall) {
      return _signalingClient?.execute(OutgoingCallRequest(
        transaction: WebtritSignalingClient.generateTransactionId(),
        line: activeCall.line,
        callId: activeCall.callId.toString(),
        number: activeCall.handle.normalizedValue(),
        jsep: localDescription.toMap(),
      ));
    });
    await peerConnection.setLocalDescription(localDescription);

    _peerConnectionComplete(event.uuid, peerConnection);

    await callkeep.reportConnectingOutgoingCall(event.uuid);
  }

  Future<void> __onCallPerformEventAnswered(
    _CallPerformEventAnswered event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();

    await _ringtoneStop();

    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(acceptedTime: clock.now());
    }));

    await state.performOnActiveCall(event.uuid, (activeCall) async {
      final peerConnection = await _peerConnectionRetrieve(activeCall.callId.uuid);
      if (peerConnection == null) {
        _logger.warning('__onCallPerformEventAnswered: peerConnection is null - most likely some permissions issue');
      } else {
        final localDescription = peerConnection.signalingState == RTCSignalingState.RTCSignalingStateHaveRemoteOffer
            ? await peerConnection.createAnswer({})
            : await peerConnection.createOffer({});
        await _signalingClient?.execute(AcceptRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId.toString(),
          jsep: localDescription.toMap(),
        ));
        await peerConnection.setLocalDescription(localDescription);
      }
    });
  }

  Future<void> __onCallPerformEventEnded(
    _CallPerformEventEnded event,
    Emitter<CallState> emit,
  ) async {
    if (state.retrieveActiveCall(event.uuid)?.wasHungUp == true) {
      event.fail();
      return;
    }
    event.fulfill();

    await _ringtoneStop();

    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      final activeCallUpdated = activeCall.copyWith(hungUpTime: clock.now());
      _addToRecents(activeCallUpdated);
      return activeCallUpdated;
    }));

    await state.performOnActiveCall(event.uuid, (activeCall) async {
      if (activeCall.isIncoming && !activeCall.wasAccepted) {
        await _signalingClient?.execute(DeclineRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId.toString(),
        ));
      } else {
        await _signalingClient?.execute(HangupRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId.toString(),
        ));
      }

      // Need to close peer connection after executing [HangupRequest]
      // to prevent "Simulate a "hangup" coming from the application"
      // because of "No WebRTC media anymore".
      await (await _peerConnectionRetrieve(activeCall.callId.uuid))?.close();
      await activeCall.renderers.dispose();
      await activeCall.renderers.local.srcObject?.dispose();
    });

    emit(state.copyWithPopActiveCall(event.uuid));
  }

  Future<void> __onCallPerformEventSetHeld(
    _CallPerformEventSetHeld event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();

    await state.performOnActiveCall(event.uuid, (activeCall) {
      if (event.onHold) {
        return _signalingClient?.execute(HoldRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId.toString(),
          direction: HoldDirection.inactive,
        ));
      } else {
        return _signalingClient?.execute(UnholdRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          callId: activeCall.callId.toString(),
        ));
      }
    });

    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(held: event.onHold);
    }));
  }

  Future<void> __onCallPerformEventSetMuted(
    _CallPerformEventSetMuted event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();

    await state.performOnActiveCall(event.uuid, (activeCall) {
      final audioTrack = activeCall.renderers.local.srcObject?.getAudioTracks()[0];
      if (audioTrack != null) {
        Helper.setMicrophoneMute(event.muted, audioTrack);
      }
    });

    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(muted: event.muted);
    }));
  }

  Future<void> __onCallPerformEventSentDTMF(
    _CallPerformEventSentDTMF event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();

    await state.performOnActiveCall(event.uuid, (activeCall) async {
      final peerConnection = await _peerConnectionRetrieve(activeCall.callId.uuid);
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
      await state.performOnActiveCall(event.uuid, (activeCall) {
        if (!activeCall.wasHungUp) {
          return _signalingClient?.execute(IceTrickleRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            candidate: null,
          ));
        }
      });
    }
  }

  Future<void> __onPeerConnectionEventIceConnectionStateChanged(
    _PeerConnectionEventIceConnectionStateChanged event,
    Emitter<CallState> emit,
  ) async {
    if (event.state == RTCIceConnectionState.RTCIceConnectionStateFailed) {
      await state.performOnActiveCall(event.uuid, (activeCall) async {
        final peerConnection = await _peerConnectionRetrieve(activeCall.callId.uuid);
        if (peerConnection == null) {
          _logger.warning(
              '__onPeerConnectionEventIceConnectionStateChanged: peerConnection is null - most likely some state issue');
        } else {
          await peerConnection.restartIce();
          final localDescription = await peerConnection.createOffer({});
          await _signalingClient?.execute(UpdateRequest(
            transaction: WebtritSignalingClient.generateTransactionId(),
            line: activeCall.line,
            callId: activeCall.callId.toString(),
            jsep: localDescription.toMap(),
          ));
          await peerConnection.setLocalDescription(localDescription);
        }
      });
    }
  }

  Future<void> __onPeerConnectionEventIceCandidateIdentified(
    _PeerConnectionEventIceCandidateIdentified event,
    Emitter<CallState> emit,
  ) async {
    await state.performOnActiveCall(event.uuid, (activeCall) {
      if (!activeCall.wasHungUp) {
        return _signalingClient?.execute(IceTrickleRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: activeCall.line,
          candidate: event.candidate.toMap(),
        ));
      }
    });
  }

  Future<void> __onPeerConnectionEventStreamAdded(
    _PeerConnectionEventStreamAdded event,
    Emitter<CallState> emit,
  ) async {
    await state.performOnActiveCall(event.uuid, (activeCall) {
      activeCall.renderers.remote.srcObject = event.stream;
    });
  }

  Future<void> __onPeerConnectionEventStreamRemoved(
    _PeerConnectionEventStreamRemoved event,
    Emitter<CallState> emit,
  ) async {
    await state.performOnActiveCall(event.uuid, (activeCall) {
      activeCall.renderers.remote.srcObject = null;
    });
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
    var newState = state.copyWith(minimized: false);

    newState = newState.copyWithMappedActiveCalls((activeCall) {
      final transfer = activeCall.transfer;
      if (transfer != null && transfer.isBlind && transfer.isInitiated) {
        return activeCall.copyWith(
          transfer: null,
        );
      } else {
        return activeCall;
      }
    });

    emit(newState);
  }

  Future<void> __onCallScreenEventDidPop(
    _CallScreenEventDidPop event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWith(minimized: state.activeCalls.isEmpty ? null : true));
  }

  // WebtritSignalingClient listen handlers

  void _onSignalingStateHandshake(StateHandshake stateHandshake) {
    add(_HandshakeSignalingEvent.state(
      registrationStatus: stateHandshake.registration.status,
      linesCount: stateHandshake.lines.length,
    ));

    activeCallsLoop:
    for (final activeCall in state.activeCalls) {
      if (activeCall.line == _kUndefinedLine) {
        for (final line in stateHandshake.lines) {
          if (line != null && line.callId == activeCall.callId.value) {
            continue activeCallsLoop;
          }
        }
      }
      if (activeCall.line < stateHandshake.lines.length) {
        final line = stateHandshake.lines[activeCall.line];
        if (line != null && line.callId == activeCall.callId.value) {
          continue activeCallsLoop;
        }
      }
      if (activeCall.direction == Direction.outgoing &&
          activeCall.acceptedTime == null &&
          activeCall.hungUpTime == null) {
        // Handles an outgoing active call that has not yet started, typically initiated
        // by the `continueStartCallIntent` callback of `CallkeepDelegate`.
        // TODO: Implement a dedicated flag to confirm successful execution of
        // OutgoingCallRequest, ensuring reliable outgoing active call state tracking.
        continue activeCallsLoop;
      }

      _peerConnectionConditionalCompleteError(activeCall.callId.uuid, 'Active call Request Terminated');

      add(_CallSignalingEvent.hangup(
        line: activeCall.line,
        callId: activeCall.callId,
        code: 487,
        reason: 'Request Terminated',
      ));
    }

    for (final activeLine in stateHandshake.lines.whereType<Line>()) {
      // TODO: extend logic of call logs analysis for such case as signaling reconnect
      for (final callLog in activeLine.callLogs) {
        if (callLog is CallEventLog) {
          final event = callLog.callEvent;
          if (event is IncomingCallEvent && activeLine.callLogs.length == 1) {
            _onSignalingEvent(event);
          }
        }
      }
    }
  }

  void _onSignalingEvent(Event event) {
    if (event is IncomingCallEvent) {
      add(_CallSignalingEvent.incoming(
        line: event.line,
        callId: CallIdValue(event.callId),
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
        callId: CallIdValue(event.callId),
      ));
    } else if (event is ProgressEvent) {
      add(_CallSignalingEvent.progress(
        line: event.line,
        callId: CallIdValue(event.callId),
        callee: event.callee,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is AcceptedEvent) {
      add(_CallSignalingEvent.accepted(
        line: event.line,
        callId: CallIdValue(event.callId),
        callee: event.callee,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is HangupEvent) {
      add(_CallSignalingEvent.hangup(
        line: event.line,
        callId: CallIdValue(event.callId),
        code: event.code,
        reason: event.reason,
      ));
    } else if (event is UpdatingCallEvent) {
      add(_CallSignalingEvent.updating(
        line: event.line,
        callId: CallIdValue(event.callId),
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
        callId: CallIdValue(event.callId),
      ));
    } else if (event is RegisteringEvent) {
      add(const _CallSignalingEvent.registering());
    } else if (event is RegisteredEvent) {
      add(const _CallSignalingEvent.registered());
    } else if (event is RegistrationFailedEvent) {
      add(const _CallSignalingEvent.registrationFailed());
    } else if (event is UnregisteringEvent) {
      add(const _CallSignalingEvent.unregistering());
    } else if (event is UnregisteredEvent) {
      add(const _CallSignalingEvent.unregistered());
    } else {
      _logger.warning('unhandled signaling event $event');
    }
  }

  void _onSignalingError(error, [StackTrace? stackTrace]) {
    _logger.severe('_onErrorCallback', error, stackTrace);

    _reconnectInitiated();
  }

  void _onSignalingDisconnect(int? code, String? reason) {
    add(_SignalingClientEvent.disconnected(code, reason));
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
    UuidValue uuid,
    CallkeepIncomingCallError? error,
  ) {
    _logger.fine(() => 'didPushIncomingCall handle: $handle displayName: $displayName video: $video'
        ' callId: $callId uuid: $uuid error: $error');

    add(_CallPushEvent.incoming(
      callId: CallIdValue(callId, uuid),
      handle: handle,
      displayName: displayName,
      video: video,
      error: error,
    ));
  }

  @override
  Future<bool> performStartCall(
    UuidValue uuid,
    CallkeepHandle handle,
    String? displayNameOrContactIdentifier,
    bool video,
  ) {
    return _perform(_CallPerformEvent.started(
      uuid,
      handle: handle,
      displayName: displayNameOrContactIdentifier,
      video: video,
    ));
  }

  @override
  Future<bool> performAnswerCall(UuidValue uuid) {
    return _perform(_CallPerformEvent.answered(uuid));
  }

  @override
  Future<bool> performEndCall(UuidValue uuid) {
    return _perform(_CallPerformEvent.ended(uuid));
  }

  @override
  Future<bool> performSetHeld(UuidValue uuid, bool onHold) {
    return _perform(_CallPerformEvent.setHeld(uuid, onHold));
  }

  @override
  Future<bool> performSetMuted(UuidValue uuid, bool muted) {
    return _perform(_CallPerformEvent.setMuted(uuid, muted));
  }

  @override
  Future<bool> performSendDTMF(UuidValue uuid, String key) {
    return _perform(_CallPerformEvent.sentDTMF(uuid, key));
  }

  @override
  void didActivateAudioSession() {
    _logger.fine('didActivateAudioSession');
    navigator.mediaDevices.ondevicechange = (event) {
      add(const _NavigatorMediaDevicesChange());
    };
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
    navigator.mediaDevices.ondevicechange = null;
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
      await Helper.setAppleAudioConfiguration(
          AppleAudioConfiguration(appleAudioMode: video ? AppleAudioMode.videoChat : AppleAudioMode.voiceChat));
      await Helper.setSpeakerphoneOn(video);
    }

    return localStream;
  }

  Future<RTCPeerConnection> _createPeerConnection(UuidValue uuid) async {
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

        add(_PeerConnectionEvent.signalingStateChanged(uuid, signalingState));
      }
      ..onConnectionState = (connectionState) {
        logger.fine(() => 'onConnectionState state: $connectionState');

        add(_PeerConnectionEvent.connectionStateChanged(uuid, connectionState));
      }
      ..onIceGatheringState = (iceGatheringState) {
        logger.fine(() => 'onIceGatheringState state: $iceGatheringState');

        add(_PeerConnectionEvent.iceGatheringStateChanged(uuid, iceGatheringState));
      }
      ..onIceConnectionState = (iceConnectionState) {
        logger.fine(() => 'onIceConnectionState state: $iceConnectionState');

        add(_PeerConnectionEvent.iceConnectionStateChanged(uuid, iceConnectionState));
      }
      ..onIceCandidate = (candidate) {
        logger.fine(() => 'onIceCandidate candidate: $candidate');

        add(_PeerConnectionEvent.iceCandidateIdentified(uuid, candidate));
      }
      ..onAddStream = (stream) {
        logger.fine(() => 'onAddStream stream: $stream');

        add(_PeerConnectionEvent.streamAdded(uuid, stream));
      }
      ..onRemoveStream = (stream) {
        logger.fine(() => 'onRemoveStream stream: $stream');

        add(_PeerConnectionEvent.streamRemoved(uuid, stream));
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
    recentsRepository.add(Recent(
      direction: activeCall.direction,
      number: activeCall.handle.value,
      video: activeCall.video,
      createdTime: activeCall.createdTime,
      acceptedTime: activeCall.acceptedTime,
      hungUpTime: activeCall.hungUpTime,
    ));
  }

  Future<void> _ringtoneOutgoingPlay() async {
    await _audioPlayer.setAsset(Assets.ringtones.outgoingCall1);
    await _audioPlayer.setLoopMode(LoopMode.one);
    _audioPlayer.play();
  }

  Future<void> _ringtoneStop() async {
    await _audioPlayer.stop();
  }

  Uri _parseCoreUrlToSignalingUrl(String coreUrl) {
    final uri = Uri.parse(coreUrl);
    if (uri.scheme.endsWith('s')) {
      return uri.replace(scheme: 'wss');
    } else {
      return uri.replace(scheme: 'ws');
    }
  }
}
