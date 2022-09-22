import 'line_event.dart';

class IceTrickleEvent extends LineEvent {
  const IceTrickleEvent({
    required int line,
    required this.candidate,
  }) : super(line: line);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];

  static const event = 'ice_trickle';

  factory IceTrickleEvent.fromJson(Map<String, dynamic> json) {
    final eventValue = json['event'];
    if (eventValue != event) {
      throw ArgumentError.value(eventValue, "event", "Not equal $event");
    }

    final candidateJson = json['candidate'] as Map<String, dynamic>;
    if (candidateJson['completed'] == true) {
      return IceTrickleEvent(
        line: json['line'],
        candidate: null,
      );
    } else {
      return IceTrickleEvent(
        line: json['line'],
        candidate: candidateJson,
      );
    }
  }
}
