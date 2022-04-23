import 'call_event.dart';

class HoldingEvent extends CallEvent {
  const HoldingEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'holding';

  factory HoldingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return HoldingEvent(
      callId: json['call_id'],
    );
  }
}
