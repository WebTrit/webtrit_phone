import 'event.dart';
import 'ice_media_type.dart';

class IceMediaEvent extends Event {
  IceMediaEvent({
    required this.type,
    required this.receiving,
  }) : super();

  final IceMediaType type;
  final bool receiving;

  @override
  List<Object?> get props => [
        type,
        receiving,
      ];
}
