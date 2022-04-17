import 'event.dart';

abstract class LineEvent extends Event {
  const LineEvent({
    required this.line,
  }) : super();

  final int line;

  @override
  List<Object?> get props => [
        line,
      ];
}
