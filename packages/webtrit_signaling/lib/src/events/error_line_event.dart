import 'line_event.dart';

class ErrorLineEvent extends LineEvent {
  const ErrorLineEvent({
    required String transaction,
    required int line,
    required this.code,
    required this.description,
    this.callId,
  }) : super(transaction: transaction, line: line);

  final int code;
  final String description;
  final String? callId;

  @override
  List<Object?> get props => [
        code,
        description,
        callId,
      ];

  static const event = 'error';

  factory ErrorLineEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return ErrorLineEvent(
      transaction: json['transaction'],
      line: json['line'],
      code: json['code'],
      description: json['description'],
      callId: json['call_id'],
    );
  }
}
