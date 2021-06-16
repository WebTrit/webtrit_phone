import 'call_event.dart';

class AcceptedEvent extends CallEvent {
  AcceptedEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
