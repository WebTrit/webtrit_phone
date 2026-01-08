import '../bloc/call_bloc.dart';
import '../models/models.dart';

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

    return activeCall.cameraEnabled && activeCall.remoteVideo;
  }
}
