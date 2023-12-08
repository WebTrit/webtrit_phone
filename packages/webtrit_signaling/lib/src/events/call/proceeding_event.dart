import '../abstract_events.dart';

class ProceedingEvent extends CallEvent {
  const ProceedingEvent({
    super.transaction,
    required super.line,
    required super.callId,
    required this.code,
  });

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
