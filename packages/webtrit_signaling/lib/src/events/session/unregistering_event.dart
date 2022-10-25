import '../abstract_events.dart';

class UnregisteringEvent extends SessionEvent {
  UnregisteringEvent({
    String? transaction,
  }) : super(transaction: transaction);

  static const typeValue = 'unregistering';

  factory UnregisteringEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return UnregisteringEvent(
      transaction: json['transaction'],
    );
  }
}
