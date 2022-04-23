import 'call_event.dart';

class CallErrorEvent extends CallEvent {
  const CallErrorEvent({
    required String callId,
    required this.code,
    required this.description,
  }) : super(callId: callId);

  final int code;
  final String description;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        description,
      ];

  static const event = 'call_error';

  factory CallErrorEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return CallErrorEvent(
      callId: json['call_id'],
      code: json['code'],
      description: json['description'],
    );
  }
}
