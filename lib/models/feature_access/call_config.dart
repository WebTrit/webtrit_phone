import '../call/call_trigger_config.dart';
import '../peer_connection_settings.dart';

import 'encoding_config.dart';

/// Configuration for call-related features, including encoding,
/// transfer capabilities, and PeerConnection settings.
class CallConfig {
  const CallConfig({
    required this.capabilities,
    required this.encoding,
    required this.peerConnection,
    required this.triggerConfig,
  });

  final CallCapabilitiesConfig capabilities;
  final EncodingConfig encoding;
  final PeerConnectionSettings peerConnection;

  /// Configuration for how incoming calls are triggered.
  ///
  /// This controls which triggering mechanisms are available and which one is currently active.
  /// It also defines fallback behavior via SMS if supported.
  ///
  /// Note: This setting affects **UI-level visibility and selection** of triggering methods,
  /// not the underlying signaling implementation.
  final CallTriggerConfig triggerConfig;
}

/// UI-level configuration for call features.
///
/// Controls visibility of call-related UI elements (e.g., video toggle, transfer buttons).
/// Does **not** enforce restrictions at signaling or SDP level.
///
/// Note: Incoming video calls or feature negotiation (e.g., via SDP) are not affected.
/// To apply restrictions on protocol level, integrate with `SDPMunger` or similar logic.
class CallCapabilitiesConfig {
  const CallCapabilitiesConfig({
    this.isVideoCallEnabled = true,
    this.isAudioToVideoSwitchEnabled = true,
    this.isBlindTransferEnabled = true,
    this.isAttendedTransferEnabled = true,
  });

  /// Whether the UI should show video call functionality.
  ///
  /// If `true`, video call features and related UI elements are enabled and visible.
  final bool isVideoCallEnabled;

  /// Whether the user can switch from an audio call to a video call during an active call.
  ///
  /// If `true`, the UI allows transitioning from audio to video.
  final bool isAudioToVideoSwitchEnabled;

  /// Whether blind transfer is available in the UI.
  ///
  /// If `true`, the user can transfer the call to another number without speaking to the recipient beforehand.
  final bool isBlindTransferEnabled;

  /// Whether attended transfer is available in the UI.
  ///
  /// If `true`, the user can talk to the recipient before transferring the call.
  final bool isAttendedTransferEnabled;
}
