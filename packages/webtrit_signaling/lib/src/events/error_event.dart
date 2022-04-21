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

  static const event = 'error';

  factory ErrorEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return ErrorEvent(
      line: json['line'],
      code: json['code'],
      description: json['description'],
    );
  }
}
