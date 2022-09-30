import 'call_event.dart';
import 'event.dart';

class HangingupEvent extends CallEvent {
  const HangingupEvent({
    String? transaction,
    required int line,
    required String callId,
  }) : super(transaction: transaction, line: line, callId: callId);

  static const typeValue = 'hangingup';

  factory HangingupEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return HangingupEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
