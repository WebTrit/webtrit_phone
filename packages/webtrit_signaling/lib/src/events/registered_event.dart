import 'event.dart';

class RegisteredEvent extends Event {
  RegisteredEvent() : super();

  @override
  List<Object?> get props => [];

  static const event = 'registered';

  factory RegisteredEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return RegisteredEvent();
  }
}
