import 'call_event.dart';

class UpdatingEvent extends CallEvent {
  const UpdatingEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
