import 'line_event.dart';

abstract class CallEvent extends LineEvent {
  const CallEvent({
    required int line,
    required this.callId,
  }) : super(line: line);

  final String callId;

  @override
  List<Object?> get props => [
        ...super.props,
        callId,
      ];
}
