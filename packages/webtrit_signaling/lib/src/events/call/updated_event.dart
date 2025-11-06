import '../abstract_events.dart';

class UpdatedEvent extends CallEvent {
  const UpdatedEvent({super.transaction, required super.line, required super.callId});

  static const typeValue = 'updated';

  factory UpdatedEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return UpdatedEvent(transaction: json['transaction'], line: json['line'], callId: json['call_id']);
  }
}
