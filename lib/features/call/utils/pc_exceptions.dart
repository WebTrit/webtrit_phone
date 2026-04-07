abstract class PCWrongSignalingState implements Exception {
  final String message;

  const PCWrongSignalingState(this.message);
}

class RtcSetRemoteDescriptionWhileHaveLocalOffer extends PCWrongSignalingState {
  const RtcSetRemoteDescriptionWhileHaveLocalOffer(super.message);
}

class RtcCreateAnswerWhileWrongState extends PCWrongSignalingState {
  const RtcCreateAnswerWhileWrongState(super.message);
}

class SDPConfigurationError implements Exception {
  final String message;

  const SDPConfigurationError(this.message);

  @override
  String toString() => 'SDPConfigurationError: $message';
}

class RtcJsepErrorParser {
  static Exception parse(Object error) {
    final msg = error.toString();
    if (msg.contains('have-local-offer') || msg.contains('setRemoteDescription')) {
      return RtcSetRemoteDescriptionWhileHaveLocalOffer(msg);
    }
    if (msg.contains('createAnswer') || msg.contains('wrong state')) {
      return RtcCreateAnswerWhileWrongState(msg);
    }
    return SDPConfigurationError(msg);
  }
}
