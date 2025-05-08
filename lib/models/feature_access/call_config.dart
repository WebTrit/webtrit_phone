/// UI-level configuration for call features.
///
/// Controls visibility of call-related UI elements (e.g., video toggle, transfer buttons).
/// Does **not** enforce restrictions at signaling or SDP level.
///
/// Note: Incoming video calls or feature negotiation (e.g., via SDP) are not affected.
/// To apply restrictions on protocol level, integrate with `SDPMunger` or similar logic.
class CallConfig {
  const CallConfig({
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
