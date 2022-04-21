import 'line_event.dart';

class ErrorEvent extends LineEvent {
  const ErrorEvent({
    required int line,
    required this.code,
    required this.description,
  }) : super(line: line);

  final int code;
  final String description;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        description,
      ];
}
