import 'call_event.dart';

class TransferringEvent extends CallEvent {
  const TransferringEvent({
    required int line,
    required String callId,
  }) : super(
          line: line,
          callId: callId,
        );
}
