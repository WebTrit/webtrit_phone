import '../abstract_events.dart';

class RegisteringEvent extends SessionEvent {
  RegisteringEvent({
    String? transaction,
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
