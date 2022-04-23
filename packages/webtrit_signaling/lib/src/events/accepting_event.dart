import 'call_event.dart';

class AcceptingEvent extends CallEvent {
  const AcceptingEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'accepting';

  factory AcceptingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return AcceptingEvent(
      callId: json['call_id'],
    );
  }
}
