import 'call_event.dart';

class HoldingEvent extends CallEvent {
  const HoldingEvent({
    required String transaction,
    required int line,
    required String callId,
  }) : super(transaction: transaction, line: line, callId: callId);

  static const event = 'holding';

  factory HoldingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return HoldingEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
