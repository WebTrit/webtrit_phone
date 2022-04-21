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

  static const event = 'ice_media';

  factory IceMediaEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return IceMediaEvent(
      line: json['line'],
      type: IceMediaType.values.byName(json['type']),
      receiving: json['receiving'],
    );
  }
}
