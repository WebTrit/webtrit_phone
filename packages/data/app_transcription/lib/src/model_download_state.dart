/// Readiness of the engine assets a transcription source needs before it can
/// transcribe (the local ggml model file today).
///
/// Exposed by [TranscriptionDataSource.downloadState] and mirrored
/// session-wide by the pool so the UI can tell "the model is downloading"
/// apart from "the audio is being transcribed".
sealed class ModelDownloadState {
  const ModelDownloadState();
}

/// Nothing downloaded yet and no download running; the asset is fetched on
/// the first use (or by an explicit prepare call).
class ModelDownloadIdle extends ModelDownloadState {
  const ModelDownloadIdle();
}

/// The asset is downloading; [total] is null when the server did not report
/// a content length.
class ModelDownloading extends ModelDownloadState {
  const ModelDownloading({required this.received, this.total});

  final int received;
  final int? total;

  /// Fraction in 0..1, or null while the total size is unknown.
  double? get progress {
    final total = this.total;
    if (total == null || total <= 0) return null;
    final fraction = received / total;
    return fraction > 1 ? 1 : fraction;
  }
}

/// A usable asset is on disk; transcription can start without a download.
class ModelDownloadReady extends ModelDownloadState {
  const ModelDownloadReady();
}

/// The last download attempt failed; retrying later may succeed.
class ModelDownloadFailed extends ModelDownloadState {
  const ModelDownloadFailed(this.error);

  final Object error;
}
