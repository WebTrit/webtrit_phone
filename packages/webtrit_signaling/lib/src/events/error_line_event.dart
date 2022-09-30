import 'event.dart';
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
        ...super.props,
        code,
        description,
        callId,
      ];

  static const typeValue = 'error';

  factory ErrorLineEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
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
