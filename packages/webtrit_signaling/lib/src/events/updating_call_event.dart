import 'call_event.dart';

class UpdatingCallEvent extends CallEvent {
  const UpdatingCallEvent({
    required String callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
    this.replaceCallId,
    this.isFocus,
    this.jsep,
  }) : super(callId: callId);

  final String callee;
  final String caller;
  final String? callerDisplayName;
  final String? replaceCallId;
  final bool? isFocus;
  final Map<String, dynamic>? jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        callee,
        caller,
        callerDisplayName,
        replaceCallId,
        isFocus,
        jsep,
      ];

  static const event = 'updating_call';

  factory UpdatingCallEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return UpdatingCallEvent(
      callId: json['call_id'],
      callee: json['callee'],
      caller: json['caller'],
      callerDisplayName: json['caller_display_name'],
      replaceCallId: json['replace_call_id'],
      isFocus: json['is_focus'],
      jsep: json['jsep'],
    );
  }
}
