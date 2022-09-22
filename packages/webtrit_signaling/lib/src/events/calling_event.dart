import 'call_event.dart';

class CallingEvent extends CallEvent {
  const CallingEvent({
    required int line,
    required String callId,
  }) : super(line: line, callId: callId);

  static const event = 'calling';

  factory CallingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return CallingEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
