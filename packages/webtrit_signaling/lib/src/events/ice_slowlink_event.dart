import 'call_event.dart';
import 'ice_media_type.dart';

class IceSlowLinkEvent extends CallEvent {
  const IceSlowLinkEvent({
    required String callId,
    required this.media,
    required this.uplink,
    required this.lost,
  }) : super(callId: callId);

  final IceMediaType media;
  final bool uplink;
  final int lost;

  @override
  List<Object?> get props => [
        ...super.props,
        media,
        uplink,
        lost,
      ];

  static const event = 'ice_slowlink';

  factory IceSlowLinkEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return IceSlowLinkEvent(
      callId: json['call_id'],
      media: IceMediaType.values.byName(json['media']),
      uplink: json['uplink'],
      lost: json['lost'],
    );
  }
}
