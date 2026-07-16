/// Represents the synchronization or read status of the voicemail.
enum ReadStatus {
  read,
  unread,
  unknown;

  bool get isRead => this == ReadStatus.read;

  bool get isUnread => this == ReadStatus.unread;

  bool get isUnknown => this == ReadStatus.unknown;
}

/// Represents the lifecycle of the transcript produced for the voicemail audio.
enum TranscriptStatus {
  /// No transcription has been attempted (or the feature is disabled).
  none,

  /// The transcript is currently being produced.
  inProgress,

  /// The transcript is ready and stored alongside the voicemail.
  done,

  /// Transcription was attempted and failed; no automatic retry is scheduled.
  unavailable;

  bool get isInProgress => this == TranscriptStatus.inProgress;

  bool get isDone => this == TranscriptStatus.done;

  bool get isUnavailable => this == TranscriptStatus.unavailable;

  static TranscriptStatus fromName(String? name) {
    return TranscriptStatus.values.firstWhere((value) => value.name == name, orElse: () => TranscriptStatus.none);
  }
}

class Voicemail {
  Voicemail(
    this.id,
    this.date,
    this.duration,
    this.sender,
    this.displaySender,
    this.receiver,
    this.status,
    this.size,
    this.type,
    this.url, {
    this.transcript,
    this.transcriptStatus = TranscriptStatus.none,
  });

  final String id;
  final String date;
  final double duration;
  final String sender;
  final String displaySender;
  final String receiver;
  final ReadStatus status;
  final int size;
  final String type;
  final String? url;
  final String? transcript;
  final TranscriptStatus transcriptStatus;
}
