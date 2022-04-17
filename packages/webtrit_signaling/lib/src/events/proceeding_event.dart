import 'call_event.dart';

class ProceedingEvent extends CallEvent {
  const ProceedingEvent({
    required int line,
    required String callId,
    required this.code,
  }) : super(
          line: line,
          callId: callId,
        );

  final int code;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
      ];
}
