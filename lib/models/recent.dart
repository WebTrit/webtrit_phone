import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

enum Direction {
  incoming,
  outgoing,
}

@immutable
class Recent extends Equatable {
  final Direction direction;
  final String number;
  final bool video;
  final DateTime createdTime;
  final DateTime? acceptedTime;
  final DateTime? hungUpTime;
  final int? id;

  const Recent({
    required this.direction,
    required this.number,
    required this.video,
    required this.createdTime,
    this.acceptedTime,
    this.hungUpTime,
    this.id,
  });

  bool get isComplete => acceptedTime != null;

  Duration? get duration {
    final hungUpTime = this.hungUpTime;
    final acceptedTime = this.acceptedTime;
    if (hungUpTime != null && acceptedTime != null) {
      return hungUpTime.difference(acceptedTime);
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props => [
        direction,
        number,
        video,
        createdTime,
        acceptedTime,
        hungUpTime,
        id,
      ];
}
