import 'call_event.dart';

class TransferringEvent extends CallEvent {
  const TransferringEvent({
    required int line,
    required String callId,
  }) : super(line: line, callId: callId);

  static const event = 'transferring';

  factory TransferringEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return TransferringEvent(
      line: json['line'],
      callId: json['call_id'],
    );
  }
}
