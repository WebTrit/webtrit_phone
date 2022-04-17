import 'line_command.dart';

class CallCommand extends LineCommand {
  const CallCommand({
    required int line,
    this.callId,
    required this.number,
    required this.jsep,
  }) : super(line: line);

  final String? callId;
  final String number;
  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        ...super.props,
        callId,
        number,
        jsep,
      ];
}
