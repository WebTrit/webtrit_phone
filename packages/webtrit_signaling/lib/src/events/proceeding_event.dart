import 'call_event.dart';

class ProceedingEvent extends CallEvent {
  ProceedingEvent({
    required String callId,
    required this.code,
  }) : super(callId: callId);

  final int code;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
      ];
}
