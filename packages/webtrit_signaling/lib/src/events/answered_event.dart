import 'call_event.dart';

class AnsweredEvent extends CallEvent {
  const AnsweredEvent({
    required String callId,
    required this.callee,
    this.isFocus,
    this.jsep,
  }) : super(callId: callId);

  final String callee;
  final bool? isFocus;
  final Map<String, dynamic>? jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        callee,
        isFocus,
        jsep,
      ];

  static const event = 'answered';

  factory AnsweredEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return AnsweredEvent(
      callId: json['call_id'],
      callee: json['callee'],
      isFocus: json['is_focus'],
      jsep: json['jsep'],
    );
  }
}
