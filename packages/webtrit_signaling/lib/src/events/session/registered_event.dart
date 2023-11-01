import '../abstract_events.dart';

class RegisteredEvent extends SessionEvent {
  RegisteredEvent({
    super.transaction,
  });

  static const typeValue = 'registered';

  factory RegisteredEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return RegisteredEvent(
      transaction: json['transaction'],
    );
  }
}
