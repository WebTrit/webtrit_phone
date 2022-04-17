import 'command.dart';

abstract class LineCommand extends Command {
  const LineCommand({
    required this.line,
  }) : super();

  final int line;

  @override
  List<Object?> get props => [
        line,
      ];
}
