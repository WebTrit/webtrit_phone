import 'call_event.dart';

class CallingEvent extends CallEvent {
  CallingEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
