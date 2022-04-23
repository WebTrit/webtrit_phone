import 'call_event.dart';

class ProceedingEvent extends CallEvent {
  const ProceedingEvent({
    required String callId,
    required this.code,
  }) : super(callId: callId);

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
      callId: json['call_id'],
      code: json['code'],
    );
  }
}
