import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/extensions/iterable.dart';

enum Direction {
  incoming,
  outgoing,
}

typedef RecentId = int;

// TODO: could be spit in two classes Recent and RecentExt which extend Recent
class Recent extends Equatable {
  final Direction direction;
  final String number;
  final bool video;
  final DateTime createdTime;
  final DateTime? acceptedTime;
  final DateTime? hungUpTime;
  final RecentId? id;
  final String? displayName;
  final String? firstName;
  final String? lastName;
  final Uint8List? thumbnail;

  const Recent({
    required this.direction,
    required this.number,
    required this.video,
    required this.createdTime,
    this.acceptedTime,
    this.hungUpTime,
    this.id,
    this.displayName,
    this.firstName,
    this.lastName,
    this.thumbnail,
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

  String get name {
    final displayName = this.displayName;
    if (displayName != null) {
      return displayName;
    } else {
      final name = [firstName, lastName].readableJoin();
      if (name.isNotEmpty) {
        return name;
      } else {
        return number;
      }
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
        displayName,
        firstName,
        lastName,
        thumbnail,
      ];
}
