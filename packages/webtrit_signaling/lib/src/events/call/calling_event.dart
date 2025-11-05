import '../abstract_events.dart';

class CallingEvent extends CallEvent {
  const CallingEvent({super.transaction, required super.line, required super.callId});

  static const typeValue = 'calling';

  factory CallingEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return CallingEvent(transaction: json['transaction'], line: json['line'], callId: json['call_id']);
  }
}
