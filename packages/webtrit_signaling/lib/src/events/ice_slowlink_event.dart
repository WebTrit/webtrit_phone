import 'line_event.dart';
import 'ice_media_type.dart';

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
}
