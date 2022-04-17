import 'line_command.dart';

enum HoldDirection {
  sendonly,
  recvonly,
  inactive,
}

class HoldCommand extends LineCommand {
  const HoldCommand({
    required int line,
    this.direction,
  }) : super(line: line);

  final HoldDirection? direction;

  @override
  List<Object?> get props => [
        ...super.props,
        direction,
      ];
}
