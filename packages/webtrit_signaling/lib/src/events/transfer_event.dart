import 'event.dart';

class TransferEvent extends Event {
  TransferEvent({
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
}
