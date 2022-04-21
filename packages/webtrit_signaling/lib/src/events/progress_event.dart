import 'call_event.dart';

class ProgressEvent extends CallEvent {
  const ProgressEvent({
    required int line,
    required String callId,
    required this.callee,
    this.isFocus,
    this.jsep,
  }) : super(
          line: line,
          callId: callId,
        );

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

  static const event = 'progress';

  factory ProgressEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return ProgressEvent(
      line: json['line'],
      callId: json['call_id'],
      callee: json['callee'],
      isFocus: json['is_focus'],
      jsep: json['jsep'],
    );
  }
}
