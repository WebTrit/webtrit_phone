class Voicemail {
  Voicemail(
    this.id,
    this.date,
    this.duration,
    this.sender,
    this.displaySender,
    this.receiver,
    this.seen,
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
  final bool seen;
  final int size;
  final String type;
  final String? url;
}
