import 'line_event.dart';

class IceHangupEvent extends LineEvent {
  const IceHangupEvent({
    required String transaction,
    required int line,
    this.reason,
  }) : super(transaction: transaction, line: line);

  final String? reason;

  @override
  List<Object?> get props => [
        ...super.props,
        reason,
      ];

  static const event = 'ice_hangup';

  factory IceHangupEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return IceHangupEvent(
      transaction: json['transaction'],
      line: json['line'],
      reason: json['reason'],
    );
  }
}
