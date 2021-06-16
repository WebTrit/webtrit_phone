import 'call_event.dart';

class HoldingEvent extends CallEvent {
  HoldingEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
