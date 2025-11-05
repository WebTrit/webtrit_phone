import '../abstract_events.dart';

class UpdatingEvent extends CallEvent {
  const UpdatingEvent({
    super.transaction,
    required super.line,
    required super.callId,
  });

  static const typeValue = 'updating';

  factory UpdatingEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(
          eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return UpdatingEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
