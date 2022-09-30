import 'line_event.dart';

abstract class CallEvent extends LineEvent {
  const CallEvent({
    required String transaction,
    required int line,
    required this.callId,
  }) : super(transaction: transaction, line: line);

  final String callId;

  @override
  List<Object?> get props => [
        ...super.props,
        callId,
      ];
}
