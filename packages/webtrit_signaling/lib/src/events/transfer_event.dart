import 'event.dart';

class TransferEvent extends Event {
  const TransferEvent({
    required this.referId,
    required this.referTo,
    required this.referredBy,
    required this.replaceCallId,
  }) : super();

  final String referId;
  final String referTo;
  final String? referredBy;
  final String? replaceCallId;

  @override
  List<Object?> get props => [
        referId,
        referTo,
        referredBy,
        replaceCallId,
      ];

  static const event = 'transfer';

  factory TransferEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return TransferEvent(
      referId: json['refer_id'],
      referTo: json['refer_to'],
      referredBy: json['referred_by'],
      replaceCallId: json['replace_call_id'],
    );
  }
}
