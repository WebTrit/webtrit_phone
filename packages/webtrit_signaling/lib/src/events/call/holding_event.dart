import '../abstract_events.dart';

class HoldingEvent extends CallEvent {
  const HoldingEvent({super.transaction, required super.line, required super.callId});

  static const typeValue = 'holding';

  factory HoldingEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return HoldingEvent(transaction: json['transaction'], line: json['line'], callId: json['call_id']);
  }
}
