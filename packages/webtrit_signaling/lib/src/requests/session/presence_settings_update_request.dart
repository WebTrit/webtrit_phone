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

  factory PresenceSettingsUpdateRequest.fromJson(Map<String, dynamic> json) {
    final transaction = json['transaction'] as String;
    final settingsJson = json['settings'] as Map<String, dynamic>;
    final settings = SignalingPresenceSettings.fromJson(settingsJson);
    return PresenceSettingsUpdateRequest(transaction: transaction, settings: settings);
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

  factory SignalingPresenceSettings.fromJson(Map<String, dynamic> json) {
    return SignalingPresenceSettings(
      available: json['available'] as bool,
      note: json['note'] as String,
      statusIcon: json['status_icon'] as String?,
      device: json['device'] as String,
      timeOffsetMin: json['time_offset_min'] as int,
      timestamp: json['timestamp'] as String,
      activity: json['activity'] as String?,
      dndMode: json['dnd_mode'] as bool,
    );
  }

  @override
  List<Object?> get props => [available, note, statusIcon, device, timeOffsetMin, timestamp, activity, dndMode];

  @override
  String toString() {
    return 'SignalingPresenceSettings{available: $available, note: $note, statusIcon: $statusIcon, device: $device, '
        'timeOffsetMin: $timeOffsetMin, timestamp: $timestamp, activity: $activity, dndMode: $dndMode}';
  }
}
