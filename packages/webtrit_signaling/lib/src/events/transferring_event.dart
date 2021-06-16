import 'call_event.dart';

class TransferringEvent extends CallEvent {
  TransferringEvent({
    required String callId,
  }) : super(callId: callId);

  @override
  List<Object?> get props => [
        ...super.props,
      ];
}
