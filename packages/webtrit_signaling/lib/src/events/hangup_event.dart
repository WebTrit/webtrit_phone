import 'call_event.dart';

class HangupEvent extends CallEvent {
  const HangupEvent({
    required String transaction,
    required int line,
    required String callId,
    required this.code,
    required this.reason,
  }) : super(transaction: transaction, line: line, callId: callId);

  final int code;
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        reason,
      ];

  static const event = 'hangup';

  factory HangupEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return HangupEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
      reason: json['reason'],
    );
  }
}
