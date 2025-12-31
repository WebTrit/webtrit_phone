import '../bloc/call_bloc.dart';
import '../models/models.dart';

extension ActiveCallListAutoCompact on List<ActiveCall> {
  /// Determines whether UI controls should auto-compact (auto-hide / Compact Mode)
  /// based on the current call state.
  bool get shouldAutoCompact {
    var hasAnyVideo = false;

    for (final c in this) {
      if (c.wasHungUp) return false;
      if (c.processingStatus != CallProcessingStatus.connected) return false;

      hasAnyVideo = hasAnyVideo || (c.cameraEnabled && c.remoteVideo);
    }

    return hasAnyVideo;
  }
}
