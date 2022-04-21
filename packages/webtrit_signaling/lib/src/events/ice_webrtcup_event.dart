import 'line_event.dart';

class IceWebrtcUpEvent extends LineEvent {
  const IceWebrtcUpEvent({
    required int line,
  }) : super(line: line);

  static const event = 'ice_webrtcup';

  factory IceWebrtcUpEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return IceWebrtcUpEvent(
      line: json['line'],
    );
  }
}
