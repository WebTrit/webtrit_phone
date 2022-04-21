import 'event.dart';

class UnregisteringEvent extends Event {
  UnregisteringEvent() : super();

  @override
  List<Object?> get props => [];

  static const event = 'unregistering';

  factory UnregisteringEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return UnregisteringEvent();
  }
}
