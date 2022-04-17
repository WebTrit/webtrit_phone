import 'line_event.dart';
import 'ice_media_type.dart';

class IceMediaEvent extends LineEvent {
  const IceMediaEvent({
    required int line,
    required this.type,
    required this.receiving,
  }) : super(line: line);

  final IceMediaType type;
  final bool receiving;

  @override
  List<Object?> get props => [
        ...super.props,
        type,
        receiving,
      ];
}
