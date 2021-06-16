import 'command.dart';

class TrickleCommand extends Command {
  TrickleCommand(
    this.candidate,
  ) : super();

  final Map<String, dynamic>? candidate;

  @override
  List<Object?> get props => [
        candidate,
      ];
}
