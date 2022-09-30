import 'session_event.dart';

class UnregisteringEvent extends SessionEvent {
  UnregisteringEvent({
    required String transaction,
  }) : super(transaction: transaction);

  static const event = 'unregistering';

  factory UnregisteringEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return UnregisteringEvent(
      transaction: json['transaction'],
    );
  }
}
