import 'call_event.dart';

class ResumingEvent extends CallEvent {
  ResumingEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
