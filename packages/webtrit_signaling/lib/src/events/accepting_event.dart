import 'call_event.dart';

class AcceptingEvent extends CallEvent {
  const AcceptingEvent({
    required int line,
    required String callId,
  }) : super(line: line, callId: callId);

  static const event = 'accepting';

  factory AcceptingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return AcceptingEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
