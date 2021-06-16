import 'event.dart';
import 'ice_media_type.dart';

class IceSlowLinkEvent extends Event {
  IceSlowLinkEvent({
    required this.media,
    required this.uplink,
    required this.lost,
  }) : super();

  final IceMediaType media;
  final bool uplink;
  final int lost;

  @override
  List<Object?> get props => [
        media,
        uplink,
        lost,
      ];
}
