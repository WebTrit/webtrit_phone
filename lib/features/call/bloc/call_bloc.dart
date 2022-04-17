import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/features/notifications/notifications.dart';
import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/app/assets.gen.dart';
import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'call_event.dart';

part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository callRepository;
  final RecentsRepository recentsRepository;
  final NotificationsBloc notificationsBloc;
  final AppBloc appBloc;

  StreamSubscription? _onIncomingCallSubscription;
  StreamSubscription? _onAcceptedSubscription;
  StreamSubscription? _onHangUpSubscription;
  StreamSubscription? _onDoneSubscription;

  MediaStream? _localStream;

  RTCPeerConnection? _peerConnection;

  final _audioPlayer = AudioPlayer();

  CallBloc({
    required this.callRepository,
    required this.recentsRepository,
    required this.notificationsBloc,
    required this.appBloc,
  }) : super(const CallInitial()) {
    on<CallAttached>(
      _onAttached,
      transformer: sequential(),
    );
    on<CallDetached>(
      _onDetached,
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
    on<CallRemoteStreamAdded>(
      _onRemoteStreamAdded,
      transformer: sequential(),
    );
    on<CallRemoteStreamRemoved>(
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
  }

  @override
  Future<void> close() async {
    await _onIncomingCallSubscription?.cancel();
    await _onAcceptedSubscription?.cancel();
    await _onHangUpSubscription?.cancel();
    await _onDoneSubscription?.cancel();
    await _audioPlayer.dispose();
    await super.close();
  }

  Future<void> _onAttached(
    CallAttached event,
    Emitter<CallState> emit,
  ) async {
    emit(const CallAttachInProgress());
    try {
      await callRepository.attach();

      _onIncomingCallSubscription = callRepository.onIncomingCall.listen((event) {
        add(CallIncomingReceived(username: event.caller, jsepData: event.jsep));
      });
      _onAcceptedSubscription = callRepository.onAccepted.listen((event) {
        add(CallOutgoingAccepted(username: event.callee, jsepData: event.jsep));
      });
      _onHangUpSubscription = callRepository.onHangup.listen((event) {
        add(CallRemoteHungUp(reason: event.reason));
      });
      _onDoneSubscription = callRepository.onDone.listen((event) {
        add(const CallDetached());
      });
      emit(const CallIdle());

      appBloc.add(const AppRegistered());
    } catch (e) {
      notificationsBloc.add(const NotificationsIssued(CallAttachErrorNotification()));
      emit(CallAttachFailure(
        reason: e.toString(),
      ));
    }
  }

  Future<void> _onDetached(
    CallDetached event,
    Emitter<CallState> emit,
  ) async {
    emit(const CallInitial());

    if (callRepository.isAttached) {
      await callRepository.detach();
    }
  }

  Future<void> _onIncomingReceived(
    CallIncomingReceived event,
    Emitter<CallState> emit,
  ) async {
    await _audioPlayer.setAsset(Assets.ringtones.incomingCall1);
    await _audioPlayer.setLoopMode(LoopMode.one);
    _audioPlayer.play();

    emit(CallIncoming(
      number: event.username,
      video: true,
      createdTime: DateTime.now(),
    ));

    _localStream = await _getUserMedia(video: true);

    emit((state as CallActive).copyWith(localStream: _localStream));

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

    emit((state as CallActive).copyWith(acceptedTime: DateTime.now()));

    final localDescription = await _peerConnection!.createAnswer({});
    _peerConnection!.setLocalDescription(localDescription);

    await callRepository.accept(localDescription.toMap());
  }

  Future<void> _onOutgoingStarted(
    CallOutgoingStarted event,
    Emitter<CallState> emit,
  ) async {
    if (state is! CallIdle) {
      notificationsBloc.add(const NotificationsIssued(CallNotIdleErrorNotification()));
      return;
    }

    emit(CallOutgoing(number: event.number, video: event.video, createdTime: DateTime.now()));

    _localStream = await _getUserMedia(video: event.video);

    emit((state as CallActive).copyWith(localStream: _localStream));

    _peerConnection = await _createPeerConnection();
    await _peerConnection!.addStream(_localStream!);

    final localDescription = await _peerConnection!.createOffer({});
    _peerConnection!.setLocalDescription(localDescription);

    try {
      await callRepository.call(event.number, localDescription.toMap());

      await _audioPlayer.setAsset(Assets.ringtones.outgoingCall1);
      await _audioPlayer.setLoopMode(LoopMode.one);
      _audioPlayer.play();
    } catch (e) {
      await _peerConnection!.close();
      _peerConnection = null;

      await _localStream!.dispose();
      _localStream = null;

      _addToRecents(state);

      emit(CallFailure(reason: e.toString()));
    }
  }

  Future<void> _onOutgoingAccepted(
    CallOutgoingAccepted event,
    Emitter<CallState> emit,
  ) async {
    await _audioPlayer.stop();

    emit((state as CallActive).copyWith(acceptedTime: DateTime.now()));

    final remoteDescription = RTCSessionDescription(event.jsepData!['sdp'], event.jsepData!['type']);
    await _peerConnection!.setRemoteDescription(remoteDescription);
  }

  Future<void> _onRemoteStreamAdded(
    CallRemoteStreamAdded event,
    Emitter<CallState> emit,
  ) async {
    emit((state as CallActive).copyWith(remoteStream: event.stream));
  }

  Future<void> _onRemoteStreamRemoved(
    CallRemoteStreamRemoved event,
    Emitter<CallState> emit,
  ) async {
    emit((state as CallActive).copyWith(remoteStream: null));
  }

  Future<void> _onRemoteHungUp(
    CallRemoteHungUp event,
    Emitter<CallState> emit,
  ) async {
    if (state is! CallActive) return; // TODO: get rid of double hangup event

    await _audioPlayer.stop();

    emit((state as CallActive).copyWith(hungUpTime: DateTime.now()));

    await _peerConnection?.close();
    _peerConnection = null;

    await _localStream?.dispose();
    _localStream = null;

    _addToRecents(state);

    emit(const CallIdle());
  }

  Future<void> _onLocalHungUp(
    CallLocalHungUp event,
    Emitter<CallState> emit,
  ) async {
    if (state is! CallActive) return; // TODO: get rid of double hangup event

    await _audioPlayer.stop();

    emit((state as CallActive).copyWith(hungUpTime: DateTime.now()));

    await callRepository.hangup();

    await _peerConnection?.close();
    _peerConnection = null;

    await _localStream?.dispose();
    _localStream = null;

    _addToRecents(state);

    emit(const CallIdle());
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
    emit(const CallIdle());
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
      ..onSignalingState = (state) {
        logger.fine(() => 'onSignalingState state: $state');
      }
      ..onIceGatheringState = (state) {
        logger.fine(() => 'onIceGatheringState state: $state');

        if (state == RTCIceGatheringState.RTCIceGatheringStateComplete) {
          callRepository.sendTrickle(null);
        }
      }
      ..onIceConnectionState = (state) {
        logger.fine(() => 'onIceConnectionState state: $state');
      }
      ..onIceCandidate = (candidate) {
        logger.fine(() => 'onIceCandidate candidate: $candidate');

        callRepository.sendTrickle(candidate.toMap());
      }
      ..onAddStream = (stream) {
        logger.fine(() => 'onAddStream stream: $stream');

        add(CallRemoteStreamAdded(stream: stream));
      }
      ..onRemoveStream = (stream) {
        logger.fine(() => 'onRemoveStream stream: $stream');

        add(CallRemoteStreamRemoved(stream: stream));
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
    if (state is! CallActive) return;

    Direction direction;
    if (state is CallIncoming) {
      direction = Direction.incoming;
    } else if (state is CallOutgoing) {
      direction = Direction.outgoing;
    } else {
      throw StateError('Incorrect state class');
    }

    recentsRepository.add(Recent(
      direction: direction,
      number: state.number,
      video: state.video,
      createdTime: state.createdTime,
      acceptedTime: state.acceptedTime,
      hungUpTime: state.hungUpTime,
    ));
  }
}
