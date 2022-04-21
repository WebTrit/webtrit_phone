import 'event.dart';

class RegistrationFailedEvent extends Event {
  const RegistrationFailedEvent({
    required this.code,
    required this.reason,
  }) : super();

  final int code;
  final String reason;

  @override
  List<Object?> get props => [
        code,
        reason,
      ];

  static const event = 'registration_failed';

  factory RegistrationFailedEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return RegistrationFailedEvent(
      code: json['code'],
      reason: json['reason'],
    );
  }
}
