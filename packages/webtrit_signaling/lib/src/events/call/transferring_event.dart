import '../abstract_events.dart';

class TransferringEvent extends CallEvent {
  const TransferringEvent({super.transaction, required super.line, required super.callId});

  static const typeValue = 'transferring';

  factory TransferringEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return TransferringEvent(transaction: json['transaction'], line: json['line'], callId: json['call_id']);
  }
}
