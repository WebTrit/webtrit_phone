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
  final Duration duration;

  Recent(
    this.direction,
    this.isComplete,
    this.username,
    this.time,
    this.duration,
  );

  @override
  List<Object> get props => [
        direction,
        isComplete,
        username,
        time,
        duration,
      ];
}
