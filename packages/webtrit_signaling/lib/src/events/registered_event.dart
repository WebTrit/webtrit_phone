import 'event.dart';
import 'session_event.dart';

class RegisteredEvent extends SessionEvent {
  RegisteredEvent({
    required String transaction,
  }) : super(transaction: transaction);

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
