import 'command.dart';

enum HoldDirection {
  sendonly,
  recvonly,
  inactive,
}

class HoldCommand extends Command {
  HoldCommand({
    this.direction,
  }) : super();

  final HoldDirection? direction;

  @override
  List<Object?> get props => [
        direction,
      ];
}
