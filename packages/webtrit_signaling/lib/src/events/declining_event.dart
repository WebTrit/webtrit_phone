import 'call_event.dart';

class DecliningEvent extends CallEvent {
  const DecliningEvent({
    required int line,
    required String callId,
    required this.code,
    this.referId,
  }) : super(line: line, callId: callId);

  final int code;
  final int? referId;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        referId,
      ];

  static const event = 'declining';

  factory DecliningEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return DecliningEvent(
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
      referId: json['refer_id'],
    );
  }
}
