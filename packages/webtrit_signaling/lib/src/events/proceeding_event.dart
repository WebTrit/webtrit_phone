import 'call_event.dart';
import 'event.dart';

class ProceedingEvent extends CallEvent {
  const ProceedingEvent({
    String? transaction,
    required int line,
    required String callId,
    required this.code,
  }) : super(transaction: transaction, line: line, callId: callId);

  final int code;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
      ];

  static const typeValue = 'proceeding';

  factory ProceedingEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return ProceedingEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
    );
  }
}
