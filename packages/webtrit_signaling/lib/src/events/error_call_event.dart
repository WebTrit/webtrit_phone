import 'call_event.dart';
import 'event.dart';

class ErrorCallEvent extends CallEvent {
  const ErrorCallEvent({
    required String transaction,
    required int line,
    required String callId,
    required this.code,
    required this.description,
  }) : super(transaction: transaction, line: line, callId: callId);

  final int code;
  final String description;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        description,
      ];

  static const typeValue = 'call_error';

  factory ErrorCallEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return ErrorCallEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
      description: json['description'],
    );
  }
}
