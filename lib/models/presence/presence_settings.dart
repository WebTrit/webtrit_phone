import 'package:equatable/equatable.dart';

import 'presence_activity.dart';

class PresenceSettings extends Equatable {
  const PresenceSettings({
    required this.available,
    required this.note,
    required this.statusIcon,
    required this.device,
    required this.timeOffsetMin,
    required this.timestamp,
    required this.activity,
    required this.dndMode,
  });

  final bool available;
  final String note;
  final String? statusIcon;
  final String device;
  final int timeOffsetMin;
  final DateTime timestamp;
  final PresenceActivity? activity;
  final bool dndMode;

  factory PresenceSettings.blank({required String device}) {
    return PresenceSettings(
      available: true,
      note: '',
      statusIcon: null,
      device: device,
      timeOffsetMin: _timeOffsetMin,
      timestamp: _timestamp,
      activity: null,
      dndMode: false,
    );
  }

  PresenceSettings copyWithAvailable(bool available) {
    return PresenceSettings(
      available: available,
      note: note,
      statusIcon: statusIcon,
      device: device,
      timeOffsetMin: _timeOffsetMin,
      timestamp: _timestamp,
      activity: activity,
      dndMode: dndMode,
    );
  }

  PresenceSettings copyWithNote(String note) {
    return PresenceSettings(
      available: available,
      note: note,
      statusIcon: statusIcon,
      device: device,
      timeOffsetMin: _timeOffsetMin,
      timestamp: _timestamp,
      activity: activity,
      dndMode: dndMode,
    );
  }

  PresenceSettings copyWithStatusIcon(String? statusIcon) {
    return PresenceSettings(
      available: available,
      note: note,
      statusIcon: statusIcon,
      device: device,
      timeOffsetMin: _timeOffsetMin,
      timestamp: _timestamp,
      activity: activity,
      dndMode: dndMode,
    );
  }

  PresenceSettings copyWithActivity(PresenceActivity? activity) {
    return PresenceSettings(
      available: available,
      note: note,
      statusIcon: statusIcon,
      device: device,
      timeOffsetMin: _timeOffsetMin,
      timestamp: _timestamp,
      activity: activity,
      dndMode: dndMode,
    );
  }

  PresenceSettings copyWithDndMode(bool dndMode) {
    return PresenceSettings(
      available: available,
      note: note,
      statusIcon: statusIcon,
      device: device,
      timeOffsetMin: _timeOffsetMin,
      timestamp: _timestamp,
      activity: activity,
      dndMode: dndMode,
    );
  }

  @override
  List<Object?> get props => [available, note, statusIcon, device, timeOffsetMin, timestamp, activity, dndMode];

  @override
  String toString() {
    return 'PresenceSettings{available: $available, note: $note, statusIcon: $statusIcon, device: $device, '
        'timeOffsetMin: $timeOffsetMin, timestamp: $timestamp, activity: $activity, dndMode: $dndMode}';
  }

  static int get _timeOffsetMin => DateTime.now().timeZoneOffset.inMinutes;

  static DateTime get _timestamp => DateTime.now();
}
