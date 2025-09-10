import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'presence_activity.dart';

class PresenceInfo extends Equatable {
  const PresenceInfo({
    required this.id,
    required this.available,
    required this.note,
    required this.statusIcon,
    required this.device,
    required this.timeOffsetMin,
    required this.timestamp,
    required this.activities,
  });

  final String id;
  final bool available;
  final String note;
  final String? statusIcon;
  final String? device;
  final int? timeOffsetMin;
  final DateTime? timestamp;
  final List<PresenceActivity> activities;

  @override
  List<Object?> get props => [id, available, note, statusIcon, device, timeOffsetMin, timestamp, activities];

  @override
  String toString() {
    return 'PresenceInfo{id: $id, available: $available, note: $note, statusIcon: $statusIcon, device: $device, '
        'timeOffsetMin: $timeOffsetMin, timestamp: $timestamp, activities: $activities}';
  }
}

extension PresenceInfoListExtension on Iterable<PresenceInfo> {
  bool get anyAvailable => any((p) => p.available);

  PresenceActivity? get primaryActivity {
    if (isEmpty) return null;
    final presenceWithActivity = where((p) => p.activities.isNotEmpty);
    final inCall = presenceWithActivity.any((p) => p.activities.contains(PresenceActivity.onThePhone));
    if (inCall) return PresenceActivity.onThePhone;
    final byUpdate = sorted(
      (a, b) {
        final aTime = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      },
    );
    return byUpdate.firstOrNull?.activities.firstOrNull;
  }

  String? get primaryStatusIcon {
    if (isEmpty) return null;
    final presenceWithIcon = where((p) => p.statusIcon != null && p.statusIcon!.isNotEmpty);
    if (presenceWithIcon.isEmpty) return null;
    final byUpdate = presenceWithIcon.sorted(
      (a, b) {
        final aTime = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      },
    );
    return byUpdate.first.statusIcon;
  }

  String? get primaryNote {
    if (isEmpty) return null;
    final presenceWithNote = where((p) => p.note.isNotEmpty);
    if (presenceWithNote.isEmpty) return null;
    final byUpdate = presenceWithNote.sorted(
      (a, b) {
        final aTime = a.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
        final bTime = b.timestamp ?? DateTime.fromMillisecondsSinceEpoch(0);
        return bTime.compareTo(aTime);
      },
    );
    return byUpdate.first.note;
  }
}
