import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

enum Direction {
  incoming,
  outgoing,
}

@immutable
class Recent extends Equatable {
  final Direction direction;
  final bool isComplete;
  final String username;
  final DateTime time;

  Recent(
    this.direction,
    this.isComplete,
    this.username,
    this.time,
  );

  @override
  List<Object> get props => [
        direction,
        isComplete,
        username,
        time,
      ];
}
