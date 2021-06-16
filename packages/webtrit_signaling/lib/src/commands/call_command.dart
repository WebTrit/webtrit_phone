import 'command.dart';

class CallCommand extends Command {
  CallCommand({
    this.callId,
    required this.number,
    required this.jsep,
  }) : super();

  final String? callId;
  final String number;
  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        callId,
        number,
        jsep,
      ];
}
