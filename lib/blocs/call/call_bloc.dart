import 'dart:async';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:janus_client/janus_client.dart';

import 'package:webtrit_phone/repositories/call_repository.dart';
import 'package:webtrit_phone/blocs/recents/recents.dart';
import 'package:webtrit_phone/models/recent.dart';

import './call.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository callRepository;
  final RecentsBloc recentsBloc;

  StreamSubscription _onIncomingCallSubscription;
  StreamSubscription _onAcceptedSubscription;
  StreamSubscription _onHangUpSubscription;

  MediaStream _localStream;

  RTCPeerConnection _peerConnection;

  CallBloc({
    @required this.callRepository,
    @required this.recentsBloc,
  })  : assert(callRepository != null),
        assert(recentsBloc != null),
        super(CallIdle()) {
    _onIncomingCallSubscription = callRepository.onIncomingCall.listen((event) {
      add(CallIncomingReceived(username: event.username, jsepData: event.jsepData));
    });
    _onAcceptedSubscription = callRepository.onAccepted.listen((event) {
      add(CallOutgoingAccepted(username: event.username, jsepData: event.jsepData));
    });
    _onHangUpSubscription = callRepository.onHangup.listen((event) {
      add(CallRemoteHungUp(reason: event.reason));
    });
  }

  @override
  Future<void> close() async {
    await _onIncomingCallSubscription.cancel();
    await _onAcceptedSubscription.cancel();
    await _onHangUpSubscription.cancel();
    await super.close();
  }

  @override
  Stream<CallState> mapEventToState(CallEvent event) async* {
    if (event is CallIncomingReceived) {
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

  Stream<CallState> _mapCallIncomingReceivedToState(CallIncomingReceived event) async* {
    yield CallIncoming(username: event.username, accepted: false);

    _localStream = await _getUserMedia();

    yield (state as CallActive).copyWith(localStream: _localStream);

    _peerConnection = await _createPeerConnection();
    await _peerConnection.addStream(_localStream);

    final remoteDescription = RTCSessionDescription(event.jsepData['sdp'], event.jsepData['type']);
    await _peerConnection.setRemoteDescription(remoteDescription);
  }

  Stream<CallState> _mapCallIncomingAcceptedToState(CallIncomingAccepted event) async* {
    yield (state as CallActive).copyWith(accepted: true);

    final localDescription = await _peerConnection.createAnswer({});
    _peerConnection.setLocalDescription(localDescription);

    await callRepository.accept(localDescription.toMap());
  }

  Stream<CallState> _mapCallOutgoingStartedToState(CallOutgoingStarted event) async* {
    yield CallOutgoing(username: event.username);

    _localStream = await _getUserMedia();

    yield (state as CallActive).copyWith(localStream: _localStream);

    _peerConnection = await _createPeerConnection();
    await _peerConnection.addStream(_localStream);

    final localDescription = await _peerConnection.createOffer({});
    _peerConnection.setLocalDescription(localDescription);

    try {
      await callRepository.call(event.username, localDescription.toMap());
    } on JanusPluginHandleErrorException catch (e) {
      await _peerConnection.close();
      _peerConnection = null;

      await _localStream.dispose();
      _localStream = null;

      _addToRecents(state);

      yield CallFailure(reason: e.error);
    }
  }

  Stream<CallState> _mapCallOutgoingAcceptedToState(CallOutgoingAccepted event) async* {
    yield (state as CallActive).copyWith(accepted: true);

    final remoteDescription = RTCSessionDescription(event.jsepData['sdp'], event.jsepData['type']);
    await _peerConnection.setRemoteDescription(remoteDescription);
  }

  Stream<CallState> _mapCallRemoteStreamAddedToState(CallRemoteStreamAdded event) async* {
    yield (state as CallActive).copyWith(remoteStream: event.stream);
  }

  Stream<CallState> _mapCallRemoteStreamRemovedToState(CallRemoteStreamRemoved event) async* {
    yield (state as CallActive).copyWith(remoteStream: null);
  }

  Stream<CallState> _mapCallHungUpRemoteToState(CallRemoteHungUp event) async* {
    if (state is! CallActive) return; // TODO: get rid of double hangup event

    yield (state as CallActive).copyWith(hungUp: true);

    await _peerConnection?.close();
    _peerConnection = null;

    await _localStream?.dispose();
    _localStream = null;

    _addToRecents(state);

    yield CallIdle();
  }

  Stream<CallState> _mapCallHungUpLocalToState(CallLocalHungUp event) async* {
    if (state is! CallActive) return; // TODO: get rid of double hangup event

    yield (state as CallActive).copyWith(hungUp: true);

    await callRepository.hangup();

    await _peerConnection?.close();
    _peerConnection = null;

    await _localStream?.dispose();
    _localStream = null;

    _addToRecents(state);

    yield CallIdle();
  }

  Stream<CallState> _mapCallCameraSwitchedToState(CallCameraSwitched event) async* {
    await _localStream?.getVideoTracks()[0].switchCamera();
  }

  Stream<CallState> _mapCallCameraEnabledToState(CallCameraEnabled event) async* {
    _localStream?.getVideoTracks()[0].enabled = event.mode;
  }

  Stream<CallState> _mapCallMicrophoneEnabledToState(CallMicrophoneEnabled event) async* {
    await _localStream?.getAudioTracks()[0].setMicrophoneMute(!event.mode);
  }

  Stream<CallState> _mapCallSpeakerphoneEnabledToState(CallSpeakerphoneEnabled event) async* {
    await _localStream?.getAudioTracks()[0].enableSpeakerphone(event.mode);
  }

  Stream<CallState> _mapCallFailureApprovedToState(CallFailureApproved event) async* {
    yield CallIdle();
  }

  Future<MediaStream> _getUserMedia() async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': true,
      'video': {
        'mandatory': {
          'minWidth': '640',
          'minHeight': '480',
          'minFrameRate': '30',
        },
        'facingMode': 'user',
        'optional': [],
      }
    };
    final localStream = await navigator.getUserMedia(mediaConstraints);
    localStream.getAudioTracks()[0].enableSpeakerphone(true);
    return localStream;
  }

  Future<RTCPeerConnection> _createPeerConnection() async {
    final peerConnection = await createPeerConnection({}, {});
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

  void _addToRecents(CallActive state) {
    Direction direction;
    if (state is CallIncoming) {
      direction = Direction.incoming;
    } else if (state is CallOutgoing) {
      direction = Direction.outgoing;
    }

    recentsBloc.add(RecentsAdd(
      recent: Recent(
        direction,
        state.accepted,
        state.username,
        DateTime.now(),
      ),
    ));
  }
}
