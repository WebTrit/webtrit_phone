import 'ice_media_type.dart';
import '../abstract_events.dart';

class IceSlowLinkEvent extends LineEvent {
  const IceSlowLinkEvent({
    String? transaction,
    required int line,
    required this.media,
    required this.uplink,
    required this.lost,
  }) : super(transaction: transaction, line: line);

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

  static const typeValue = 'ice_slowlink';

  factory IceSlowLinkEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return IceSlowLinkEvent(
      transaction: json['transaction'],
      line: json['line'],
      media: IceMediaType.values.byName(json['media']),
      uplink: json['uplink'],
      lost: json['lost'],
    );
  }
}
