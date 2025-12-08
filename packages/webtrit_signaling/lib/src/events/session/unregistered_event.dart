import '../abstract_events.dart';

class UnregisteredEvent extends SessionEvent {
  UnregisteredEvent({super.transaction});

  static const typeValue = 'unregistered';

  factory UnregisteredEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return UnregisteredEvent(transaction: json['transaction']);
  }
}
