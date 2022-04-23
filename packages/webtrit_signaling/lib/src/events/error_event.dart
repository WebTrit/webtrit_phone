import 'event.dart';

class ErrorEvent extends Event {
  const ErrorEvent({
    required this.code,
    required this.description,
    this.callId,
  }) : super();

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

  factory ErrorEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return ErrorEvent(
      code: json['code'],
      description: json['description'],
      callId: json['call_id'],
    );
  }
}
