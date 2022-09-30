import 'call_event.dart';
import 'event.dart';

class CallingEvent extends CallEvent {
  const CallingEvent({
    String? transaction,
    required int line,
    required String callId,
  }) : super(transaction: transaction, line: line, callId: callId);

  static const typeValue = 'calling';

  factory CallingEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return CallingEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
