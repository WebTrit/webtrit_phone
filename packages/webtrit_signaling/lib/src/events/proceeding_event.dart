import 'call_event.dart';

class ProceedingEvent extends CallEvent {
  const ProceedingEvent({
    required int line,
    required String callId,
    required this.code,
  }) : super(
          line: line,
          callId: callId,
        );

  final int code;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
      ];

  static const event = 'proceeding';

  factory ProceedingEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return ProceedingEvent(
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
    );
  }
}
