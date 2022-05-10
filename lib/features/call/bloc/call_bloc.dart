import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:callkeep/callkeep.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/data/secure_storage.dart';
import 'package:webtrit_phone/environment_config.dart';
import 'package:webtrit_phone/features/notifications/notifications.dart';
import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'call_bloc.freezed.dart';

part 'call_event.dart';

part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> with WidgetsBindingObserver {
  final RecentsRepository recentsRepository;
  final NotificationsBloc notificationsBloc;
  final AppBloc appBloc;
  final FlutterCallkeep callkeep;

  final _logger = Logger('$CallBloc');

  late final StreamSubscription<ConnectivityResult> _connectivityChangedSubscription;
  ConnectivityResult?
      _previousConnectivityResult; // necessary because of issue on iOS with doubling the same connectivity result

  late final WebtritSignalingClient _signalingClient;

  int _signalingClientConnectInSequanceErrorCount = 0; // TODO: reorganise this logic somehow

  MediaStream? _localStream;

  RTCPeerConnection? _peerConnection;

  final _audioPlayer = AudioPlayer();

  CallBloc({
    required this.recentsRepository,
    required this.notificationsBloc,
    required this.appBloc,
    required this.callkeep,
  }) : super(const CallState.initial()) {
    on<CallStarted>(
      _onCallStarted,
      transformer: sequential(),
    );
    on<_SignalingClientConnectInitiated>(
      _onSignalingClientConnectInitiated,
      transformer: droppable(),
    );
    on<_SignalingClientDisconnectInitiated>(
      _onSignalingClientDisconnectInitiated,
      transformer: droppable(),
    );
    on<_SignalingClientDisconnected>(
      _onSignalingClientDisconnected,
      transformer: sequential(),
    );
    on<CallIncomingReceived>(
      _onIncomingReceived,
      transformer: sequential(),
    );
    on<CallIncomingAccepted>(
      _onIncomingAccepted,
      transformer: sequential(),
    );
    on<CallOutgoingStarted>(
      _onOutgoingStarted,
      transformer: sequential(),
    );
    on<CallOutgoingAccepted>(
      _onOutgoingAccepted,
      transformer: sequential(),
    );
    on<_RemoteStreamAdded>(
      _onRemoteStreamAdded,
      transformer: sequential(),
    );
    on<_RemoteStreamRemoved>(
      _onRemoteStreamRemoved,
      transformer: sequential(),
    );
    on<CallRemoteHungUp>(
      _onRemoteHungUp,
      transformer: sequential(),
    );
    on<CallLocalHungUp>(
      _onLocalHungUp,
      transformer: sequential(),
    );
    on<CallCameraSwitched>(
      _onCameraSwitched,
      transformer: sequential(),
    );
    on<CallCameraEnabled>(
      _onCameraEnabled,
      transformer: sequential(),
    );
    on<CallMicrophoneEnabled>(
      _onMicrophoneEnabled,
      transformer: sequential(),
    );
    on<CallSpeakerphoneEnabled>(
      _onSpeakerphoneEnabled,
      transformer: sequential(),
    );
    on<CallFailureApproved>(
      _onFailureApproved,
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

    WidgetsBinding.instance!.addObserver(this);

    _connectivityChangedSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (_previousConnectivityResult != result) {
        _previousConnectivityResult = result;
        add(_ConnectivityResultChanged(result));
      }
    });

    _signalingClient = WebtritSignalingClient(
      EnvironmentConfig.SIGNALING_URL,
      onEvent: _onSignalingEvent,
      onError: _onSignalingError,
      onDisconnect: _onSignalingDisconnect,
    );
  }

  @override
  Future<void> close() async {
    _connectivityChangedSubscription.cancel();

    WidgetsBinding.instance!.removeObserver(this);

    await _signalingClient.disconnect();
    await _audioPlayer.dispose();
    await super.close();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    add(_AppLifecycleStateChanged(state));
  }

  Future<void> _onCallStarted(
    CallStarted event,
    Emitter<CallState> emit,
  ) async {
    add(const _SignalingClientConnectInitiated());
  }

  Future<void> _onSignalingClientConnectInitiated(
    _SignalingClientConnectInitiated event,
    Emitter<CallState> emit,
  ) async {
    emit(const CallState.signalingInProgress());
    try {
      final token = await SecureStorage().readToken();
      await _signalingClient.connect(token!, true);
      _signalingClientConnectInSequanceErrorCount = 0;

      emit(const CallState.idle());

      appBloc.add(const AppRegistered()); // TODO: get rid of this event
    } catch (e) {
      if (_signalingClientConnectInSequanceErrorCount <= 0) {
        notificationsBloc.add(const NotificationsIssued(CallConnectErrorNotification()));
        _signalingClientConnectInSequanceErrorCount++;
      }

      emit(CallState.signalingFailure(
        reason: e.toString(),
      ));

      Future.delayed(const Duration(seconds: 3), () => add(const _SignalingClientConnectInitiated()));
    }
  }

  Future<void> _onSignalingClientDisconnectInitiated(
    _SignalingClientDisconnectInitiated event,
    Emitter<CallState> emit,
  ) async {
    emit(const CallState.signalingInProgress());
    try {
      await _signalingClient.disconnect();
    } catch (e) {
      emit(CallState.signalingFailure(
        reason: e.toString(),
      ));
    } finally {
      emit(const CallState.initial());
    }
  }

  Future<void> _onSignalingClientDisconnected(
    _SignalingClientDisconnected event,
    Emitter<CallState> emit,
  ) async {
    emit(const CallState.initial());

    add(const _SignalingClientConnectInitiated());
  }

  Future<void> _onIncomingReceived(
    CallIncomingReceived event,
    Emitter<CallState> emit,
  ) async {
    await _audioPlayer.setAsset(Assets.ringtones.incomingCall1);
    await _audioPlayer.setLoopMode(LoopMode.one);
    _audioPlayer.play();

    emit(CallState.active(
      direction: Direction.incoming,
      callId: event.callId,
      number: event.username,
      video: true,
      createdTime: DateTime.now(),
    ));

    _localStream = await _getUserMedia(video: true);

    emit(state.maybeMap(
      active: (state) => state.copyWith(localStream: _localStream),
      orElse: () => throw StateError('Incorrect state: $state'),
    ));

    _peerConnection = await _createPeerConnection();
    await _peerConnection!.addStream(_localStream!);

    final remoteDescription = RTCSessionDescription(event.jsepData!['sdp'], event.jsepData!['type']);
    await _peerConnection!.setRemoteDescription(remoteDescription);
  }

  Future<void> _onIncomingAccepted(
    CallIncomingAccepted event,
    Emitter<CallState> emit,
  ) async {
    await _audioPlayer.stop();

    emit(state.maybeMap(
      active: (state) => state.copyWith(acceptedTime: DateTime.now()),
      orElse: () => throw StateError('Incorrect state: $state'),
    ));

    final localDescription = await _peerConnection!.createAnswer({});
    _peerConnection!.setLocalDescription(localDescription);

    final callId = state.maybeMap(
      active: (state) => state.callId,
      orElse: () => throw StateError('Incorrect state: $state'),
    );
    await _signalingClient.execute(AcceptRequest(
      callId: callId,
      jsep: localDescription.toMap(),
    ));
  }

  Future<void> _onOutgoingStarted(
    CallOutgoingStarted event,
    Emitter<CallState> emit,
  ) async {
    if (state is! IdleCallState) {
      notificationsBloc.add(const NotificationsIssued(CallNotIdleErrorNotification()));
      return;
    }

    emit(CallState.active(
      direction: Direction.outgoing,
      callId: WebtritSignalingClient.generateCallId(),
      number: event.number,
      video: event.video,
      createdTime: DateTime.now(),
    ));

    _localStream = await _getUserMedia(video: event.video);

    emit(state.maybeMap(
      active: (state) => state.copyWith(localStream: _localStream),
      orElse: () => throw StateError('Incorrect state: $state'),
    ));

    _peerConnection = await _createPeerConnection();
    await _peerConnection!.addStream(_localStream!);

    final localDescription = await _peerConnection!.createOffer({});
    _peerConnection!.setLocalDescription(localDescription);

    final callId = state.maybeMap(
      active: (state) => state.callId,
      orElse: () => throw StateError('Incorrect state: $state'),
    );
    try {
      await _signalingClient.execute(OutgoingCallRequest(
        callId: callId,
        number: event.number,
        jsep: localDescription.toMap(),
      ));

      await _audioPlayer.setAsset(Assets.ringtones.outgoingCall1);
      await _audioPlayer.setLoopMode(LoopMode.one);
      _audioPlayer.play();
    } catch (e) {
      await _peerConnection!.close();
      _peerConnection = null;

      await _localStream!.dispose();
      _localStream = null;

      _addToRecents(state);

      emit(CallState.failure(reason: e.toString()));
    }
  }

  Future<void> _onOutgoingAccepted(
    CallOutgoingAccepted event,
    Emitter<CallState> emit,
  ) async {
    await _audioPlayer.stop();

    emit(state.maybeMap(
      active: (state) => state.copyWith(acceptedTime: DateTime.now()),
      orElse: () => throw StateError('Incorrect state: $state'),
    ));

    final remoteDescription = RTCSessionDescription(event.jsepData!['sdp'], event.jsepData!['type']);
    await _peerConnection!.setRemoteDescription(remoteDescription);
  }

  Future<void> _onRemoteStreamAdded(
    _RemoteStreamAdded event,
    Emitter<CallState> emit,
  ) async {
    emit(state.maybeMap(
      active: (state) => state.copyWith(remoteStream: event.stream),
      orElse: () => throw StateError('Incorrect state: $state'),
    ));
  }

  Future<void> _onRemoteStreamRemoved(
    _RemoteStreamRemoved event,
    Emitter<CallState> emit,
  ) async {
    emit(state.maybeMap(
      active: (state) => state.copyWith(remoteStream: null),
      orElse: () => throw StateError('Incorrect state: $state'),
    ));
  }

  Future<void> _onRemoteHungUp(
    CallRemoteHungUp event,
    Emitter<CallState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ActiveCallState) return; // TODO: get rid of double hangup event

    await _audioPlayer.stop();

    emit(currentState.copyWith(hungUpTime: DateTime.now()));

    _addToRecents(currentState);

    await _peerConnection?.close();
    _peerConnection = null;

    await _localStream?.dispose();
    _localStream = null;

    emit(const CallState.idle());
  }

  Future<void> _onLocalHungUp(
    CallLocalHungUp event,
    Emitter<CallState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ActiveCallState) return; // TODO: get rid of double hangup event

    await _audioPlayer.stop();

    emit(currentState.copyWith(hungUpTime: DateTime.now()));

    if (currentState.isIncoming && !currentState.accepted) {
      await _signalingClient.execute(DeclineRequest(
        callId: currentState.callId,
      ));
    } else {
      await _signalingClient.execute(HangupRequest(
        callId: currentState.callId,
      ));
    }

    _addToRecents(currentState);

    await _peerConnection?.close();
    _peerConnection = null;

    await _localStream?.dispose();
    _localStream = null;

    emit(const CallState.idle());
  }

  Future<void> _onCameraSwitched(
    CallCameraSwitched event,
    Emitter<CallState> emit,
  ) async {
    final videoTrack = _localStream?.getVideoTracks()[0];
    if (videoTrack != null) {
      await Helper.switchCamera(videoTrack);
    }
  }

  Future<void> _onCameraEnabled(
    CallCameraEnabled event,
    Emitter<CallState> emit,
  ) async {
    _localStream?.getVideoTracks()[0].enabled = event.mode;
  }

  Future<void> _onMicrophoneEnabled(
    CallMicrophoneEnabled event,
    Emitter<CallState> emit,
  ) async {
    final audioTrack = _localStream?.getAudioTracks()[0];
    if (audioTrack != null) {
      Helper.setMicrophoneMute(!event.mode, audioTrack);
    }
  }

  Future<void> _onSpeakerphoneEnabled(
    CallSpeakerphoneEnabled event,
    Emitter<CallState> emit,
  ) async {
    _localStream?.getAudioTracks()[0].enableSpeakerphone(event.mode);
  }

  Future<void> _onFailureApproved(
    CallFailureApproved event,
    Emitter<CallState> emit,
  ) async {
    emit(const CallState.idle());
  }

  Future<void> _onAppLifecycleStateChanged(
    _AppLifecycleStateChanged event,
    Emitter<CallState> emit,
  ) async {
    final appLifecycleState = event.state;
  }

  Future<void> _onConnectivityResultChanged(
    _ConnectivityResultChanged event,
    Emitter<CallState> emit,
  ) async {
    final connectivityResult = event.result;
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

  Future<RTCPeerConnection> _createPeerConnection() async {
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

        if (iceGatheringState == RTCIceGatheringState.RTCIceGatheringStateComplete) {
          final callId = state.maybeMap(
            active: (state) => state.callId,
            orElse: () => throw StateError('Incorrect state: $state'),
          );
          _signalingClient.execute(TrickleRequest(
            callId: callId,
            candidate: null,
          ));
        }
      }
      ..onIceConnectionState = (iceConnectionState) {
        logger.fine(() => 'onIceConnectionState state: $iceConnectionState');
      }
      ..onIceCandidate = (candidate) {
        logger.fine(() => 'onIceCandidate candidate: $candidate');

        final callId = state.maybeMap(
          active: (state) => state.callId,
          orElse: () => throw StateError('Incorrect state: $state'),
        );
        _signalingClient.execute(TrickleRequest(
          callId: callId,
          candidate: candidate.toMap(),
        ));
      }
      ..onAddStream = (stream) {
        logger.fine(() => 'onAddStream stream: $stream');

        add(_RemoteStreamAdded(stream: stream));
      }
      ..onRemoveStream = (stream) {
        logger.fine(() => 'onRemoveStream stream: $stream');

        add(_RemoteStreamRemoved(stream: stream));
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

  void _addToRecents(CallState state) {
    final recent = state.maybeMap(
      active: (state) => Recent(
        direction: state.direction,
        number: state.number,
        video: state.video,
        createdTime: state.createdTime,
        acceptedTime: state.acceptedTime,
        hungUpTime: state.hungUpTime,
      ),
      orElse: () => throw StateError('Incorrect state: $state'),
    );

    recentsRepository.add(recent);
  }

  void _onSignalingEvent(Event event) {
    if (event is IncomingCallEvent) {
      add(CallIncomingReceived(callId: event.callId, username: event.caller, jsepData: event.jsep));
    } else if (event is AnsweredEvent) {
      add(CallOutgoingAccepted(username: event.callee, jsepData: event.jsep));
    } else if (event is HangupEvent) {
      add(CallRemoteHungUp(reason: event.reason));
    } else {
      _logger.warning('unhandled signaling event $event');
    }
  }

  void _onSignalingError(error, [StackTrace? stackTrace]) {
    // TODO: add necessary logic
    _logger.severe('_onErrorCallback { error: $error, stackTrace: $stackTrace } / not implemented');
  }

  void _onSignalingDisconnect(int? code, String? reason) {
    _logger.info('_onSignalingDisconnect code: $code reason: $reason');
    add(_SignalingClientDisconnected(code, reason));
  }
}
