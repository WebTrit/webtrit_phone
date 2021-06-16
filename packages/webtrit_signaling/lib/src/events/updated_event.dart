import 'call_event.dart';

class UpdatedEvent extends CallEvent {
  UpdatedEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
