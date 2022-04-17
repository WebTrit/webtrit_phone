import 'call_event.dart';

class RingingEvent extends CallEvent {
  const RingingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
