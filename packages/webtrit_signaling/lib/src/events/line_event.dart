import 'session_event.dart';

abstract class LineEvent extends SessionEvent {
  const LineEvent({
    required String transaction,
    required this.line,
  }) : super(transaction: transaction);

  final int line;

  @override
  List<Object?> get props => [
        ...super.props,
        line,
      ];
}
