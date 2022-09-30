import 'call_event.dart';
import 'event.dart';

class AcceptedEvent extends CallEvent {
  const AcceptedEvent({
    String? transaction,
    required int line,
    required String callId,
    this.callee,
    this.isFocus,
    this.jsep,
  }) : super(transaction: transaction, line: line, callId: callId);

  final String? callee;
  final bool? isFocus;
  final Map<String, dynamic>? jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        callee,
        isFocus,
        jsep,
      ];

  static const typeValue = 'accepted';

  factory AcceptedEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return AcceptedEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      callee: json['callee'],
      isFocus: json['is_focus'],
      jsep: json['jsep'],
    );
  }

  static MapEntry<String, CallEvent Function(Map<String, dynamic>)> d() => MapEntry(typeValue, AcceptedEvent.fromJson);
}
