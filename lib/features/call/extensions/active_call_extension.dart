import '../bloc/call_bloc.dart';
import '../models/models.dart';

extension ActiveCallRingback on ActiveCall {
  /// Whether this call still wants the app's own ringback tone.
  ///
  /// The tone belongs to the outgoing ringing phase only: once the remote side
  /// streams audio of its own the bundled tone would play on top of it, and a
  /// call that was answered or ended does not want it either. Incoming calls
  /// never want it - they have their own ringtone.
  bool get shouldPlayLocalRingback => isOutgoing && !earlyMedia && !wasAccepted && !wasHungUp;
}

extension ActiveCallListAutoCompact on List<ActiveCall> {
  /// Determines whether UI controls should auto-compact (auto-hide / Compact Mode)
  /// based on the current call state.
  bool get shouldAutoCompact {
    if (isEmpty) return false;

    // Consider only the foreground active call (the call currently shown to the user).
    // Keep auto-compact disabled for audio-only foreground calls, even if a call on another line has video.
    final activeCall = current;

    if (activeCall.wasHungUp) return false;
    if (activeCall.processingStatus != CallProcessingStatus.connected) return false;

    return activeCall.isCameraActive && activeCall.remoteVideo;
  }

  /// Whether the call controls may hide themselves after a few idle seconds.
  ///
  /// Never when something demands they stay visible - hidden controls leave the
  /// accessibility tree, so hanging up, muting and going back stop existing,
  /// and what remains is a tap area over the whole screen that announces
  /// nothing. What counts as such a demand is up to the caller.
  bool shouldAutoHideControls({required bool keepControlsVisible}) => !keepControlsVisible && shouldAutoCompact;
}
