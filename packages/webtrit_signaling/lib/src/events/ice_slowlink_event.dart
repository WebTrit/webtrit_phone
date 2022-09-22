import 'ice_media_type.dart';
import 'line_event.dart';

class IceSlowLinkEvent extends LineEvent {
  const IceSlowLinkEvent({
    required int line,
    required this.media,
    required this.uplink,
    required this.lost,
  }) : super(line: line);

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
      line: json['line'],
      media: IceMediaType.values.byName(json['media']),
      uplink: json['uplink'],
      lost: json['lost'],
    );
  }
}
