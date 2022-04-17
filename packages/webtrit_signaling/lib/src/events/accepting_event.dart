import 'call_event.dart';

class AcceptingEvent extends CallEvent {
  const AcceptingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
