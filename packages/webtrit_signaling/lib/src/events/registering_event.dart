import 'event.dart';
import 'session_event.dart';

class RegisteringEvent extends SessionEvent {
  RegisteringEvent({
    required String transaction,
  }) : super(transaction: transaction);

  static const typeValue = 'registering';

  factory RegisteringEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return RegisteringEvent(
      transaction: json['transaction'],
    );
  }
}
