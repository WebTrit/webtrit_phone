import 'event.dart';

class UnregisteredEvent extends Event {
  UnregisteredEvent() : super();

  @override
  List<Object?> get props => [];

  static const event = 'unregistered';

  factory UnregisteredEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return UnregisteredEvent();
  }
}
