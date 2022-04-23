import 'call_event.dart';

class MissedCallEvent extends CallEvent {
  const MissedCallEvent({
    required String callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
  }) : super(callId: callId);

  final String callee;
  final String caller;
  final String? callerDisplayName;

  @override
  List<Object?> get props => [
        ...super.props,
        callee,
        caller,
        callerDisplayName,
      ];

  static const event = 'missed_call';

  factory MissedCallEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return MissedCallEvent(
      callId: json['call_id'],
      callee: json['callee'],
      caller: json['caller'],
      callerDisplayName: json['caller_display_name'],
    );
  }
}
