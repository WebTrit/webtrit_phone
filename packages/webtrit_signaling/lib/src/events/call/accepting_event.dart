import '../abstract_events.dart';

class AcceptingEvent extends CallEvent {
  const AcceptingEvent({
    super.transaction,
    required super.line,
    required super.callId,
  });

  static const typeValue = 'accepting';

  factory AcceptingEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return AcceptingEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
