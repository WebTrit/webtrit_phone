import 'call_event.dart';

class IceWebrtcUpEvent extends CallEvent {
  const IceWebrtcUpEvent({
    required String callId,
  }) : super(callId: callId);

  static const event = 'ice_webrtcup';

  factory IceWebrtcUpEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return IceWebrtcUpEvent(
      callId: json['call_id'],
    );
  }
}
