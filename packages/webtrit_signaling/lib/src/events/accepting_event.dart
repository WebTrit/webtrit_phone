import 'call_event.dart';

class AcceptingEvent extends CallEvent {
  AcceptingEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
