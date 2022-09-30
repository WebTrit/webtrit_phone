import 'event.dart';
import 'line_event.dart';

class IceHangupEvent extends LineEvent {
  const IceHangupEvent({
    String? transaction,
    required int line,
    this.reason,
  }) : super(transaction: transaction, line: line);

  final String? reason;

  @override
  List<Object?> get props => [
        ...super.props,
        reason,
      ];

  static const typeValue = 'ice_hangup';

  factory IceHangupEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return IceHangupEvent(
      transaction: json['transaction'],
      line: json['line'],
      reason: json['reason'],
    );
  }
}
