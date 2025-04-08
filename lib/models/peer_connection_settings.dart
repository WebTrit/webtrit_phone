import 'package:equatable/equatable.dart';

import 'negotiation_settings.dart';

/// Defines a collection of settings that control the behavior of the WebRTC [RTCPeerConnection].
///
/// These settings influence how the local application handles session negotiation,
/// including how media tracks are added or responded to during SDP offer/answer exchange.
///
/// This configuration layer operates above the media encoding level and is focused
/// on the interaction between signaling and peer connection state, rather than codec parameters.
///
/// Example use cases:
/// - Automatically include an inactive video track in the SDP answer when callee receives an offer with video.
/// - Define policies for how renegotiation is triggered or responded to.
/// - Customize behavior for dynamic media upgrades.
///
/// [PeerConnectionSettings] is intended to group together all session-level behaviors
/// that affect the WebRTC connection beyond media encoding (e.g., logic, policies, directionality).
class PeerConnectionSettings extends Equatable {
  const PeerConnectionSettings({
    required this.negotiationSettings,
  });

  factory PeerConnectionSettings.blank() => const PeerConnectionSettings(
        negotiationSettings: NegotiationSettings(),
      );

  /// Defines how the callee responds to an incoming SDP offer with video media.
  final NegotiationSettings negotiationSettings;

  @override
  List<Object?> get props => [
        negotiationSettings,
      ];
}
