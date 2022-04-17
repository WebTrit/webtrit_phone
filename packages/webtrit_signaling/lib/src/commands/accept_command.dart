import 'line_command.dart';

class AcceptCommand extends LineCommand {
  const AcceptCommand({
    required int line,
    required this.jsep,
  }) : super(line: line);

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        jsep,
      ];
}
