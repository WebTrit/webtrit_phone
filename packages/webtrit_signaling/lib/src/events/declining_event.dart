import 'call_event.dart';

class DecliningEvent extends CallEvent {
  DecliningEvent({
    required String callId,
    required this.code,
    this.referId,
  }) : super(callId: callId);

  final int code;
  final int? referId;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        referId,
      ];
}
