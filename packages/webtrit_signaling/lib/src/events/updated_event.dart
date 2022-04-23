import 'call_event.dart';

class UpdatedEvent extends CallEvent {
  const UpdatedEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'updated';

  factory UpdatedEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return UpdatedEvent(
      callId: json['call_id'],
    );
  }
}
