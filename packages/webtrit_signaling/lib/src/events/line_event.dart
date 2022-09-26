import 'session_event.dart';

abstract class LineEvent extends SessionEvent {
  const LineEvent({
    required this.line,
  }) : super();

  final int line;

  @override
  List<Object?> get props => [
        line,
      ];
}
