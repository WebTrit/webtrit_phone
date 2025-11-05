import 'package:equatable/equatable.dart';

import '../abstract_requests.dart';

class PresenceSettingsUpdateRequest extends SessionRequest {
  const PresenceSettingsUpdateRequest({required super.transaction, required this.settings});

  final SignalingPresenceSettings settings;

  @override
  List<Object?> get props => [...super.props, settings];

  static const typeValue = 'presence_update';

  @override
  Map<String, dynamic> toJson() {
    return {Request.typeKey: typeValue, 'transaction': transaction, 'settings': settings.toJson()};
  }
}

class SignalingPresenceSettings extends Equatable {
  const SignalingPresenceSettings({
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
  final String timestamp;
  final String? activity;
  final bool dndMode;

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'note': note,
      'status_icon': statusIcon,
      'device': device,
      'time_offset_min': timeOffsetMin,
      'timestamp': timestamp,
      'activity': activity,
      'dnd_mode': dndMode,
    };
  }

  @override
  List<Object?> get props => [available, note, statusIcon, device, timeOffsetMin, timestamp, activity, dndMode];

  @override
  String toString() {
    return 'SignalingPresenceSettings{available: $available, note: $note, statusIcon: $statusIcon, device: $device, '
        'timeOffsetMin: $timeOffsetMin, timestamp: $timestamp, activity: $activity, dndMode: $dndMode}';
  }
}
