import 'call_event.dart';

class ResumingEvent extends CallEvent {
  const ResumingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
