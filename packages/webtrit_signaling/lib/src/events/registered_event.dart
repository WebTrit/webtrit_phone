import 'session_event.dart';

class RegisteredEvent extends SessionEvent {
  RegisteredEvent({
    required String transaction,
  }) : super(transaction: transaction);

  static const event = 'registered';

  factory RegisteredEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return RegisteredEvent(
      transaction: json['transaction'],
    );
  }
}
