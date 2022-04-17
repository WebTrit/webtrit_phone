import 'line_command.dart';

class UpdateCommand extends LineCommand {
  const UpdateCommand({
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
