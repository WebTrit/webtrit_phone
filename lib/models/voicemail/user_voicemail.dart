/// Represents the synchronization or read status of the voicemail.
enum ReadStatus {
  read,
  unread,
  unknown;

  bool get isRead => this == ReadStatus.read;

  bool get isUnread => this == ReadStatus.unread;

  bool get isUnknown => this == ReadStatus.unknown;
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
    this.url,
  );

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
}
