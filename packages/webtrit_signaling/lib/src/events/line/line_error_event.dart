import '../abstract_events.dart';

class LineErrorEvent extends LineEvent implements ErrorEvent {
  const LineErrorEvent({super.transaction, required super.line, required this.code, required this.reason});

  @override
  final int code;
  @override
  final String reason;

  @override
  List<Object?> get props => [...super.props, code, reason];

  @override
  Map<String, dynamic> toJson() => {...lineBaseJson(ErrorEvent.typeValue), 'code': code, 'reason': reason};

  static LineErrorEvent? tryFromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != ErrorEvent.typeValue) {
      return null;
    }

    // The server marks a line-scoped error by carrying the line, even when it
    // has no index to give (the guest line sends it as null). An error without
    // the field at all is session-scoped, and decoding it here would shadow
    // SessionErrorEvent, which is tried after this one.
    if (!json.containsKey('line')) {
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
