import 'package:flutter_webrtc/flutter_webrtc.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';

import 'user_media_builder.dart';

/// An abstract interface that defines how to apply specific policies
/// to an existing [RTCPeerConnection] instance.
abstract class PeerConnectionPolicyApplier {
  /// Applies policy-driven configuration to the given [peerConnection].
  ///
  /// The [hasRemoteVideo] parameter indicates whether the remote SDP includes a video m-line.
  /// This allows conditional policy application based on call capabilities.
  Future<void> apply(RTCPeerConnection peerConnection, {required bool hasRemoteVideo});
}

/// Applies peer connection policies based on the provided [PeerConnectionSettings].
///
/// Specifically handles a use-case where a call starts as audio-only,
/// and video is added later through renegotiation. In certain SIP/WebRTC configurations
/// (e.g., PortaSwitch + Janus), the `recvonly` direction on the callee side does not trigger
/// video reception even if `m=video` and `a=sendrecv` are present in SDP.
/// To work around this, the caller includes a disabled local video track in the initial offer
/// when remote video is expected (`hasRemoteVideo == true`). This ensures that the `m=video`
/// is backed by an actual media track.
///
/// This behavior is controlled via:
///   `settings.negotiationSettings.calleeVideoOfferPolicy == CalleeVideoOfferPolicy.includeInactiveTrack`
///
/// **Important:**
/// - This class depends on [UserMediaBuilder] to acquire the local video stream.
/// - The added video track is explicitly disabled (`enabled = false`) to avoid rendering
///   or sending video until explicitly activated by the user.
class ModifyWithSettingsPeerConnectionPolicyApplier implements PeerConnectionPolicyApplier {
  ModifyWithSettingsPeerConnectionPolicyApplier(
      this._prefs, this._defaultPeerConnectionSettings, this._userMediaBuilder);

  final AppPreferences _prefs;
  final PeerConnectionSettings _defaultPeerConnectionSettings;
  final UserMediaBuilder _userMediaBuilder;

  NegotiationSettings get _negotiationSettings =>
      _prefs.getPeerConnectionSettings(defaultValue: _defaultPeerConnectionSettings).negotiationSettings;

  @override
  Future<void> apply(RTCPeerConnection peerConnection, {required bool hasRemoteVideo}) async {
    // Check if the policy requires inserting an inactive video track for negotiation purposes
    if (_negotiationSettings.calleeVideoOfferPolicy == CalleeVideoOfferPolicy.includeInactiveTrack) {
      if (hasRemoteVideo) {
        // Acquire a local stream with video
        final localStream = await _userMediaBuilder.build(video: true);
        final localVideoTrack = localStream.getVideoTracks().firstOrNull;

        // Add the video track to the peer connection, disabled initially
        if (localVideoTrack != null) {
          localVideoTrack.enabled = false;
          peerConnection.addTrack(localVideoTrack, localStream);
        }
      }
    }
  }
}
