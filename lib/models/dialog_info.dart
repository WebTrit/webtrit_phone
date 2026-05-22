import 'package:equatable/equatable.dart';

enum DialogDirection { initiator, recipient }

enum DialogState { trying, proceeding, early, confirmed, terminated, unknown }

class DialogInfo extends Equatable {
  const DialogInfo({
    required this.id,
    required this.entityNumber,
    required this.state,
    required this.callId,
    required this.direction,
    required this.localTag,
    required this.localNumber,
    required this.localDisplayName,
    required this.remoteTag,
    required this.remoteNumber,
    required this.remoteDisplayName,
    required this.arrivalVersion,
    required this.arrivalTime,
  });

  final String id;
  final String entityNumber;
  final DialogState state;
  final String? callId;
  final DialogDirection? direction;
  final String? localTag;
  final String? localNumber;
  final String? localDisplayName;
  final String? remoteTag;
  final String? remoteNumber;
  final String? remoteDisplayName;
  final String arrivalVersion;
  final DateTime arrivalTime;

  String? get displayName => remoteDisplayName ?? remoteNumber;

  bool get pullable {
    if (state != DialogState.confirmed) return false;
    if (remoteNumber == null || callId == null || localTag == null || remoteTag == null) return false;
    return true;
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
    return 'DialogInfo{id: $id, entityNumber: $entityNumber, state: $state, callId: $callId, direction: $direction, localTag: $localTag, localNumber: $localNumber, localDisplayName: $localDisplayName, remoteTag: $remoteTag, remoteNumber: $remoteNumber, remoteDisplayName: $remoteDisplayName, arrivalVersion: $arrivalVersion, arrivalTime: $arrivalTime}';
  }
}
