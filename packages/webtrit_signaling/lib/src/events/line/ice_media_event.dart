import 'ice_media_type.dart';
import '../abstract_events.dart';

class IceMediaEvent extends LineEvent {
  const IceMediaEvent({
    super.transaction,
    required super.line,
    required this.mid,
    required this.type,
    required this.receiving,
  });

  final String mid;
  final IceMediaType type;
  final bool receiving;

  @override
  List<Object?> get props => [
        ...super.props,
        mid,
        type,
        receiving,
      ];

  static const typeValue = 'ice_media';

  factory IceMediaEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(
          eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return IceMediaEvent(
      transaction: json['transaction'],
      line: json['line'],
      mid: json['mid'],
      type: IceMediaType.values.byName(json['type']),
      receiving: json['receiving'],
    );
  }
}
