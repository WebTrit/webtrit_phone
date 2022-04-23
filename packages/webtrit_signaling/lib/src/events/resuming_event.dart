import 'call_event.dart';

class ResumingEvent extends CallEvent {
  const ResumingEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'resuming';

  factory ResumingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return ResumingEvent(
      callId: json['call_id'],
    );
  }
}
