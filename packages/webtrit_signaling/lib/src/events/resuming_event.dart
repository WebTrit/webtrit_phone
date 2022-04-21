import 'call_event.dart';

class ResumingEvent extends CallEvent {
  const ResumingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );

  static const event = 'resuming';

  factory ResumingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return ResumingEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
