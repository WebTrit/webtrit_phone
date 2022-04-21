import 'call_event.dart';

class RingingEvent extends CallEvent {
  const RingingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );

  static const event = 'ringing';

  factory RingingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return RingingEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
