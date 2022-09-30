import 'event.dart';
import 'ice_media_type.dart';
import 'line_event.dart';

class IceMediaEvent extends LineEvent {
  const IceMediaEvent({
    String? transaction,
    required int line,
    required this.type,
    required this.receiving,
  }) : super(transaction: transaction, line: line);

  final IceMediaType type;
  final bool receiving;

  @override
  List<Object?> get props => [
        ...super.props,
        type,
        receiving,
      ];

  static const typeValue = 'ice_media';

  factory IceMediaEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    return IceMediaEvent(
      transaction: json['transaction'],
      line: json['line'],
      type: IceMediaType.values.byName(json['type']),
      receiving: json['receiving'],
    );
  }
}
