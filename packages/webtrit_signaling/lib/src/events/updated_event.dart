import 'call_event.dart';

class UpdatedEvent extends CallEvent {
  const UpdatedEvent({
    required int line,
    required String callId,
  }) : super(line: line, callId: callId);

  static const event = 'updated';

  factory UpdatedEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return UpdatedEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
