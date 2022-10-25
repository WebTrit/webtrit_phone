import '../abstract_events.dart';

class IceTrickleEvent extends LineEvent {
  const IceTrickleEvent({
    String? transaction,
    required int line,
    required this.candidate,
  }) : super(transaction: transaction, line: line);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];

  static const typeValue = 'ice_trickle';

  factory IceTrickleEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    final candidateJson = json['candidate'] as Map<String, dynamic>;
    if (candidateJson['completed'] == true) {
      return IceTrickleEvent(
        transaction: json['transaction'],
        line: json['line'],
        candidate: null,
      );
    } else {
      return IceTrickleEvent(
        transaction: json['transaction'],
        line: json['line'],
        candidate: candidateJson,
      );
    }
  }
}
