import 'line_command.dart';

class TransferCommand extends LineCommand {
  const TransferCommand({
    required int line,
    required this.number,
    this.replaceCallId,
  }) : super(line: line);

  final String number;
  final String? replaceCallId;

  @override
  List<Object?> get props => [
        ...super.props,
        number,
        replaceCallId,
      ];
}
