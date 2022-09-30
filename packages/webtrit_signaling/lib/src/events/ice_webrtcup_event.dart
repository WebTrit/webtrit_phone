import 'event.dart';
import 'line_event.dart';

class IceWebrtcUpEvent extends LineEvent {
  const IceWebrtcUpEvent({
    String? transaction,
    required int line,
  }) : super(transaction: transaction, line: line);

  static const typeValue = 'ice_webrtcup';

  factory IceWebrtcUpEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return IceWebrtcUpEvent(
      transaction: json['transaction'],
      line: json['line'],
    );
  }
}
