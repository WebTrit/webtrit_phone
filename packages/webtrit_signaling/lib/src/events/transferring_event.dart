import 'call_event.dart';

class TransferringEvent extends CallEvent {
  const TransferringEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'transferring';

  factory TransferringEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return TransferringEvent(
      callId: json['call_id'],
    );
  }
}
