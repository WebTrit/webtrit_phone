import 'call_event.dart';

class RingingEvent extends CallEvent {
  RingingEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
