import 'call_event.dart';

class UpdatingEvent extends CallEvent {
  const UpdatingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );

  static const event = 'updating';

  factory UpdatingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return UpdatingEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
