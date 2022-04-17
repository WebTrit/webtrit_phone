import 'call_event.dart';

class CallErrorEvent extends CallEvent {
  const CallErrorEvent({
    required int line,
    required String callId,
    required this.code,
    required this.description,
  }) : super(
          line: line,
          callId: callId,
        );

  final int code;
  final String description;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        description,
      ];
}
