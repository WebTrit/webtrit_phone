import 'call_event.dart';

class IceHangupEvent extends CallEvent {
  const IceHangupEvent({
    required String callId,
    this.reason,
  }) : super(callId: callId);

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
      callId: json['call_id'],
      reason: json['reason'],
    );
  }
}
