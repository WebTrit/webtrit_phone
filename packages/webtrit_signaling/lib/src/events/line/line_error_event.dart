import '../abstract_events.dart';

class LineErrorEvent extends LineEvent implements ErrorEvent {
  const LineErrorEvent({
    super.transaction,
    required super.line,
    required this.code,
    required this.reason,
  });

  @override
  final int code;
  @override
  final String reason;

  @override
  List<Object?> get props => [
        ...super.props,
        code,
        reason,
      ];

  static LineErrorEvent? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != ErrorEvent.typeValue) {
      return null;
    }

    try {
      return LineErrorEvent(
        transaction: json['transaction'],
        line: json['line'],
        code: json['code'],
        reason: json['reason'],
      );
    } on TypeError {
      return null;
    }
  }
}
