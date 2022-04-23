import 'call_event.dart';

class CallingEvent extends CallEvent {
  const CallingEvent({
    required String callId,
  }) : super(
          callId: callId,
        );

  static const event = 'calling';

  factory CallingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return CallingEvent(
      callId: json['call_id'],
    );
  }
}
