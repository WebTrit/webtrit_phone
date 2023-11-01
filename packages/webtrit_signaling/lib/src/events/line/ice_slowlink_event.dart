import 'ice_media_type.dart';
import '../abstract_events.dart';

class IceSlowLinkEvent extends LineEvent {
  const IceSlowLinkEvent({
    super.transaction,
    required super.line,
    required this.mid,
    required this.media,
    required this.uplink,
    required this.lost,
  });

  final String mid;
  final IceMediaType media;
  final bool uplink;
  final int lost;

  @override
  List<Object?> get props => [
        ...super.props,
        mid,
        media,
        uplink,
        lost,
      ];

  static const typeValue = 'ice_slowlink';

  factory IceSlowLinkEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return IceSlowLinkEvent(
      transaction: json['transaction'],
      mid: json['mid'],
      line: json['line'],
      media: IceMediaType.values.byName(json['media']),
      uplink: json['uplink'],
      lost: json['lost'],
    );
  }
}
