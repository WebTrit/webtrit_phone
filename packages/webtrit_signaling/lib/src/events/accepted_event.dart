import 'call_event.dart';

class AcceptedEvent extends CallEvent {
  const AcceptedEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'accepted';

  factory AcceptedEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return AcceptedEvent(
      callId: json['call_id'],
    );
  }
}
