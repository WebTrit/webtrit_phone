import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import 'package:webtrit_phone/extensions/iterable.dart';

enum Direction {
  incoming,
  outgoing,
}

typedef RecentId = int;

const recentIdPathParameterName = 'recentId';

// TODO: could be spit in two classes Recent and RecentExt which extend Recent
class Recent extends Equatable {
  final Direction direction;
  final String number;
  final bool video;
  final DateTime createdTime;
  final DateTime? acceptedTime;
  final DateTime? hungUpTime;
  final RecentId? id;
  final String? firstName;
  final String? lastName;
  final String? aliasName;
  final Uint8List? thumbnail;

  const Recent({
    required this.direction,
    required this.number,
    required this.video,
    required this.createdTime,
    this.acceptedTime,
    this.hungUpTime,
    this.id,
    this.firstName,
    this.lastName,
    this.aliasName,
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
    final aliasName = this.aliasName;
    if (aliasName != null) {
      return aliasName;
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
        firstName,
        lastName,
        aliasName,
        thumbnail,
      ];
}
