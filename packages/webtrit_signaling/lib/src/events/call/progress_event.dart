import '../abstract_events.dart';

class ProgressEvent extends CallEvent {
  const ProgressEvent({
    super.transaction,
    required super.line,
    required super.callId,
    required this.callee,
    this.isFocus,
    required this.jsep,
  });

  final String callee;
  final bool? isFocus;
  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [...super.props, callee, isFocus, jsep];

  static const typeValue = 'progress';

  factory ProgressEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return ProgressEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      callee: json['callee'],
      isFocus: json['is_focus'],
      jsep: json['jsep'],
    );
  }
}
