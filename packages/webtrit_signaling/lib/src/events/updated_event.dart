import 'call_event.dart';

class UpdatedEvent extends CallEvent {
  const UpdatedEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
