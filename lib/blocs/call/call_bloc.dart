import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/blocs/app/app_bloc.dart';
import 'package:webtrit_phone/models/recent.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

part 'call_event.dart';

part 'call_state.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository callRepository;
  final RecentsRepository recentsRepository;
  final AppBloc appBloc;

  StreamSubscription? _onIncomingCallSubscription;
  StreamSubscription? _onAcceptedSubscription;
  StreamSubscription? _onHangUpSubscription;

  MediaStream? _localStream;

  RTCPeerConnection? _peerConnection;

  CallBloc({
    required this.callRepository,
    required this.recentsRepository,
    required this.appBloc,
  }) : super(const CallInitial());

  @override
  Future<void> close() async {
    await _onIncomingCallSubscription?.cancel();
    await _onAcceptedSubscription?.cancel();
    await _onHangUpSubscription?.cancel();
    await super.close();
  }

  @override
  Stream<CallState> mapEventToState(CallEvent event) async* {
    if (event is CallAttached) {
      yield* _mapCallAttachedToState(event);
    } else if (event is CallDetached) {
      yield* _mapCallDetachedToState(event);
    } else if (event is CallIncomingReceived) {
      yield* _mapCallIncomingReceivedToState(event);
    } else if (event is CallIncomingAccepted) {
      yield* _mapCallIncomingAcceptedToState(event);
    } else if (event is CallOutgoingStarted) {
      yield* _mapCallOutgoingStartedToState(event);
    } else if (event is CallOutgoingAccepted) {
      yield* _mapCallOutgoingAcceptedToState(event);
    } else if (event is CallRemoteStreamAdded) {
      yield* _mapCallRemoteStreamAddedToState(event);
    } else if (event is CallRemoteStreamRemoved) {
      yield* _mapCallRemoteStreamRemovedToState(event);
    } else if (event is CallRemoteHungUp) {
      yield* _mapCallHungUpRemoteToState(event);
    } else if (event is CallLocalHungUp) {
      yield* _mapCallHungUpLocalToState(event);
    } else if (event is CallCameraSwitched) {
      yield* _mapCallCameraSwitchedToState(event);
    } else if (event is CallCameraEnabled) {
      yield* _mapCallCameraEnabledToState(event);
    } else if (event is CallMicrophoneEnabled) {
      yield* _mapCallMicrophoneEnabledToState(event);
    } else if (event is CallSpeakerphoneEnabled) {
      yield* _mapCallSpeakerphoneEnabledToState(event);
    } else if (event is CallFailureApproved) {
      yield* _mapCallFailureApprovedToState(event);
    }
  }

  Stream<CallState> _mapCallAttachedToState(CallAttached event) async* {
    yield const CallAttachInProgress();
    try {
      await callRepository.attach();
      await callRepository.register();

      _onIncomingCallSubscription = callRepository.onIncomingCall.listen((event) {
        add(CallIncomingReceived(username: event.caller, jsepData: event.jsep));
      });
      _onAcceptedSubscription = callRepository.onAccepted.listen((event) {
        add(CallOutgoingAccepted(username: event.callee, jsepData: event.jsep));
      });
      _onHangUpSubscription = callRepository.onHangup.listen((event) {
        add(CallRemoteHungUp(reason: event.reason));
      });

      yield const CallIdle();

      appBloc.add(const AppRegistered());
    } catch (e) {
      yield CallAttachFailure(
        reason: e.toString(),
      );
    }
  }

  Stream<CallState> _mapCallDetachedToState(CallDetached event) async* {
    yield const CallInitial();

    if (callRepository.isAttached) {
      await callRepository.detach();
    }
  }

  Stream<CallState> _mapCallIncomingReceivedToState(CallIncomingReceived event) async* {
    yield CallIncoming(number: event.username, video: true, createdTime: DateTime.now());

    _localStream = await _getUserMedia(video: true);

    yield (state as CallActive).copyWith(localStream: _localStream);

    _peerConnection = await _createPeerConnection();
    await _peerConnection!.addStream(_localStream!);

    final remoteDescription = RTCSessionDescription(event.jsepData!['sdp'], event.jsepData!['type']);
    await _peerConnection!.setRemoteDescription(remoteDescription);
  }

  Stream<CallState> _mapCallIncomingAcceptedToState(CallIncomingAccepted event) async* {
    yield (state as CallActive).copyWith(acceptedTime: DateTime.now());

    final localDescription = await _peerConnection!.createAnswer({});
    _peerConnection!.setLocalDescription(localDescription);

    await callRepository.accept(localDescription.toMap());
  }

  Stream<CallState> _mapCallOutgoingStartedToState(CallOutgoingStarted event) async* {
    yield CallOutgoing(number: event.number, video: event.video, createdTime: DateTime.now());

    _localStream = await _getUserMedia(video: event.video);

    yield (state as CallActive).copyWith(localStream: _localStream);

    _peerConnection = await _createPeerConnection();
    await _peerConnection!.addStream(_localStream!);

    final localDescription = await _peerConnection!.createOffer({});
    _peerConnection!.setLocalDescription(localDescription);

    try {
      await callRepository.call(event.number, localDescription.toMap());
    } catch (e) {
      await _peerConnection!.close();
      _peerConnection = null;

      await _localStream!.dispose();
      _localStream = null;

      _addToRecents(state);

      yield CallFailure(reason: e.toString());
    }
  }

  Stream<CallState> _mapCallOutgoingAcceptedToState(CallOutgoingAccepted event) async* {
    yield (state as CallActive).copyWith(acceptedTime: DateTime.now());

    final remoteDescription = RTCSessionDescription(event.jsepData!['sdp'], event.jsepData!['type']);
    await _peerConnection!.setRemoteDescription(remoteDescription);
  }

  Stream<CallState> _mapCallRemoteStreamAddedToState(CallRemoteStreamAdded event) async* {
    yield (state as CallActive).copyWith(remoteStream: event.stream);
  }

  Stream<CallState> _mapCallRemoteStreamRemovedToState(CallRemoteStreamRemoved event) async* {
    yield (state as CallActive).copyWith(remoteStream: null);
  }

  Stream<CallState> _mapCallHungUpRemoteToState(CallRemoteHungUp event) async* {
    if (state is! CallActive) return; // TODO: get rid of double hangup event

    yield (state as CallActive).copyWith(hungUpTime: DateTime.now());

    await _peerConnection?.close();
    _peerConnection = null;

    await _localStream?.dispose();
    _localStream = null;

    _addToRecents(state);

    yield const CallIdle();
  }

  Stream<CallState> _mapCallHungUpLocalToState(CallLocalHungUp event) async* {
    if (state is! CallActive) return; // TODO: get rid of double hangup event

    yield (state as CallActive).copyWith(hungUpTime: DateTime.now());

    await callRepository.hangup();

    await _peerConnection?.close();
    _peerConnection = null;

    await _localStream?.dispose();
    _localStream = null;

    _addToRecents(state);

    yield const CallIdle();
  }

  Stream<CallState> _mapCallCameraSwitchedToState(CallCameraSwitched event) async* {
    final videoTrack = _localStream?.getVideoTracks()[0];
    if (videoTrack != null) {
      await Helper.switchCamera(videoTrack);
    }
  }

  Stream<CallState> _mapCallCameraEnabledToState(CallCameraEnabled event) async* {
    _localStream?.getVideoTracks()[0].enabled = event.mode;
  }

  Stream<CallState> _mapCallMicrophoneEnabledToState(CallMicrophoneEnabled event) async* {
    final audioTrack = _localStream?.getAudioTracks()[0];
    if (audioTrack != null) {
      Helper.setMicrophoneMute(!event.mode, audioTrack);
    }
  }

  Stream<CallState> _mapCallSpeakerphoneEnabledToState(CallSpeakerphoneEnabled event) async* {
    _localStream?.getAudioTracks()[0].enableSpeakerphone(event.mode);
  }

  Stream<CallState> _mapCallFailureApprovedToState(CallFailureApproved event) async* {
    yield const CallIdle();
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
