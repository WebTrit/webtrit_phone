import 'package:flutter_webrtc/flutter_webrtc.dart';

/// Extension on [RTCPeerConnection] to safely add a track.
/// This extension checks the signaling and connection state before adding a track.
/// If the connection is closed, it returns null instead of throwing an error,
/// otherwise, it returns the added [RTCRtpSender].
extension RTCPeerConnectionSafeAddTrack on RTCPeerConnection {
  Future<RTCRtpSender?> safeAddTrack(MediaStreamTrack track, MediaStream stream) async {
    if (signalingState != RTCSignalingState.RTCSignalingStateClosed &&
        connectionState != RTCPeerConnectionState.RTCPeerConnectionStateClosed) {
      return addTrack(track, stream);
    }
    return null;
  }
}
