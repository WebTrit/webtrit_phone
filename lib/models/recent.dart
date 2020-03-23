import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

enum Direction {
  incoming,
  outgoing,
}

@immutable
class Recent extends Equatable {
  final Direction direction;
  final String username;
  final DateTime time;

  Recent(this.direction, this.username, this.time);

  @override
  List<Object> get props => [
        direction,
        username,
        time,
      ];
}
