import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/peer_connection_settings/peer_connection_settings_repository.dart';

import 'user_media_builder.dart';

final _logger = Logger('PeerConnectionPolicyApplier');

/// How to add the `m=video` line to an offer when remote video is expected.
enum VideoOfferStrategy {
  /// Add a disabled local camera track (sendrecv). Needed where `recvonly` does
  /// not trigger video reception (PortaSwitch + Janus callee answering an audio
  /// call that later upgrades to video). Opens the camera, so it requires a
  /// [MediaStream] and camera permission.
  inactiveSendrecv,

  /// Add a `recvonly` video transceiver: declares the `m=video` line WITHOUT
  /// opening the camera. Used for Call Pull (take over a call, receive the remote
  /// video, enable the local camera later). Needs no local stream/permission.
  recvonly,
}

/// An abstract interface that defines how to apply specific policies
/// to an existing [RTCPeerConnection] instance.
abstract class PeerConnectionPolicyApplier {
  /// Ensures the offer carries an `m=video` line when [hasRemoteVideo] is true,
  /// so its media layout matches a remote video answer (otherwise
  /// setRemoteDescription rejects it with an m-line order mismatch).
  ///
  /// [strategy] selects how the line is added (see [VideoOfferStrategy]).
  /// [localStream]/[frontCamera] are only used by [VideoOfferStrategy.inactiveSendrecv].
  Future<void> apply(
    RTCPeerConnection peerConnection, {
    required bool hasRemoteVideo,
    MediaStream? localStream,
    bool? frontCamera,
    VideoOfferStrategy strategy = VideoOfferStrategy.inactiveSendrecv,
  });
}

/// Applies peer connection policies based on the provided [PeerConnectionSettings].
///
/// Handles the case where a call needs an `m=video` line in the offer even though
/// the local camera is not (yet) sending: an audio call upgrading to video on the
/// callee side ([VideoOfferStrategy.inactiveSendrecv]), or a Call Pull taking over
/// an existing video call ([VideoOfferStrategy.recvonly]).
///
/// In certain SIP/WebRTC configurations (e.g. PortaSwitch + Janus) `recvonly` on
/// the callee side does not trigger video reception, so [inactiveSendrecv] backs
/// the `m=video` with an actual (disabled) media track there. A pull does not have
/// that problem and uses [recvonly] to avoid opening the camera.
class ModifyWithSettingsPeerConnectionPolicyApplier implements PeerConnectionPolicyApplier {
  ModifyWithSettingsPeerConnectionPolicyApplier(
    this._peerConnectionSettingsRepository,
    this._defaultPeerConnectionSettings,
    this._userMediaBuilder,
  );

  final PeerConnectionSettingsRepository _peerConnectionSettingsRepository;
  final PeerConnectionSettings _defaultPeerConnectionSettings;
  final UserMediaBuilder _userMediaBuilder;

  NegotiationSettings get _negotiationSettings => _peerConnectionSettingsRepository
      .getPeerConnectionSettings(defaultValue: _defaultPeerConnectionSettings)
      .negotiationSettings;

  @override
  Future<void> apply(
    RTCPeerConnection peerConnection, {
    required bool hasRemoteVideo,
    MediaStream? localStream,
    bool? frontCamera,
    VideoOfferStrategy strategy = VideoOfferStrategy.inactiveSendrecv,
  }) async {
    _logger.fine('Applying peer connection policies (strategy: $strategy, settings: $_negotiationSettings)');

    if (!hasRemoteVideo) return;

    switch (strategy) {
      case VideoOfferStrategy.recvonly:
        await _addRecvonlyVideo(peerConnection);
      case VideoOfferStrategy.inactiveSendrecv:
        await _addInactiveSendrecvVideo(peerConnection, localStream, frontCamera);
    }
  }

  /// Adds a `recvonly` video transceiver: an `m=video` line with no local track,
  /// so the camera is never opened. Safe on camera-denied / camera-less devices.
  Future<void> _addRecvonlyVideo(RTCPeerConnection peerConnection) async {
    await peerConnection.addTransceiver(
      kind: RTCRtpMediaType.RTCRtpMediaTypeVideo,
      init: RTCRtpTransceiverInit(direction: TransceiverDirection.RecvOnly),
    );
    _logger.fine('Added recvonly video transceiver');
  }

  /// Adds a disabled local camera track (sendrecv) so the `m=video` line is backed
  /// by an actual media track. Opens the camera via [UserMediaBuilder].
  ///
  /// **Important:**
  /// - Depends on [UserMediaBuilder] to acquire the local video stream.
  /// - The added video track is explicitly disabled (`enabled = false`) to avoid
  ///   rendering or sending video until explicitly activated by the user.
  Future<void> _addInactiveSendrecvVideo(
    RTCPeerConnection peerConnection,
    MediaStream? localStream,
    bool? frontCamera,
  ) async {
    if (localStream == null) {
      _logger.warning('inactiveSendrecv strategy requires a localStream; skipping');
      return;
    }

    // // Check if the policy requires inserting an inactive video track for negotiation purposes
    // if (_negotiationSettings.includeInactiveVideoInOfferAnswer && hasRemoteVideo) {
    //
    // Enabled by default for test purposes
    // TODO: if everything works well remove all related settings

    // Check if a video track is already added to the peer connection
    final senders = await peerConnection.getSenders();
    final alreadyHasVideo = senders.any((sender) => sender.track != null && sender.track!.kind == 'video');

    if (alreadyHasVideo) {
      _logger.fine('Video track already added to the peer connection, skipping');
      return;
    }

    // The video sender may be absent (e.g. after a glare-rollback or error recovery)
    // while the caller's active camera track is still in localStream. Re-add it as-is
    // to preserve the active video — never disable a track the caller already enabled.
    final activeTrack = localStream.getVideoTracks().where((t) => t.enabled).firstOrNull;
    if (activeTrack != null) {
      _logger.fine('Active local video track found in stream, re-adding to peer connection');
      await peerConnection.addTrack(activeTrack, localStream);
      return;
    }

    final localVideoTrack = await _userMediaBuilder.ensureVideoTrack(localStream, frontCamera: frontCamera);

    // Add the video track to the peer connection, disabled initially
    if (localVideoTrack != null) {
      localVideoTrack.enabled = false;
      await peerConnection.addTrack(localVideoTrack, localStream);
      _logger.fine('Added inactive local video track to peer connection');
    }
  }
}
