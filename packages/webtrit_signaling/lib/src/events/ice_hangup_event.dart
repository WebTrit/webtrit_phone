import 'line_event.dart';

class IceHangupEvent extends LineEvent {
  const IceHangupEvent({
    required int line,
    this.reason,
  }) : super(line: line);

  final String? reason;

  @override
  List<Object?> get props => [
        ...super.props,
        reason,
      ];
}
