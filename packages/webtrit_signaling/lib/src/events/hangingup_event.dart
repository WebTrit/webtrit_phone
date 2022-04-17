import 'call_event.dart';

class HangingupEvent extends CallEvent {
  const HangingupEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
