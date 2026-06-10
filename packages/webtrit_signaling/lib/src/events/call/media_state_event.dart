import '../abstract_events.dart';

class MediaStateEvent extends CallEvent {
  const MediaStateEvent({
    super.transaction,
    required super.line,
    required super.callId,
    required this.media,
    this.sender,
  });

  final Map<String, dynamic> media;
  final String? sender;

  @override
  List<Object?> get props => [...super.props, media, sender];

  static const typeValue = 'media_state';

  @override
  Map<String, dynamic> toJson() => {...callBaseJson(typeValue), 'media': media, if (sender != null) 'sender': sender};

  factory MediaStateEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return MediaStateEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      media: json['media'],
      sender: json['sender'],
    );
  }
}
