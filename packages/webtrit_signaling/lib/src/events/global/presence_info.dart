import 'package:equatable/equatable.dart';

enum SignalingPresenceInfoSource { sip, direct }

class SignalingPresenceInfo extends Equatable {
  const SignalingPresenceInfo({
    required this.id,
    required this.number,
    required this.available,
    required this.note,
    required this.statusIcon,
    required this.device,
    required this.timeOffsetMin,
    required this.timestamp,
    required this.activities,
    required this.arrivalTime,
    required this.source,
  });
  final String id;
  final String number;
  final bool available;
  final String note;
  final String? statusIcon;
  final String? device;
  final int? timeOffsetMin;
  final String? timestamp;
  final List<String> activities;
  final DateTime arrivalTime;
  final SignalingPresenceInfoSource source;

  factory SignalingPresenceInfo.fromJson(Map<String, dynamic> json) {
    final activities = (json['activities'] as List<dynamic>).map((e) => e as String).toList();

    return SignalingPresenceInfo(
      id: json['id'],
      number: json['number'],
      available: json['available'],
      note: json['note'],
      statusIcon: json['status_icon'],
      device: json['device'],
      timeOffsetMin: json['time_offset_min'],
      timestamp: json['timestamp'],
      activities: activities,
      arrivalTime: DateTime.parse(json['arrival_time'] as String),
      source: SignalingPresenceInfoSource.values.byName(json['source'] as String),
    );
  }

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
    arrivalTime,
    source,
  ];

  @override
  String toString() {
    return 'SignalingPresenceInfo{id: $id, number: $number, available: $available, note: $note, statusIcon: $statusIcon, device: $device, '
        'timeOffsetMin: $timeOffsetMin, timestamp: $timestamp, activities: $activities, arrivalTime: $arrivalTime, source: $source}';
  }
}
