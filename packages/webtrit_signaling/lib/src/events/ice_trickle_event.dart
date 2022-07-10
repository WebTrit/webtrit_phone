import 'call_event.dart';
import 'ice_media_type.dart';

class IceTrickleEvent extends CallEvent {
  const IceTrickleEvent({
    required String callId,
    required this.candidate,
  }) : super(callId: callId);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];

  static const event = 'ice_trickle';

  factory IceTrickleEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    final candidateJson = json['candidate'] as Map<String, dynamic>;
    if (candidateJson['completed'] == true) {
      return IceTrickleEvent(
        callId: json['call_id'],
        candidate: null,
      );
    } else {
      return IceTrickleEvent(
        callId: json['call_id'],
        candidate: candidateJson,
      );
    }
  }
}
