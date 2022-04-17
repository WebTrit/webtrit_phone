import 'call_event.dart';

class HoldingEvent extends CallEvent {
  const HoldingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
