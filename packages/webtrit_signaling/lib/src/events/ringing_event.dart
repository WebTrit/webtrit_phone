import 'call_event.dart';

class RingingEvent extends CallEvent {
  const RingingEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'ringing';

  factory RingingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return RingingEvent(
      callId: json['call_id'],
    );
  }
}
