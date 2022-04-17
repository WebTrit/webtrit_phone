import 'call_event.dart';

class HangupEvent extends CallEvent {
  const HangupEvent({
    required int line,
    required String callId,
    required this.code,
    required this.reason,
  }) : super(
          line: line,
          callId: callId,
        );

  final int code;
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        reason,
      ];
}
