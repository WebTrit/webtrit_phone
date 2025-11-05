import '../abstract_events.dart';

class MissedCallEvent extends CallEvent {
  const MissedCallEvent({
    super.transaction,
    required super.line,
    required super.callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
  });

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

  static const typeValue = 'missed_call';

  factory MissedCallEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(
          eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return MissedCallEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      callee: json['callee'],
      caller: json['caller'],
      callerDisplayName: json['caller_display_name'],
    );
  }
}
