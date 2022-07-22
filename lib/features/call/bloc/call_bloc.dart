import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';

import 'package:audio_session/audio_session.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/app/consts.dart';
import 'package:webtrit_phone/blocs/blocs.dart';
import 'package:webtrit_phone/features/notifications/notifications.dart';
import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

import '../models/models.dart';

part 'call_bloc.freezed.dart';

part 'call_event.dart';

part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> with WidgetsBindingObserver implements CallkeepDelegate {
  final RecentsRepository recentsRepository;
  final NotificationsBloc notificationsBloc;
  final AppBloc appBloc;
  final Callkeep callkeep;

  final _logger = Logger('$CallBloc');

  StreamSubscription<ConnectivityResult>? _connectivityChangedSubscription;
  StreamSubscription<AVAudioSessionRouteChange>? _routeChangeSubscription;

  WebtritSignalingClient? _signalingClient;
  Timer? _signalingClientReconnectTimer;

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
    on<_AudioSessionRouteChanged>(
      _onAudioSessionRouteChanged,
      transformer: droppable(),
    );
    on<_SignalingClientEvent>(
      _onSignalingClientEvent,
      transformer: restartable(),
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

    WidgetsBinding.instance.addObserver(this);

    callkeep.setDelegate(this);
  }

  @override
  Future<void> close() async {
    callkeep.setDelegate(null);

    WidgetsBinding.instance.removeObserver(this);

    await _connectivityChangedSubscription?.cancel();
    await _routeChangeSubscription?.cancel();

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

    if (Platform.isIOS) {
      _routeChangeSubscription = AVAudioSession().routeChangeStream.listen((event) {
        add(const _AudioSessionRouteChanged());
      });
      _routeChangeSubscription?.pause();
    }
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

  Future<void> _onAudioSessionRouteChanged(
    _AudioSessionRouteChanged event,
    Emitter<CallState> emit,
  ) async {
    final currentRoute = await AVAudioSession().currentRoute;
    final outputs = currentRoute.outputs;
    if (outputs.isNotEmpty) {
      emit(state.copyWith(speaker: outputs.first.portType == AVAudioSessionPort.builtInSpeaker));
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

      final signalingUrl = _coreUrlToSignalingUrl(appBloc.state.coreUrl!);
      final token = appBloc.state.token!;
      final httpClient = HttpClient();
      httpClient.connectionTimeout = kSignalingClientConnectionTimeout;
      final signalingClient = await WebtritSignalingClient.connect(
        signalingUrl,
        token,
        true,
        customHttpClient: httpClient,
      );

      if (emit.isDone) {
        await signalingClient.disconnect(WebSocketStatus.goingAway);
        return;
      }

      signalingClient.listen(
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
      callId: event.callId,
      handle: event.handle,
      displayName: event.displayName,
      video: event.video,
      createdTime: DateTime.now(),
    )));

    // the rest logic implemented within _CallSignalingEventState processing
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
      } else {
        _logger.warning('__onCallSignalingEventIncoming reportNewIncomingCall error: $error');
        // TODO: implement correct incoming call hangup (take into account that _signalingClient could be disconnected)
        return;
      }
    } else {
      emit(state.copyWithPushActiveCall(ActiveCall(
        direction: Direction.incoming,
        callId: event.callId,
        handle: handle,
        displayName: event.callerDisplayName,
        video: video,
        createdTime: DateTime.now(),
      )));
    }

    late final MediaStream localStream;
    try {
      localStream = await _getUserMedia(video: video);
    } catch (e, stackTrace) {
      _logger.warning('__onCallSignalingEventIncoming _getUserMedia', e, stackTrace);

      await callkeep.reportEndCall(event.callId.uuid, CallkeepEndCallReason.failed);

      emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
        final activeCallUpdated = activeCall.copyWith(hungUpTime: DateTime.now());
        _addToRecents(activeCallUpdated);
        return activeCallUpdated;
      }));

      await state.performOnActiveCall(event.callId.uuid, (activeCall) {
        return _signalingClient?.execute(DeclineRequest(
          callId: activeCall.callId.toString(),
        ));
      });

      emit(state.copyWithPopActiveCall(event.callId.uuid));

      notificationsBloc.add(const NotificationsIssued(CallUserMediaErrorNotification()));
      return;
    }

    emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
      return activeCall.copyWith(localStream: localStream);
    }));

    final peerConnection = await _createPeerConnection(event.callId.uuid);
    await peerConnection.addStream(localStream);

    final jsep = event.jsep;
    if (jsep != null) {
      final remoteDescription = jsep.toDescription();
      await peerConnection.setRemoteDescription(remoteDescription);
    }

    emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
      return activeCall.copyWith(peerConnection: peerConnection);
    }));
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
      await state.performOnActiveCall(event.callId.uuid, (activeCall) {
        final remoteDescription = jsep.toDescription();
        return activeCall.peerConnection!.setRemoteDescription(remoteDescription);
      });
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
      return activeCall.copyWith(acceptedTime: DateTime.now());
    }));

    final jsep = event.jsep;
    if (jsep != null) {
      await state.performOnActiveCall(event.callId.uuid, (activeCall) {
        final remoteDescription = jsep.toDescription();
        return activeCall.peerConnection!.setRemoteDescription(remoteDescription);
      });
    }
  }

  Future<void> __onCallSignalingEventHangup(
    _CallSignalingEventHangup event,
    Emitter<CallState> emit,
  ) async {
    if (state.retrieveActiveCall(event.callId.uuid)?.wasHungUp == true) return;

    await _ringtoneStop();

    emit(state.copyWithMappedActiveCall(event.callId.uuid, (activeCall) {
      final activeCallUpdated = activeCall.copyWith(hungUpTime: DateTime.now());
      _addToRecents(activeCallUpdated);
      return activeCallUpdated;
    }));

    await state.performOnActiveCall(event.callId.uuid, (activeCall) async {
      await activeCall.peerConnection?.close();
      await activeCall.localStream?.dispose();
    });

    emit(state.copyWithPopActiveCall(event.callId.uuid));

    await callkeep.reportEndCall(event.callId.uuid, CallkeepEndCallReason.remoteEnded);
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
    );
  }

  Future<void> __onCallControlEventStarted(
    _CallControlEventStarted event,
    Emitter<CallState> emit,
  ) async {
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
        callId: callId,
        handle: event.handle,
        displayName: event.displayName,
        video: event.video,
        createdTime: DateTime.now(),
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
    await state.performOnActiveCall(event.uuid, (activeCall) {
      final videoTrack = activeCall.localStream?.getVideoTracks()[0];
      if (videoTrack != null) {
        Helper.switchCamera(videoTrack);
      }
    });
  }

  Future<void> _onCallControlEventCameraEnabled(
    _CallControlEventCameraEnabled event,
    Emitter<CallState> emit,
  ) async {
    await state.performOnActiveCall(event.uuid, (activeCall) {
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
    await state.performOnActiveCall(event.uuid, (activeCall) {
      final audioTrack = activeCall.localStream?.getAudioTracks()[0];
      if (audioTrack != null) {
        audioTrack.enableSpeakerphone(event.enabled);
      }
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
    if (state.signalingClientStatus != SignalingClientStatus.connect) {
      event.fail();

      emit(state.copyWithPopActiveCall(event.uuid));

      notificationsBloc.add(const NotificationsIssued(CallSignalingClientNotConnectErrorNotification()));
      return;
    }
    late final MediaStream localStream;
    try {
      localStream = await _getUserMedia(video: event.video);
    } catch (e, stackTrace) {
      _logger.warning('__onCallPerformEventStarted _getUserMedia', e, stackTrace);

      event.fail();

      emit(state.copyWithPopActiveCall(event.uuid));

      notificationsBloc.add(const NotificationsIssued(CallUserMediaErrorNotification()));
      return;
    }
    event.fulfill();

    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(localStream: localStream);
    }));

    final peerConnection = await _createPeerConnection(event.uuid);
    await peerConnection.addStream(localStream);

    final localDescription = await peerConnection.createOffer({});
    // Need to initiate outgoing call before set localDescription to avoid races
    // between [OutgoingCallRequest] and [IceTrickleRequest]s.
    await state.performOnActiveCall(event.uuid, (activeCall) {
      return _signalingClient?.execute(OutgoingCallRequest(
        callId: activeCall.callId.toString(),
        number: activeCall.handle.value,
        jsep: localDescription.toMap(),
      ));
    });
    await peerConnection.setLocalDescription(localDescription);

    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(peerConnection: peerConnection);
    }));

    await callkeep.reportConnectingOutgoingCall(event.uuid);
  }

  Future<void> __onCallPerformEventAnswered(
    _CallPerformEventAnswered event,
    Emitter<CallState> emit,
  ) async {
    event.fulfill();

    await _ringtoneStop();

    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(acceptedTime: DateTime.now());
    }));

    await state.performOnActiveCall(event.uuid, (activeCall) async {
      final peerConnection = activeCall.peerConnection!;

      final localDescription = peerConnection.signalingState == RTCSignalingState.RTCSignalingStateHaveRemoteOffer
          ? await peerConnection.createAnswer({})
          : await peerConnection.createOffer({});
      await _signalingClient?.execute(AcceptRequest(
        callId: activeCall.callId.toString(),
        jsep: localDescription.toMap(),
      ));
      await peerConnection.setLocalDescription(localDescription);
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
      final activeCallUpdated = activeCall.copyWith(hungUpTime: DateTime.now());
      _addToRecents(activeCallUpdated);
      return activeCallUpdated;
    }));

    await state.performOnActiveCall(event.uuid, (activeCall) async {
      if (activeCall.isIncoming && !activeCall.wasAccepted) {
        await _signalingClient?.execute(DeclineRequest(
          callId: activeCall.callId.toString(),
        ));
      } else {
        await _signalingClient?.execute(HangupRequest(
          callId: activeCall.callId.toString(),
        ));
      }

      // Need to close peer connection after executing [HangupRequest]
      // to prevent "Simulate a "hangup" coming from the application"
      // because of "No WebRTC media anymore".
      await activeCall.peerConnection?.close();
      await activeCall.localStream?.dispose();
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
          callId: activeCall.callId.toString(),
          direction: HoldDirection.inactive,
        ));
      } else {
        return _signalingClient?.execute(UnholdRequest(
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
      final audioTrack = activeCall.localStream?.getAudioTracks()[0];
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
      final senders = await activeCall.peerConnection?.senders;
      if (senders != null) {
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
      iceGatheringStateChanged: (event) => __onPeerConnectionEventIceGatheringStateChanged(event, emit),
      iceCandidateIdentified: (event) => __onPeerConnectionEventIceCandidateIdentified(event, emit),
      streamAdded: (event) => __onPeerConnectionEventStreamAdded(event, emit),
      streamRemoved: (event) => __onPeerConnectionEventStreamRemoved(event, emit),
    );
  }

  Future<void> __onPeerConnectionEventIceGatheringStateChanged(
    _PeerConnectionEventIceGatheringStateChanged event,
    Emitter<CallState> emit,
  ) async {
    if (event.state == RTCIceGatheringState.RTCIceGatheringStateComplete) {
      await state.performOnActiveCall(event.uuid, (activeCall) {
        if (!activeCall.wasHungUp) {
          return _signalingClient?.execute(IceTrickleRequest(
            callId: activeCall.callId.toString(),
            candidate: null,
          ));
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
          callId: activeCall.callId.toString(),
          candidate: event.candidate.toMap(),
        ));
      }
    });
  }

  Future<void> __onPeerConnectionEventStreamAdded(
    _PeerConnectionEventStreamAdded event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(remoteStream: event.stream);
    }));
  }

  Future<void> __onPeerConnectionEventStreamRemoved(
    _PeerConnectionEventStreamRemoved event,
    Emitter<CallState> emit,
  ) async {
    emit(state.copyWithMappedActiveCall(event.uuid, (activeCall) {
      return activeCall.copyWith(remoteStream: null);
    }));
  }

  // WebtritSignalingClient listen handlers

  void _onSignalingEvent(Event event) {
    if (event is StateEvent) {
      final activeCallIds = Set.from(state.activeCalls.map((activeCall) => activeCall.callId.callId));
      final signalingStateCallIds = Set.from(event.calls.keys);
      for (final callId in activeCallIds.difference(signalingStateCallIds)) {
        add(_CallSignalingEvent.hangup(
          callId: CallIdValue(callId),
          code: 487,
          reason: 'Request Terminated',
        ));
      }

      event.calls.forEach((callIdString, callLogs) {
        // TODO: extend logic of call logs analysis for such case as signaling reconnect
        for (var callLog in callLogs) {
          if (callLog is CallEventLog) {
            final event = callLog.callEvent;
            if (event is IncomingCallEvent) {
              _onSignalingEvent(event);
            }
          }
        }
      });
    } else if (event is IncomingCallEvent) {
      add(_CallSignalingEvent.incoming(
        callId: CallIdValue(event.callId),
        callee: event.callee,
        caller: event.caller,
        callerDisplayName: event.callerDisplayName,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is RingingEvent) {
      add(_CallSignalingEvent.ringing(
        callId: CallIdValue(event.callId),
      ));
    } else if (event is ProgressEvent) {
      add(_CallSignalingEvent.progress(
        callId: CallIdValue(event.callId),
        callee: event.callee,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is AcceptedEvent) {
      add(_CallSignalingEvent.accepted(
        callId: CallIdValue(event.callId),
        callee: event.callee,
        jsep: JsepValue.fromOptional(event.jsep),
      ));
    } else if (event is HangupEvent) {
      add(_CallSignalingEvent.hangup(
        callId: CallIdValue(event.callId),
        code: event.code,
        reason: event.reason,
      ));
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
    _logger.fine(() => 'didStartCallIntent handle: $handle displayName: $displayName video: $video');

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
    _routeChangeSubscription?.resume();
  }

  @override
  void didDeactivateAudioSession() {
    _logger.fine('didDeactivateAudioSession');
    _routeChangeSubscription?.pause();
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

  Future<MediaStream> _getUserMedia({required bool video}) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': video
          ? {
              'mandatory': {
                'minWidth': '640',
                'minHeight': '480',
                'minFrameRate': '30',
              },
              'facingMode': 'user',
              'optional': [],
            }
          : false,
    };
    final localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    localStream.getAudioTracks()[0].enableSpeakerphone(video);

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
      }
      ..onConnectionState = (connectionState) {
        logger.fine(() => 'onConnectionState state: $connectionState');
      }
      ..onIceGatheringState = (iceGatheringState) {
        logger.fine(() => 'onIceGatheringState state: $iceGatheringState');

        add(_PeerConnectionEvent.iceGatheringStateChanged(uuid, iceGatheringState));
      }
      ..onIceConnectionState = (iceConnectionState) {
        logger.fine(() => 'onIceConnectionState state: $iceConnectionState');
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

  String _coreUrlToSignalingUrl(String coreUrl) {
    final uri = Uri.parse(coreUrl);
    if (uri.scheme.endsWith('s')) {
      return uri.replace(scheme: 'wss').toString();
    } else {
      return uri.replace(scheme: 'ws').toString();
    }
  }
}
