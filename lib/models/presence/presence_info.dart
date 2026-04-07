import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'presence_activity.dart';

enum PresenceInfoSource { sip, direct }

class PresenceInfo extends Equatable {
  const PresenceInfo({
    required this.id,
    required this.number,
    required this.available,
    required this.note,
    required this.statusIcon,
    required this.device,
    required this.timeOffsetMin,
    required this.timestamp,
    required this.activities,
    required this.source,
    required this.arrivalTime,
  });

  final String id;
  final String number;
  final bool available;
  final String note;
  final String? statusIcon;
  final String? device;
  final int? timeOffsetMin;
  final DateTime? timestamp;
  final List<PresenceActivity> activities;
  final PresenceInfoSource source;
  final DateTime arrivalTime;

  @override
  List<Object?> get props => [
    id,
    number,
    available,
    note,
    statusIcon,
    device,
    timeOffsetMin,
    timestamp,
    activities,
    source,
    arrivalTime,
  ];

  @override
  String toString() {
    return 'PresenceInfo{id: $id, number: $number, available: $available, note: $note, statusIcon: $statusIcon, device: $device, '
        'timeOffsetMin: $timeOffsetMin, timestamp: $timestamp, activities: $activities, source: $source, arrivalTime: $arrivalTime}';
  }
}

extension PresenceInfoListExtension on Iterable<PresenceInfo> {
  bool get anyAvailable => any((p) => p.available);

  /// Returns the most relevant [PresenceInfo] based on availability, activities, and update time.
  /// The selection logic is as follows:
  /// 1. If any presence is "on the phone", return that one.
  /// 2. Otherwise, return the most recently updated available presence with activities.
  /// 3. If no available presence with activities, return the most recently updated available presence without activities.
  /// 4. If no available presence, return the most recently updated presence with activities.
  /// 5. If none of the above, return the most recently updated presence.
  PresenceInfo? get primary {
    if (isEmpty) return null;

    final firstInCall = firstWhereOrNull((p) => p.activities.contains(PresenceActivity.onThePhone));
    if (firstInCall != null) return firstInCall;

    final avaliable = where((p) => p.available);
    final avaliableWithActivity = avaliable.where((p) => p.activities.isNotEmpty);

    if (avaliableWithActivity.isNotEmpty) {
      return avaliableWithActivity.sortedByUpdate.first;
    }

    final avaliableWithoutActivity = avaliable.where((p) => p.activities.isEmpty);
    if (avaliableWithoutActivity.isNotEmpty) {
      return avaliableWithoutActivity.sortedByUpdate.first;
    }

    final remainsWithActivity = where((p) => p.activities.isNotEmpty);
    if (remainsWithActivity.isNotEmpty) {
      return remainsWithActivity.sortedByUpdate.first;
    }

    return sortedByUpdate.firstOrNull;
  }

  PresenceActivity? get primaryActivity {
    if (isEmpty) return null;

    final primaryPresence = primary;
    final inCall = primaryPresence?.activities.contains(PresenceActivity.onThePhone) ?? false;
    if (inCall) return PresenceActivity.onThePhone;
    return primaryPresence?.activities.firstOrNull;
  }

  String? get primaryStatusIcon {
    if (isEmpty) return null;
    final primaryPresence = primary;
    return primaryPresence?.statusIcon;
  }

  String? get primaryNote {
    if (isEmpty) return null;
    final primaryPresence = primary;
    return primaryPresence?.note;
  }

  List<PresenceInfo> get sortedByUpdate {
    final byUpdate = sorted((a, b) {
      final aTime = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });
    return byUpdate.toList();
  }
}
