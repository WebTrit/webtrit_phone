import 'command.dart';

class UpdateCommand extends Command {
  UpdateCommand({
    required this.jsep,
  }) : super();

  final Map<String, dynamic> jsep;

  @override
  List<Object?> get props => [
        jsep,
      ];
}
