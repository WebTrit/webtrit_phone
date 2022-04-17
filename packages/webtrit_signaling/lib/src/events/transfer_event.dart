import 'line_event.dart';

class TransferEvent extends LineEvent {
  const TransferEvent({
    required int line,
    required this.referId,
    required this.referTo,
    required this.referredBy,
    required this.replaceCallId,
  }) : super(line: line);

  final String referId;
  final String referTo;
  final String? referredBy;
  final String? replaceCallId;

  @override
  List<Object?> get props => [
        ...super.props,
        referId,
        referTo,
        referredBy,
        replaceCallId,
      ];
}
