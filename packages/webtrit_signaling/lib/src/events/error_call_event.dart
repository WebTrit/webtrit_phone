import 'call_event.dart';

class ErrorCallEvent extends CallEvent {
  const ErrorCallEvent({
    required int line,
    required String callId,
    required this.code,
    required this.description,
  }) : super(line: line, callId: callId);

  final int code;
  final String description;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        description,
      ];

  static const event = 'call_error';

  factory ErrorCallEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return ErrorCallEvent(
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
      description: json['description'],
    );
  }
}
