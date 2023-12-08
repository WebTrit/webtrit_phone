import '../abstract_events.dart';

class ResumingEvent extends CallEvent {
  const ResumingEvent({
    super.transaction,
    required super.line,
    required super.callId,
  });

  static const typeValue = 'resuming';

  factory ResumingEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return ResumingEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
