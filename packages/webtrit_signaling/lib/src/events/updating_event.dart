import 'call_event.dart';

class UpdatingEvent extends CallEvent {
  UpdatingEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
