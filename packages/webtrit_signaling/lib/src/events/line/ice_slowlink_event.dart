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
  List<Object?> get props => [...super.props, mid, media, uplink, lost];

  static const typeValue = 'ice_slowlink';

  factory IceSlowLinkEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return IceSlowLinkEvent(
      transaction: json['transaction'],
      mid: json['mid'] as String? ?? '',
      line: json['line'],
      media: _parseMediaType(json['media']),
      uplink: json['uplink'] as bool? ?? false,
      lost: json['lost'] as int? ?? 0,
    );
  }

  static IceMediaType _parseMediaType(dynamic value) {
    if (value == null) return IceMediaType.audio;
    try {
      return IceMediaType.values.byName(value);
    } catch (_) {
      return IceMediaType.audio;
    }
  }
}
