import 'call_event.dart';

class DecliningEvent extends CallEvent {
  const DecliningEvent({
    required int line,
    required String callId,
    required this.code,
    this.referId,
  }) : super(
          line: line,
          callId: callId,
        );

  final int code;
  final int? referId;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        referId,
      ];
}
