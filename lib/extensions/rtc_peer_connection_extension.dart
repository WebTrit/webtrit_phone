import 'package:flutter_webrtc/flutter_webrtc.dart';

extension RTCPeerConnectionSafeAddTrack on RTCPeerConnection {
  Future<RTCRtpSender?> safeAddTrack(MediaStreamTrack track, MediaStream stream) async {
    if (signalingState != RTCSignalingState.RTCSignalingStateClosed &&
        connectionState != RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
      return addTrack(track, stream);
    }
    return null;
  }
}
