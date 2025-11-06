import '../abstract_events.dart';

class CallErrorEvent extends CallEvent implements ErrorEvent {
  const CallErrorEvent({
    super.transaction,
    required super.line,
    required super.callId,
    required this.code,
    required this.reason,
  });

  @override
  final int code;
  @override
  final String reason;

  @override
  List<Object?> get props => [...super.props, code, reason];

  static CallErrorEvent? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != ErrorEvent.typeValue) {
      return null;
    }

    try {
      return CallErrorEvent(
        transaction: json['transaction'],
        line: json['line'],
        callId: json['call_id'],
        code: json['code'],
        reason: json['reason'],
      );
    } on TypeError {
      return null;
    }
  }
}
