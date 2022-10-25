import '../abstract_events.dart';

class UpdatingCallEvent extends CallEvent {
  const UpdatingCallEvent({
    String? transaction,
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

  static const typeValue = 'updating_call';

  factory UpdatingCallEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return UpdatingCallEvent(
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
