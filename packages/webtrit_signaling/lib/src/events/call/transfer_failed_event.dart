import '../abstract_events.dart';

class TransferFailedEvent extends CallEvent {
  const TransferFailedEvent({super.transaction, required super.line, required super.callId, this.code});

  static const typeValue = 'transfer_failed';

  final int? code;

  @override
  List<Object?> get props => [...super.props, code];

  @override
  Map<String, dynamic> toJson() => {...callBaseJson(typeValue), if (code != null) 'code': code};

  factory TransferFailedEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return TransferFailedEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
    );
  }
}
