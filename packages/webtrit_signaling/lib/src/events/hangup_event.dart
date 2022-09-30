import 'call_event.dart';
import 'event.dart';

class HangupEvent extends CallEvent {
  const HangupEvent({
    String? transaction,
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

  static const typeValue = 'hangup';

  factory HangupEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
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
