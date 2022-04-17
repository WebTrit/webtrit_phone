import 'call_event.dart';

class CallingEvent extends CallEvent {
  const CallingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
