import '../abstract_events.dart';

class TransferAcceptedEvent extends CallEvent {
  const TransferAcceptedEvent({super.transaction, required super.line, required super.callId});

  static const typeValue = 'transfer_accepted';

  @override
  Map<String, dynamic> toJson() => callBaseJson(typeValue);

  factory TransferAcceptedEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return TransferAcceptedEvent(transaction: json['transaction'], line: json['line'], callId: json['call_id']);
  }
}
