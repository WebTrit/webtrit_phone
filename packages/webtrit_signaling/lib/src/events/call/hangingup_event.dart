import '../abstract_events.dart';

class HangingupEvent extends CallEvent {
  const HangingupEvent({
    super.transaction,
    required super.line,
    required super.callId,
  });

  static const typeValue = 'hangingup';

  factory HangingupEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return HangingupEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
