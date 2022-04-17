import 'line_command.dart';

class TrickleCommand extends LineCommand {
  const TrickleCommand({
    required int line,
    this.candidate,
  }) : super(line: line);

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        ...super.props,
        candidate,
      ];
}
