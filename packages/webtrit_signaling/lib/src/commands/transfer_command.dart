import 'command.dart';

class TransferCommand extends Command {
  TransferCommand({
    required this.number,
    this.replace_call_id,
  }) : super();

  final String number;
  final String? replace_call_id;

  @override
  List<Object?> get props => [
        number,
        replace_call_id,
      ];
}
