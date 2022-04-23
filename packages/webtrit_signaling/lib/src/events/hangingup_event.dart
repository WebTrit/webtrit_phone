import 'call_event.dart';

class HangingupEvent extends CallEvent {
  const HangingupEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'hangingup';

  factory HangingupEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return HangingupEvent(
      callId: json['call_id'],
    );
  }
}
