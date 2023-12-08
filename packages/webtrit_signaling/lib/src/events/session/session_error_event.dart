import '../abstract_events.dart';

class SessionErrorEvent extends SessionEvent implements ErrorEvent {
  const SessionErrorEvent({
    super.transaction,
    required this.code,
    required this.reason,
  });

  @override
  final int code;
  @override
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        reason,
      ];

  static SessionErrorEvent? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != ErrorEvent.typeValue) {
      return null;
    }

    try {
      return SessionErrorEvent(
        transaction: json['transaction'],
        code: json['code'],
        reason: json['reason'],
      );
    } on TypeError {
      return null;
    }
  }
}
