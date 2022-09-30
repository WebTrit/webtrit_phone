import 'session_event.dart';

class RegistrationFailedEvent extends SessionEvent {
  const RegistrationFailedEvent({
    required String transaction,
    required this.code,
    required this.reason,
  }) : super(transaction: transaction);

  final int code;
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
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
      transaction: json['transaction'],
      code: json['code'],
      reason: json['reason'],
    );
  }
}
