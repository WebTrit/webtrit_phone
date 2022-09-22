import 'call_event.dart';

class HoldingEvent extends CallEvent {
  const HoldingEvent({
    required int line,
    required String callId,
  }) : super(line: line, callId: callId);

  static const event = 'holding';

  factory HoldingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return HoldingEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
