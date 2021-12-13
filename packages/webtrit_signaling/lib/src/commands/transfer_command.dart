import 'command.dart';

class TransferCommand extends Command {
  TransferCommand({
    required this.number,
    this.replaceCallId,
  }) : super();

  final String number;
  final String? replaceCallId;

  @override
  List<Object?> get props => [
        number,
        replaceCallId,
      ];
}
