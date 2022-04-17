import 'call_event.dart';

class AcceptedEvent extends CallEvent {
  const AcceptedEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
