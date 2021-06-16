import 'command.dart';

class RegisterCommand extends Command {
  RegisterCommand(
    this.displayName,
  ) : super();

  final String displayName;

  @override
  List<Object?> get props => [
        displayName,
      ];
}
