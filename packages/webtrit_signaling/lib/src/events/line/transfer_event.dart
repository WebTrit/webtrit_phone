import '../abstract_events.dart';

class TransferEvent extends LineEvent {
  const TransferEvent({
    super.transaction,
    required super.line,
    required this.referId,
    required this.referTo,
    required this.referredBy,
    required this.replaceCallId,
  });

  final String referId;
  final String referTo;
  final String? referredBy;
  final String? replaceCallId;

  @override
  List<Object?> get props => [...super.props, referId, referTo, referredBy, replaceCallId];

  static const typeValue = 'transfer';

  factory TransferEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return TransferEvent(
      transaction: json['transaction'],
      line: json['line'],
      referId: json['refer_id'],
      referTo: json['refer_to'],
      referredBy: json['referred_by'],
      replaceCallId: json['replace_call_id'],
    );
  }
}
