import '../abstract_events.dart';

class RegistrationFailedEvent extends SessionEvent {
  const RegistrationFailedEvent({
    super.transaction,
    required this.code,
    required this.reason,
  });

  final int code;
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        reason,
      ];

  static const typeValue = 'registration_failed';

  factory RegistrationFailedEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return RegistrationFailedEvent(
      transaction: json['transaction'],
      code: json['code'],
      reason: json['reason'],
    );
  }
}
