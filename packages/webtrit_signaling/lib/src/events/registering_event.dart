import 'session_event.dart';

class RegisteringEvent extends SessionEvent {
  RegisteringEvent() : super();

  @override
  List<Object?> get props => [];

  static const event = 'registering';

  factory RegisteringEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return RegisteringEvent();
  }
}
