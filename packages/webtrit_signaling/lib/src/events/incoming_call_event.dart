import 'call_event.dart';

class IncomingCallEvent extends CallEvent {
  const IncomingCallEvent({
    required String transaction,
    required int line,
    required String callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
    this.replaceCallId,
    this.isFocus,
    this.jsep,
  }) : super(transaction: transaction, line: line, callId: callId);

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

  static const event = 'incoming_call';

  factory IncomingCallEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return IncomingCallEvent(
      transaction: json['transaction'],
      line: json['line'],
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
