import 'call_event.dart';

class HangupEvent extends CallEvent {
  HangupEvent({
    required String callId,
    required this.code,
    required this.reason,
  }) : super(callId: callId);

  final int code;
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        reason,
      ];
}
