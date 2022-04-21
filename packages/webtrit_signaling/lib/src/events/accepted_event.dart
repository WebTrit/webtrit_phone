import 'call_event.dart';

class AcceptedEvent extends CallEvent {
  const AcceptedEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );

  static const event = 'accepted';

  factory AcceptedEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return AcceptedEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
