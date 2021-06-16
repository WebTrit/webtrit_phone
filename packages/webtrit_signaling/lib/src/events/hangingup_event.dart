import 'call_event.dart';

class HangingupEvent extends CallEvent {
  HangingupEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
