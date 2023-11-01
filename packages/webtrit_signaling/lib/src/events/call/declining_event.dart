import '../abstract_events.dart';

class DecliningEvent extends CallEvent {
  const DecliningEvent({
    super.transaction,
    required super.line,
    required super.callId,
    required this.code,
    this.referId,
  });

  final int code;
  final int? referId;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        referId,
      ];

  static const typeValue = 'declining';

  factory DecliningEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return DecliningEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      code: json['code'],
      referId: json['refer_id'],
    );
  }
}
