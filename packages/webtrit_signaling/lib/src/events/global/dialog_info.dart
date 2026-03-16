import 'package:equatable/equatable.dart';

enum SignalingDialogDirection { initiator, recipient }

enum SignalingDialogState { proceeding, early, confirmed, terminated, unknown }

class SignalingDialogInfo extends Equatable {
  const SignalingDialogInfo({
    required this.id,
    required this.entityNumber,
    required this.state,
    required this.callId,
    required this.direction,
    this.localTag,
    this.localNumber,
    this.localDisplayName,
    this.remoteTag,
    this.remoteNumber,
    this.remoteDisplayName,
    required this.arrivalVersion,
    required this.arrivalTime,
  });

  final String id;
  final String entityNumber;
  final SignalingDialogState state;
  final String? callId;
  final SignalingDialogDirection? direction;
  final String? localTag;
  final String? localNumber;
  final String? localDisplayName;
  final String? remoteTag;
  final String? remoteNumber;
  final String? remoteDisplayName;
  final String arrivalVersion;
  final DateTime arrivalTime;

  factory SignalingDialogInfo.fromJson(Map<String, dynamic> json) {
    return SignalingDialogInfo(
      id: json['id'],
      entityNumber: json['entity_number'],
      state: SignalingDialogState.values.byName(json['state']),
      callId: json['call_id'],
      direction: json['direction'] != null ? SignalingDialogDirection.values.byName(json['direction']) : null,
      localTag: json['local_tag'],
      localNumber: json['local_number'],
      localDisplayName: json['local_display_name'],
      remoteTag: json['remote_tag'],
      remoteNumber: json['remote_number'],
      remoteDisplayName: json['remote_display_name'],
      arrivalVersion: json['arrival_version'],
      arrivalTime: DateTime.parse(json['arrival_time'] as String),
    );
  }

  @override
  List<Object?> get props => [
    id,
    entityNumber,
    state,
    callId,
    direction,
    localTag,
    localNumber,
    localDisplayName,
    remoteTag,
    remoteNumber,
    remoteDisplayName,
    arrivalVersion,
    arrivalTime,
  ];

  @override
  String toString() {
    return 'SignalingDialogInfo{id: $id, entityNumber: $entityNumber, state: $state, callId: $callId, direction: $direction, localTag: $localTag, localNumber: $localNumber, localDisplayName: $localDisplayName, remoteTag: $remoteTag, remoteNumber: $remoteNumber, remoteDisplayName: $remoteDisplayName, arrivalVersion: $arrivalVersion, arrivalTime: $arrivalTime}';
  }
}
