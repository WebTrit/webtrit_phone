import '../abstract_events.dart';

class RingingEvent extends CallEvent {
  const RingingEvent({super.transaction, required super.line, required super.callId});

  static const typeValue = 'ringing';

  @override
  Map<String, dynamic> toJson() => callBaseJson(typeValue);

  factory RingingEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return RingingEvent(transaction: json['transaction'], line: json['line'], callId: json['call_id']);
  }
}
