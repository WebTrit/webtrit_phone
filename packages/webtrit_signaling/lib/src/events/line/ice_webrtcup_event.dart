import '../abstract_events.dart';

class IceWebrtcUpEvent extends LineEvent {
  const IceWebrtcUpEvent({
    super.transaction,
    required super.line,
  });

  static const typeValue = 'ice_webrtcup';

  factory IceWebrtcUpEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return IceWebrtcUpEvent(
      transaction: json['transaction'],
      line: json['line'],
    );
  }
}
