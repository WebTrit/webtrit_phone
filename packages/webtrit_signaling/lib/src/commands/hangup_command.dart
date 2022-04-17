import 'line_command.dart';

class HangupCommand extends LineCommand {
  const HangupCommand({
    required int line,
  }) : super(line: line);
}
