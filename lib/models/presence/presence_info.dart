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

  PresenceActivity? get primaryActivity {
    if (isEmpty) return null;
    final presenceWithActivity = where((p) => p.activities.isNotEmpty);
    final inCall = presenceWithActivity.any((p) => p.activities.contains(PresenceActivity.onThePhone));
    if (inCall) return PresenceActivity.onThePhone;
    final byUpdate = sorted((a, b) {
      final aTime = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });
    return byUpdate.firstOrNull?.activities.firstOrNull;
  }

  String? get primaryStatusIcon {
    if (isEmpty) return null;
    final presenceWithIcon = where((p) => p.statusIcon != null && p.statusIcon!.isNotEmpty);
    if (presenceWithIcon.isEmpty) return null;
    final byUpdate = presenceWithIcon.sorted((a, b) {
      final aTime = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });
    return byUpdate.first.statusIcon;
  }

  String? get primaryNote {
    if (isEmpty) return null;
    final presenceWithNote = where((p) => p.note.isNotEmpty);
    if (presenceWithNote.isEmpty) return null;
    final byUpdate = presenceWithNote.sorted((a, b) {
      final aTime = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      final bTime = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
      return bTime.compareTo(aTime);
    });
    return byUpdate.first.note;
  }
}
