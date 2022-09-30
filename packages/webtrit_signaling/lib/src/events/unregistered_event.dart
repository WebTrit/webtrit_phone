import 'session_event.dart';

class UnregisteredEvent extends SessionEvent {
  UnregisteredEvent({
    required String transaction,
  }) : super(transaction: transaction);

  static const event = 'unregistered';

  factory UnregisteredEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return UnregisteredEvent(
      transaction: json['transaction'],
    );
  }
}
