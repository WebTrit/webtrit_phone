import 'ice_media_type.dart';
import 'line_event.dart';

class IceMediaEvent extends LineEvent {
  const IceMediaEvent({
    required String transaction,
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

  static const event = 'ice_media';

  factory IceMediaEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    return IceMediaEvent(
      transaction: json['transaction'],
      line: json['line'],
      type: IceMediaType.values.byName(json['type']),
      receiving: json['receiving'],
    );
  }
}
