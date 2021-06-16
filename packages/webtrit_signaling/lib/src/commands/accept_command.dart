import 'command.dart';

class AcceptCommand extends Command {
  AcceptCommand({
    required this.jsep,
  }) : super();

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        jsep,
      ];
}
