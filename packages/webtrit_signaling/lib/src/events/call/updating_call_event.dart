import '../abstract_events.dart';

class UpdatingCallEvent extends CallEvent {
  const UpdatingCallEvent({
    super.transaction,
    required super.line,
    required super.callId,
    required this.callee,
    required this.caller,
    this.callerDisplayName,
    this.referredBy,
    this.replaceCallId,
    this.isFocus,
    this.jsep,
  });

  final String callee;
  final String caller;
  final String? callerDisplayName;
  final String? referredBy;
  final String? replaceCallId;
  final bool? isFocus;
  final Map<String, dynamic>? jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        callee,
        caller,
        callerDisplayName,
        referredBy,
        replaceCallId,
        isFocus,
        jsep,
      ];

  static const typeValue = 'updating_call';

  factory UpdatingCallEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(
          eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return UpdatingCallEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      callee: json['callee'],
      caller: json['caller'],
      callerDisplayName: json['caller_display_name'],
      referredBy: json['referred_by'],
      replaceCallId: json['replace_call_id'],
      isFocus: json['is_focus'],
      jsep: json['jsep'],
    );
  }
}
