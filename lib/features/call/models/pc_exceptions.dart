class RtcJsepErrorParser {
  static Object parse(Object error) {
    final errorText = error.toString();

    if (errorText.contains('Failed to set remote offer sdp: Called in wrong state: have-local-offer')) {
      return RtcSetRemoteDescriptionWhileHaveLocalOffer(errorText);
    } else if (errorText.contains(
      'cannot create an answer in a state other than have-remote-offer or have-local-pranswer',
    )) {
      return RtcCreateAnswerWhileWrongState(errorText);
    }

    return SDPConfigurationError(errorText);
  }
}

class SDPConfigurationError implements Exception {
  final String message;

  SDPConfigurationError(this.message);

  @override
  String toString() => 'SDPConfigurationError: $message';
}

class PCWrongSignalingState implements Exception {
  final String message;

  PCWrongSignalingState(this.message);

  @override
  String toString() => 'PCWrongSignalingState: $message';
}

class RtcSetRemoteDescriptionWhileHaveLocalOffer extends PCWrongSignalingState {
  RtcSetRemoteDescriptionWhileHaveLocalOffer(super.message);

  @override
  String toString() => 'RtcSetRemoteDescriptionWhileHaveLocalOffer: $message';
}

class RtcCreateAnswerWhileWrongState extends PCWrongSignalingState {
  RtcCreateAnswerWhileWrongState(super.message);

  @override
  String toString() => 'RtcCreateAnswerWhileWrongState: $message';
}

// Examples:
// Unable to RTCPeerConnection::setRemoteDescription: peerConnectionSetRemoteDescription(): WEBRTC_SET_REMOTE_DESCRIPTION_ERROR: Failed to set remote offer sdp: Called in wrong state: have-local-offer
// Unable to RTCPeerConnection::createAnswer: peerConnectionCreateAnswer(): WEBRTC_CREATE_ANSWER_ERROR: PeerConnection cannot create an answer in a state other than have-remote-offer or have-local-pranswer
